//
//  RHMusicPlaybackConfiguration.m
//  Example
//
//  Created by zhuruhong on 16/7/21.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import "RHMusicPlaybackConfiguration.h"
#import "RHMusicItem.h"

@implementation RHMusicPlaybackConfiguration

+ (RHMusicPlaybackConfiguration *)defaultConfiguration
{
    return [[self alloc] init];
}

- (instancetype)init
{
    if (self = [super init]) {
        _queuedMediaItems = [NSArray array];
    }
    return self;
}

- (void)testMusicItem
{
    RHMusicItem *item = [[RHMusicItem alloc] init];
    item.title = @"布瓜的世界";
    item.artist = @"江若琳";
    item.albumTitle = @"Show You";
    item.avatar = @"https://img3.doubanio.com/img/fmadmin/small/882354.jpg";
    item.picture = @"https://img3.doubanio.com/lpic/s4068296.jpg";
    item.musicPath = @"http://mr3.doubanio.com/78582e4bfd69f104becbab4d3553587c/0/fm/song/p1753656_128k.mp4";
    _queuedMediaItems = @[item];
}

@end
