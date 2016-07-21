//
//  RHMusicRemoteCommander.m
//  Example
//
//  Created by zhuruhong on 16/7/21.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import "RHMusicRemoteCommander.h"
#import "RHMusicPlaybackService.h"
#import <MediaPlayer/MediaPlayer.h>

@interface RHMusicRemoteCommander ()

@property (nonatomic, weak) RHMusicPlaybackService *service;

@end

@implementation RHMusicRemoteCommander

- (void)dealloc
{
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
}

- (instancetype)initWithService:(RHMusicPlaybackService *)service
{
    if (self = [super init]) {
        _service = service;
        [self commonInitForMusicRemoteCommander];
    }
    return self;
}

- (void)commonInitForMusicRemoteCommander
{
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    MPRemoteCommandCenter *commandCenter = [MPRemoteCommandCenter sharedCommandCenter];
    
    // triggered by headphones
    [commandCenter.togglePlayPauseCommand addTarget:self action:@selector(togglePlayPauseCommandIssued:)];
    
    // triggered by Control Center
    [commandCenter.pauseCommand addTarget:self action:@selector(pauseCommandIssued:)];
    [commandCenter.playCommand addTarget:self action:@selector(playCommandIssued:)];
    
    [commandCenter.nextTrackCommand addTarget:self action:@selector(nextTrackCommandIssued:)];
    [commandCenter.previousTrackCommand addTarget:self action:@selector(previousTrackCommandIssued:)];
}

#pragma mark - MPRemoteCommandHandlers

- (MPRemoteCommandHandlerStatus)playCommandIssued:(MPRemoteCommandEvent *)commandEvent
{
    [_service play];
    return MPRemoteCommandHandlerStatusSuccess;
}

- (MPRemoteCommandHandlerStatus)pauseCommandIssued:(MPRemoteCommandEvent *)commandEvent
{
    [_service pause];
    return MPRemoteCommandHandlerStatusSuccess;
}

- (MPRemoteCommandHandlerStatus)togglePlayPauseCommandIssued:(MPRemoteCommandEvent *)commandEvent
{
    [_service togglePlayPause];
    return MPRemoteCommandHandlerStatusSuccess;
}

- (MPRemoteCommandHandlerStatus)nextTrackCommandIssued:(MPRemoteCommandEvent *)commandEvent
{
    [_service next];
    return MPRemoteCommandHandlerStatusSuccess;
}

- (MPRemoteCommandHandlerStatus)previousTrackCommandIssued:(MPRemoteCommandEvent *)commandEvent
{
    [_service previous];
    return MPRemoteCommandHandlerStatusSuccess;
}

@end
