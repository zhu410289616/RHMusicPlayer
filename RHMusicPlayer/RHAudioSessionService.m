//
//  RHAudioSessionService.m
//  Example
//
//  Created by zhuruhong on 16/7/21.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import "RHAudioSessionService.h"
#import "RHAudioSessionCoordinator.h"
#import "RHMusicPlaybackConfiguration.h"
#import "RHDOUMusicPlaybackService.h"

#import <AVFoundation/AVFoundation.h>

@interface RHAudioSessionService ()

@property (nonatomic, strong) RHAudioSessionCoordinator *audioSessionCoordinator;

@property (nonatomic, strong) RHDOUMusicPlaybackService *player;

@end

@implementation RHAudioSessionService

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
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self reset];
    
    self.audioSessionCoordinator = nil;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self commonInitForRHAudioSessionService];
    }
    return self;
}

#pragma mark - Public behavior

- (void)configure:(RHMusicPlaybackConfiguration *)configuration
{
    [self reset];
    
    [self.audioSessionCoordinator activateSharedAudioSession];
    
    self.player = [[RHDOUMusicPlaybackService alloc] initWithConfiguration:configuration];
    [self.player play];
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
        [self.player pause];
    }
}

- (void)audioSessionInterrupted:(NSNotification *)notification
{
    AVAudioSessionInterruptionType interruptionType = [notification.userInfo[AVAudioSessionInterruptionTypeKey] unsignedIntegerValue];
    NSLog(@"%s - %@ (%lu)", __PRETTY_FUNCTION__, notification, (unsigned long)interruptionType);
    
    if (AVAudioSessionInterruptionTypeBegan == interruptionType) {
        NSLog(@"%s - interruption BEGAN...", __PRETTY_FUNCTION__);
        [self.player pause];
        return;
    }
    
    NSLog(@"%s - interruption END...", __PRETTY_FUNCTION__);
    AVAudioSessionInterruptionOptions interruptionOptions = [notification.userInfo[AVAudioSessionInterruptionOptionKey] unsignedIntegerValue];
    if (AVAudioSessionInterruptionOptionShouldResume == interruptionOptions) {
        NSLog(@"%s - resuming playback...", __PRETTY_FUNCTION__);
        [self.player play];
    }
}

#pragma mark - Private behavior

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
    if ([self.player isPlaying])
    {
        [self.player stop];
    }
    self.player = nil;
    [self.audioSessionCoordinator deactivateSharedAudioSession];
}

@end
