//
//  RHAudioSessionMonitor.h
//  Example
//
//  Created by zhuruhong on 16/7/22.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RHMusicPlaybackService;

@interface RHAudioSessionMonitor : NSObject

- (instancetype)initWithService:(RHMusicPlaybackService *)service;

@end
