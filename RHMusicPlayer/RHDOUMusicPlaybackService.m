//
//  RHDOUMusicPlaybackService.m
//  Example
//
//  Created by zhuruhong on 16/7/21.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import "RHDOUMusicPlaybackService.h"
#import "RHMusicPlaybackQueue.h"
#import "RHMusicPlaybackQueueManager.h"
#import "RHMusicNowPlayingInformation.h"
#import "RHMusicRemoteCommander.h"

@interface RHDOUMusicPlaybackService ()

@property (nonatomic, strong) RHMusicPlaybackQueueManager *queueManager;
@property (nonatomic, strong) RHMusicNowPlayingInformation *nowPlaying;
@property (nonatomic, strong) RHMusicRemoteCommander *remoteControl;

//@property (nonatomic, strong) 

@end

@implementation RHDOUMusicPlaybackService

- (void)dealloc
{}

- (instancetype)init
{
    if (self = [super init]) {
        [self commonInitForMusicPlaybackController];
    }
    return self;
}

#pragma mark - Public behavior

- (void)play
{
    if (NO == [self.queueManager queueHasItems])
    {
        return;
    }
//    [self resumePlayback];
}

- (void)pause
{
//    [self pausePlayback];
}

//- (BOOL)isPlaying
//{
//    return (self.player.rate != 0.0f);
//}

- (void)togglePlayPause
{
//    if (YES == [self isPlaying])
//    {
//        [self pausePlayback];
//        return;
//    }
//    [self resumePlayback];
}

- (void)next
{
//    [self skipToNextItem];
}

- (void)previous
{
//    CMTime currentPlaybackTime = self.currentPlayerItem.currentTime;
//    if (SystemMusicPlaybackControllerStartThreshold >= CMTimeGetSeconds(currentPlaybackTime))
//    {
//        [self skipToPreviousItem];
//        return;
//    }
//    [self skipToBeginning];
}

- (void)stop
{
//    [self.player pause];
//    [self.player seekToTime:kCMTimeZero];
//    [self.player replaceCurrentItemWithPlayerItem:nil];
    
    self.nowPlaying = nil;
    self.remoteControl = nil;
}

#pragma mark - Private behavior

- (void)commonInitForMusicPlaybackController
{
//    _player = [AVPlayer playerWithPlayerItem:nil];
//    _player.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    
    _nowPlaying = [[RHMusicNowPlayingInformation alloc] initWithPlaybackQueueManager:self.queueManager];
    _remoteControl = [[RHMusicRemoteCommander alloc] initWithService:self];
}

@end
