//
//  RHMusicRemoteCommander.h
//  Example
//
//  Created by zhuruhong on 16/7/21.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RHMusicPlaybackService;

@interface RHMusicRemoteCommander : NSObject

- (instancetype)initWithService:(RHMusicPlaybackService *)service;

@end
