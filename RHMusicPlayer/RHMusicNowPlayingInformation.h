//
//  RHMusicNowPlayingInformation.h
//  Example
//
//  Created by zhuruhong on 16/7/21.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RHMusicPlaybackQueueManager;

@interface RHMusicNowPlayingInformation : NSObject

- (instancetype)initWithPlaybackQueueManager:(RHMusicPlaybackQueueManager *)queueManager;

@end
