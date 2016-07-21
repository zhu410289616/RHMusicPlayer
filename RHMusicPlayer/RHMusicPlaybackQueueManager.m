//
//  RHMusicPlaybackQueueManager.m
//  Example
//
//  Created by zhuruhong on 16/7/21.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import "RHMusicPlaybackQueueManager.h"
#import "RHMusicPlaybackQueue.h"
#import "RHMusicPlaybackConfiguration.h"

NSString * const RHMusicPlaybackQueueNowPlayingItemChanged = @"RHMusicPlaybackQueueNowPlayingItemChanged";
NSString * const RHMusicPlaybackQueueNowPlayingItemChangedKey = @"RHMusicPlaybackQueueNowPlayingItemChangedKey";

@implementation RHMusicPlaybackQueueManager

- (instancetype)initWithConfiguration:(RHMusicPlaybackConfiguration *)configuration
{
    if (self = [super init]) {
        _currentQueue = [[RHMusicPlaybackQueue alloc] init];
        [_currentQueue enqueueMusicItems:configuration.queuedMusicItems];
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
    RHMusicItem *musicItem = [self nowPlayingItem];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:RHMusicPlaybackQueueNowPlayingItemChanged object:self userInfo:@{ RHMusicPlaybackQueueNowPlayingItemChangedKey:musicItem }];
}

- (RHMusicItem *)nowPlayingItem
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
