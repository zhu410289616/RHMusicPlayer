//
//  RHDOUMusicPlaybackService.m
//  Example
//
//  Created by zhuruhong on 16/7/21.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import "RHDOUMusicPlaybackService.h"
#import "RHMusicPlaybackQueue.h"
#import "RHMusicNowPlayingInformation.h"
#import "RHMusicRemoteCommander.h"
#import "NSString+Music.h"
#import "NSFileManager+Music.h"

static void *kStatusKVOKey = &kStatusKVOKey;
static void *kDurationKVOKey = &kDurationKVOKey;
static void *kBufferingRatioKVOKey = &kBufferingRatioKVOKey;

@interface RHDOUMusicPlaybackService ()

@property (nonatomic, strong) RHMusicNowPlayingInformation *nowPlaying;
@property (nonatomic, strong) RHMusicRemoteCommander *remoteControl;

@property (nonatomic, strong) DOUAudioStreamer *player;
@property (nonatomic, strong) RHMusicItem *currentMusicItem;

@end

@implementation RHDOUMusicPlaybackService

+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)dealloc
{
    // also handled in stop
    self.nowPlaying = nil;
    self.remoteControl = nil;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self commonInitForDOUMusicPlaybackService];
    }
    return self;
}

- (DOUAudioStreamer *)player
{
    return _player;
}

- (RHMusicItem *)currentMusicItem
{
    return _currentMusicItem;
}

- (void)playMusic:(RHMusicItem *)musicItem
{
    NSInteger index = [self.queueManager indexOfQueue:musicItem];
    if (index < 0) {
        return;
    }
    
    RHMusicItem *selectItem = [self.queueManager.currentQueue assetForIndex:index];
    if (musicItem.musicPath.length == 0) {
        return;
    }
    
    [self.player pause];
    self.currentMusicItem = selectItem;
    [self prepareToPlay];
}

#pragma mark - Public behavior

- (void)play
{
    if (NO == [self.queueManager queueHasItems]) {
        return;
    }
    [self resumePlayback];
}

- (void)pause
{
    [self pausePlayback];
}

- (BOOL)isPlaying
{
    return (self.player && self.player.status == DOUAudioStreamerPlaying);
}

- (void)togglePlayPause
{
    if (YES == [self isPlaying]) {
        [self pausePlayback];
        return;
    }
    [self resumePlayback];
}

- (void)next
{
    [self skipToNextItem];
}

- (void)previous
{
    NSTimeInterval currentPlaybackTime = self.player.currentTime;
    if (SystemMusicPlaybackServiceStartThreshold >= currentPlaybackTime) {
        [self skipToPreviousItem];
        return;
    }
    [self skipToBeginning];
}

- (void)stop
{
    [self cancelPlay];
    
    self.nowPlaying = nil;
    self.remoteControl = nil;
}

#pragma mark - Private behavior

- (void)commonInitForDOUMusicPlaybackService
{
    _nowPlaying = [[RHMusicNowPlayingInformation alloc] initWithPlaybackQueueManager:self.queueManager];
    _remoteControl = [[RHMusicRemoteCommander alloc] initWithService:self];
}

- (void)pausePlayback
{
    [self.player pause];
}

- (void)resumePlayback
{
    if ([self isPlaying]) {
        return;
    }
    
    if (RHMusicPlaybackQueueIndexStopped == self.queueManager.currentQueue.indexOfCurrentMusicItem) {
        [self skipToNextItem];
        return;
    }
    
    [self.player play];
}

- (void)skipToBeginning
{
    [self.player setCurrentTime:0];
    [self.player play];
}

- (void)skipToNextItem
{
    [self.player pause];
    self.currentMusicItem = [self.queueManager.currentQueue nextMusicItem];
    [self prepareToPlay];
}

- (void)skipToPreviousItem
{
    [self.player pause];
    self.currentMusicItem = [self.queueManager.currentQueue previousMusicItem];
    [self prepareToPlay];
}

