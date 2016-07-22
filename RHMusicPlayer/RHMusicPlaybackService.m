//
//  RHMusicPlaybackService.m
//  Example
//
//  Created by zhuruhong on 16/7/21.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import "RHMusicPlaybackService.h"
#import "RHAudioSessionMonitor.h"

NSTimeInterval const SystemMusicPlaybackServiceStartThreshold = 4.0f;

@interface RHMusicPlaybackService ()

@property (nonatomic, strong) RHAudioSessionMonitor *audioSessionMonitor;

@end

@implementation RHMusicPlaybackService

- (instancetype)init
{
    if (self = [super init]) {
        _audioSessionMonitor = [[RHAudioSessionMonitor alloc] initWithService:self];
        _queueManager = [[RHMusicPlaybackQueueManager alloc] init];
    }
    return self;
}

#pragma mark - RHMusicPlayback

- (void)play
{}

- (void)pause
{}

- (BOOL)isPlaying
{
    return NO;
}

- (void)togglePlayPause
{}

- (void)next
{}

- (void)previous
{}

- (void)stop
{}

@end
