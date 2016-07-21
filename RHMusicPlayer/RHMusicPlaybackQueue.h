//
//  RHMusicPlaybackQueue.h
//  Example
//
//  Created by zhuruhong on 16/7/21.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSInteger const RHMusicPlaybackQueueIndexStopped;

@interface RHMusicPlaybackQueue : NSObject

@property (nonatomic, copy, readonly) NSArray *queuedMusicItems;

@property (nonatomic, readonly) BOOL shufflePlayback;
@property (nonatomic, readonly) BOOL shouldLoopPlayback;

@property (nonatomic, readonly) NSInteger indexOfCurrentMusicItem;
@property (nonatomic, readonly) NSInteger numberOfMusicItems;

- (void)enqueueMusicItems:(NSArray *)pendingMusicItems;
- (id)musicItemAtIndex:(NSInteger)index;

@end
