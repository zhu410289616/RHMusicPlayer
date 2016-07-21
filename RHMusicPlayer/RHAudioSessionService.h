//
//  RHAudioSessionService.h
//  Example
//
//  Created by zhuruhong on 16/7/21.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RHMusicPlaybackConfiguration;

/**
 *  audio session monitor
 */
@interface RHAudioSessionService : NSObject

+ (instancetype)sharedInstance;

- (void)configure:(RHMusicPlaybackConfiguration *)configuration;

@end
