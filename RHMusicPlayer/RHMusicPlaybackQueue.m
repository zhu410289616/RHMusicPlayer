//
//  RHMusicPlaybackQueue.m
//  Example
//
//  Created by zhuruhong on 16/7/21.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import "RHMusicPlaybackQueue.h"

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
    [pendingMusicItems enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //TODO: check music items
        
        [updatedMusicItems addObject:obj];
    }];
    
    if (_shufflePlayback) {
        //TODO: shuffle
    }
    
    _queuedMusicItems = updatedMusicItems;
}

- (id)musicItemAtIndex:(NSInteger)index
{
    if ((index > RHMusicPlaybackQueueIndexStopped) && (index < _queuedMusicItems.count)) {
        return _queuedMusicItems[index];
    }
    return nil;
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

@end
