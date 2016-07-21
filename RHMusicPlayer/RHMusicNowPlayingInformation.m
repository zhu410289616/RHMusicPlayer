//
//  RHMusicNowPlayingInformation.m
//  Example
//
//  Created by zhuruhong on 16/7/21.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import "RHMusicNowPlayingInformation.h"
#import "RHMusicPlaybackQueue.h"
#import "RHMusicPlaybackQueueManager.h"
#import <MediaPlayer/MediaPlayer.h>
#import "RHMusicItem.h"

@interface RHMusicNowPlayingInformation ()

@property (nonatomic, weak) RHMusicPlaybackQueueManager *queueManager;

@end

@implementation RHMusicNowPlayingInformation

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = nil;
}

- (instancetype)initWithPlaybackQueueManager:(RHMusicPlaybackQueueManager *)queueManager
{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nowPlayingItemChanged:) name:RHMusicPlaybackQueueNowPlayingItemChanged object:nil];
        _queueManager = queueManager;
    }
    return self;
}

#pragma mark - NSNotification Observer methods

- (void)nowPlayingItemChanged:(NSNotification *)notification
{
    RHMusicItem *currentMusicItem = notification.userInfo[RHMusicPlaybackQueueNowPlayingItemChangedKey];
    [self updateNowPlayingInfoCenter:currentMusicItem];
}

#pragma mark - Private behavior

- (void)updateNowPlayingInfoCenter:(RHMusicItem *)nowPlayingMusicItem
{
    NSMutableDictionary *nowPlayingInfo = [NSMutableDictionary dictionary];
    
    NSDictionary *currentItemInfo = [nowPlayingMusicItem rh_nowPlayingInfo];
    if (currentItemInfo.count > 0) {
        [nowPlayingInfo addEntriesFromDictionary:currentItemInfo];
    }
    
    nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = @(1.0f);
    nowPlayingInfo[MPNowPlayingInfoPropertyDefaultPlaybackRate] = @(1.0f);
    
    RHMusicPlaybackQueue *currentQueue = self.queueManager.currentQueue;
    nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackQueueIndex] = @(currentQueue.indexOfCurrentMusicItem);
    nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackQueueCount] = @(currentQueue.numberOfMusicItems);
    
    if (0 == nowPlayingInfo.count) {
        nowPlayingInfo = nil;
    }
    
    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:nowPlayingInfo];
}

@end
