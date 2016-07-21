//
//  RHAudioSessionCoordinator.m
//  Example
//
//  Created by zhuruhong on 16/7/21.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import "RHAudioSessionCoordinator.h"
#import <AVFoundation/AVFoundation.h>

@implementation RHAudioSessionCoordinator

- (void)activateSharedAudioSession
{
    AVAudioSessionCategoryOptions options = kNilOptions;
    
    NSError *sessionCategorizationError = nil;
    BOOL categorizedSession = [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback withOptions:options error:&sessionCategorizationError];
    if (!categorizedSession) {
        NSLog(@"%s - failed to set audio session category: %@", __PRETTY_FUNCTION__, sessionCategorizationError);
    }
    
    NSError *sessionActivationError = nil;
    BOOL activatedSession = [[AVAudioSession sharedInstance] setActive:YES error:&sessionActivationError];
    if (!activatedSession) {
        NSLog(@"%s - failed to activate audio session: %@", __PRETTY_FUNCTION__, sessionActivationError);
    }
}

- (void)deactivateSharedAudioSession
{
    // AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation
    AVAudioSessionSetActiveOptions options = kNilOptions;
    
    NSError *sessionDeactivationError = nil;
    BOOL deactivated = [[AVAudioSession sharedInstance] setActive:NO withOptions:options error:&sessionDeactivationError];
    
    if (!deactivated) {
        NSLog(@"%s - unable to deactivate audio session - error: %@", __PRETTY_FUNCTION__, [sessionDeactivationError localizedDescription]);
    }
}

@end
