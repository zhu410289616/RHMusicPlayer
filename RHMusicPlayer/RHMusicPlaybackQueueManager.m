//
//  RHMusicPlaybackQueueManager.m
//  Example
//
//  Created by zhuruhong on 16/7/21.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import "RHMusicPlaybackQueueManager.h"
#import "RHMusicItem.h"

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

- (void)enqueueMusicItems:(NSArray *)musicItems removeOldMusicItems:(BOOL)shouldRemove
{
    if (0 == musicItems.count) {
        return;
    }
    
    [_currentQueue enqueueMusicItems:musicItems removeOldMusicItems:shouldRemove];
}

- (void)enqueueMusicItems:(NSArray *)musicItems
{
    [_currentQueue enqueueMusicItems:musicItems removeOldMusicItems:NO];
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

- (NSInteger)indexOfQueue:(RHMusicItem *)musicItem
{
    NSInteger index = -1;
    if (musicItem.musicPath.length == 0) {
        return index;
    }
    
    NSInteger musicCount = _currentQueue.queuedMusicItems.count;
    for (NSInteger i=0; i<musicCount; i++) {
        RHMusicItem *tempItem = _currentQueue.queuedMusicItems[i];
        if ([tempItem.musicPath isEqualToString:musicItem.musicPath]) {
            index = i;
            break;
        }
    }
    
    return index;
}

@end
