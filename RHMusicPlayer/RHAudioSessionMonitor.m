//
//  RHAudioSessionMonitor.m
//  Example
//
//  Created by zhuruhong on 16/7/22.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import "RHAudioSessionMonitor.h"
#import "RHAudioSessionCoordinator.h"
#import "RHMusicPlaybackService.h"
#import <AVFoundation/AVFoundation.h>

@interface RHAudioSessionMonitor ()

@property (nonatomic, strong) RHAudioSessionCoordinator *audioSessionCoordinator;

@property (nonatomic, weak) RHMusicPlaybackService *playbackService;

@end

@implementation RHAudioSessionMonitor

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self reset];
    
    self.audioSessionCoordinator = nil;
}

- (instancetype)initWithService:(RHMusicPlaybackService *)service
{
    if (self = [super init]) {
        self.playbackService = service;
        [self commonInitForRHAudioSessionService];
    }
    return self;
}

- (void)commonInitForRHAudioSessionService
{
    _audioSessionCoordinator = [[RHAudioSessionCoordinator alloc] init];
    [self.audioSessionCoordinator activateSharedAudioSession];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(audioRouteChanged:)
                                                 name:AVAudioSessionRouteChangeNotification
                                               object:[AVAudioSession sharedInstance]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(audioSessionInterrupted:)
                                                 name:AVAudioSessionInterruptionNotification
                                               object:[AVAudioSession sharedInstance]];
}

- (void)reset
{
    if ([self.playbackService isPlaying]) {
        [self.playbackService stop];
    }
    [self.audioSessionCoordinator deactivateSharedAudioSession];
}

#pragma mark - NSNotification handlers

- (void)audioRouteChanged:(NSNotification *)notification
{
    AVAudioSessionRouteChangeReason	routeChangeReason = [notification.userInfo[AVAudioSessionRouteChangeReasonKey] unsignedIntegerValue];
    NSLog(@"%s - %@ (%lu)", __PRETTY_FUNCTION__, notification, (unsigned long)routeChangeReason);
    
    if (AVAudioSessionRouteChangeReasonOldDeviceUnavailable != routeChangeReason) {
        return;
    }
    
    AVAudioSessionRouteDescription *previousRoute = notification.userInfo[AVAudioSessionRouteChangePreviousRouteKey];
    AVAudioSessionPortDescription *previousOutput = previousRoute.outputs.firstObject;
    NSString *portType = previousOutput.portType;
    
    if ([AVAudioSessionPortHeadphones isEqualToString:portType]) {
        [self.playbackService pause];
    }
}

- (void)audioSessionInterrupted:(NSNotification *)notification
{
    AVAudioSessionInterruptionType interruptionType = [notification.userInfo[AVAudioSessionInterruptionTypeKey] unsignedIntegerValue];
    NSLog(@"%s - %@ (%lu)", __PRETTY_FUNCTION__, notification, (unsigned long)interruptionType);
    
    if (AVAudioSessionInterruptionTypeBegan == interruptionType) {
        NSLog(@"%s - interruption BEGAN...", __PRETTY_FUNCTION__);
        [self.playbackService pause];
        return;
    }
    
    NSLog(@"%s - interruption END...", __PRETTY_FUNCTION__);
    AVAudioSessionInterruptionOptions interruptionOptions = [notification.userInfo[AVAudioSessionInterruptionOptionKey] unsignedIntegerValue];
    if (AVAudioSessionInterruptionOptionShouldResume == interruptionOptions) {
        NSLog(@"%s - resuming playback...", __PRETTY_FUNCTION__);
        [self.playbackService play];
    }
}

@end