- (void)prepareToPlay
{
    [self cancelPlay];
    
    self.player = [DOUAudioStreamer streamerWithAudioFile:self.currentMusicItem];
    [self.player addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:kStatusKVOKey];
    [self.player addObserver:self forKeyPath:@"duration" options:NSKeyValueObservingOptionNew context:kDurationKVOKey];
    [self.player addObserver:self forKeyPath:@"bufferingRatio" options:NSKeyValueObservingOptionNew context:kBufferingRatioKVOKey];
    
    [self.player play];
}

- (void)cancelPlay
{
    if (self.player) {
        [self.player stop];
        [self.player removeObserver:self forKeyPath:@"status"];
        [self.player removeObserver:self forKeyPath:@"duration"];
        [self.player removeObserver:self forKeyPath:@"bufferingRatio"];
        self.player = nil;
    }
}

- (void)setupHintForStreamer
{
    NSInteger nextIndex = [self.queueManager.currentQueue nextItemIndex];
    RHMusicItem *nextItem = [self.queueManager.currentQueue musicItemAtIndex:nextIndex];
    [DOUAudioStreamer setHintWithAudioFile:nextItem];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (context == kStatusKVOKey) {
        [self performSelector:@selector(_updateStatus)
                     onThread:[NSThread mainThread]
                   withObject:nil
                waitUntilDone:NO];
    }
    else if (context == kDurationKVOKey) {
        [self performSelector:@selector(_timerAction:)
                     onThread:[NSThread mainThread]
                   withObject:nil
                waitUntilDone:NO];
    }
    else if (context == kBufferingRatioKVOKey) {
        [self performSelector:@selector(_updateBufferingStatus)
                     onThread:[NSThread mainThread]
                   withObject:nil
                waitUntilDone:NO];
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)_updateStatus
{
    switch ([self.player status]) {
        case DOUAudioStreamerPlaying:
            NSLog(@"DOUAudioStreamerPlaying");
            [self.queueManager broadcastNowPlayingItemChange];
            break;
            
        case DOUAudioStreamerPaused:
            NSLog(@"DOUAudioStreamerPaused");
            break;
            
        case DOUAudioStreamerIdle:
            NSLog(@"DOUAudioStreamerIdle");
            break;
            
        case DOUAudioStreamerFinished:
            NSLog(@"DOUAudioStreamerFinished");
            [self next];
            break;
            
        case DOUAudioStreamerBuffering:
            NSLog(@"DOUAudioStreamerBuffering");
            break;
            
        case DOUAudioStreamerError:
            NSLog(@"DOUAudioStreamerError");
            break;
    }
}

- (void)_timerAction:(id)timer
{
    NSLog(@"duration: %f, currentTime: %f", self.player.duration, self.player.currentTime);
}

- (void)_updateBufferingStatus
{
    NSString *buffering = [NSString stringWithFormat:@"Received %.2f/%.2f MB (%.2f %%), Speed %.2f MB/s", (double)[self.player receivedLength] / 1024 / 1024, (double)[self.player expectedLength] / 1024 / 1024, [self.player bufferingRatio] * 100.0, (double)[self.player downloadSpeed] / 1024 / 1024];
    NSLog(@"buffering: %@", buffering);
    
    if ([self.player bufferingRatio] >= 1.0) {
        NSLog(@"sha256: %@, cachedPath: %@", [self.player sha256], [self.player cachedPath]);
        
        @synchronized (self) {
            NSString *documentDir = [NSFileManager rh_documentDirectory];
            NSString *cacheDir = [NSFileManager rh_pathWithFilePath:[NSString stringWithFormat:@"%@/music", documentDir]];
            
            NSString *cacheName = [NSString rh_stringWithMD5Encode:self.currentMusicItem.musicPath];
            NSString *cacheFile = [NSString stringWithFormat:@"%@/%@", cacheDir, cacheName];
            
            NSError *error;
            if ([[NSFileManager defaultManager] fileExistsAtPath:cacheFile isDirectory:NULL]) {
                return;
            }
            
            [[NSFileManager defaultManager] moveItemAtPath:[self.player cachedPath] toPath:cacheFile error:&error];
            if (error) {
                NSLog(@"error: %@", error);
            }
        }
        
    }
}

@end
