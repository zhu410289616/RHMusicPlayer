//
//  RHMusicPlaybackQueueManager.h
//  Example
//
//  Created by zhuruhong on 16/7/21.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RHMusicPlaybackQueue;
@class RHMusicPlaybackConfiguration;

extern NSString * const RHMusicPlaybackQueueNowPlayingItemChanged;
extern NSString * const RHMusicPlaybackQueueNowPlayingItemChangedKey;

@interface RHMusicPlaybackQueueManager : NSObject

@property (nonatomic, strong, readonly) RHMusicPlaybackQueue *currentQueue;

- (instancetype)initWithConfiguration:(RHMusicPlaybackConfiguration *)configuration;

- (void)enqueueMusicItems:(NSArray *)musicItems;

- (void)broadcastNowPlayingItemChange;

- (BOOL)queueHasItems;
- (NSArray *)currentlyQueuedItems;

@end
