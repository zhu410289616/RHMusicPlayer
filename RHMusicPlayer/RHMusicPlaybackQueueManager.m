//
//  RHMusicPlaybackQueueManager.m
//  Example
//
//  Created by zhuruhong on 16/7/21.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import "RHMusicPlaybackQueueManager.h"
#import "RHMusicPlaybackQueue.h"

NSString * const RHMusicPlaybackQueueNowPlayingItemChanged = @"RHMusicPlaybackQueueNowPlayingItemChanged";
NSString * const RHMusicPlaybackQueueNowPlayingItemChangedKey = @"RHMusicPlaybackQueueNowPlayingItemChangedKey";

@implementation RHMusicPlaybackQueueManager

- (instancetype)init
{
    if (self = [super init]) {
        _currentQueue = [[RHMusicPlaybackQueue alloc] init];
    }
    return self;
}

- (void)enqueueMusicItems:(NSArray *)musicItems
{
    if (0 == musicItems.count) {
        return;
    }
    
    [_currentQueue enqueueMusicItems:musicItems];
}

- (void)broadcastNowPlayingItemChange
{
    id musicItem = [self nowPlayingItem];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:RHMusicPlaybackQueueNowPlayingItemChanged object:self userInfo:@{ RHMusicPlaybackQueueNowPlayingItemChangedKey:musicItem }];
}

- (id)nowPlayingItem
{
    NSInteger nowPlayingIndex = _currentQueue.indexOfCurrentMusicItem;
    return [_currentQueue musicItemAtIndex:nowPlayingIndex];
}

- (BOOL)queueHasItems
{
    return [_currentQueue numberOfMusicItems] > 0;
}

- (NSArray *)currentlyQueuedItems
{
    return _currentQueue.queuedMusicItems;
}

@end
