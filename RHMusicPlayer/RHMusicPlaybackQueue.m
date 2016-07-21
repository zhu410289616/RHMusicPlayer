//
//  RHMusicPlaybackQueue.m
//  Example
//
//  Created by zhuruhong on 16/7/21.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import "RHMusicPlaybackQueue.h"
#import "RHMusicItem.h"

NSInteger const RHMusicPlaybackQueueIndexStopped = -1;

@implementation RHMusicPlaybackQueue

- (instancetype)init
{
    if (self = [super init]) {
        _queuedMusicItems = [NSArray array];
        _shufflePlayback = NO;
        _shouldLoopPlayback = YES;
        _indexOfCurrentMusicItem = RHMusicPlaybackQueueIndexStopped;
    }
    return self;
}

- (NSInteger)numberOfMusicItems
{
    return _queuedMusicItems.count;
}

- (void)enqueueMusicItems:(NSArray *)pendingMusicItems
{
    if (0 == pendingMusicItems.count) {
        return;
    }
    
    NSMutableArray *updatedMusicItems = [NSMutableArray arrayWithArray:_queuedMusicItems];
    [updatedMusicItems addObjectsFromArray:pendingMusicItems];
    
    if (_shufflePlayback) {
        [updatedMusicItems rh_shuffle];
    }
    
    _queuedMusicItems = updatedMusicItems;
}

- (RHMusicItem *)musicItemAtIndex:(NSInteger)index
{
    if ((index > RHMusicPlaybackQueueIndexStopped) && (index < _queuedMusicItems.count)) {
        return _queuedMusicItems[index];
    }
    return nil;
}

- (RHMusicItem *)nextMusicItem
{
    return [self assetForIndex:[self nextItemIndex]];
}

- (RHMusicItem *)previousMusicItem
{
    return [self assetForIndex:[self previousItemIndex]];
}

- (NSInteger)nextItemIndex
{
    NSInteger naiveNextIndex = _indexOfCurrentMusicItem + 1;
    if (naiveNextIndex < [self numberOfMusicItems]) {
        return naiveNextIndex;
    }
    
    if (_shouldLoopPlayback) {
        return 0;
    }
    
    return RHMusicPlaybackQueueIndexStopped;
}

- (NSInteger)previousItemIndex
{
    NSInteger naivePreviousIndex = _indexOfCurrentMusicItem - 1;
    if (naivePreviousIndex >= 0) {
        return naivePreviousIndex;
    }
    
    if (_shouldLoopPlayback) {
        return [self numberOfMusicItems] - 1;
    }
    
    return RHMusicPlaybackQueueIndexStopped;
}

- (RHMusicItem *)assetForIndex:(NSInteger)index
{
    if (RHMusicPlaybackQueueIndexStopped == index) {
        return nil;
    }
    
    RHMusicItem *musicItem = [self musicItemAtIndex:index];
    if (musicItem) {
        _indexOfCurrentMusicItem = index;
    }
    
    return musicItem;
}

@end

@implementation NSMutableArray (shuffle)

/**
 *  http://en.wikipedia.org/wiki/Fisher–Yates_shuffle
 *  http://nshipster.com/random/
 */
- (void)rh_shuffle
{
    if (self.count > 1) {
        for (NSInteger i=(self.count-1); i>0; --i) {
            [self exchangeObjectAtIndex:i withObjectAtIndex:arc4random_uniform((int32_t)(i + 1))];
        }
    }
}

@end
