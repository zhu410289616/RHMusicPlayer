//
//  RHMusicPlaybackQueue.h
//  Example
//
//  Created by zhuruhong on 16/7/21.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RHMusicItem;

extern NSInteger const RHMusicPlaybackQueueIndexStopped;

@interface RHMusicPlaybackQueue : NSObject

@property (nonatomic, copy, readonly) NSArray *queuedMusicItems;

@property (nonatomic, readonly) BOOL shufflePlayback;
@property (nonatomic, readonly) BOOL shouldLoopPlayback;

@property (nonatomic, readonly) NSInteger indexOfCurrentMusicItem;
@property (nonatomic, readonly) NSInteger numberOfMusicItems;

- (void)enqueueMusicItems:(NSArray *)pendingMusicItems removeOldMusicItems:(BOOL)shouldRemove;
- (void)enqueueMusicItems:(NSArray *)pendingMusicItems;

/** 返回对应索引的歌曲，不存在则返回nil */
- (RHMusicItem *)musicItemAtIndex:(NSInteger)index;

- (RHMusicItem *)nextMusicItem;
- (RHMusicItem *)previousMusicItem;

- (NSInteger)nextItemIndex;
- (NSInteger)previousItemIndex;
/** 返回对应索引的歌曲，同时更新indexOfCurrentMusicItem，不存在则返回nil */
- (RHMusicItem *)assetForIndex:(NSInteger)index;

@end

@interface NSMutableArray (shuffle)

- (void)rh_shuffle;

@end
