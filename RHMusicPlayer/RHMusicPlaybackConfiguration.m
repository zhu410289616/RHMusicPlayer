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
        _queuedMusicItems = [NSArray array];
    }
    return self;
}

- (void)testMusicItem
{
    NSMutableArray *tempQueuedMusicItems = [[NSMutableArray alloc] init];
    
    RHMusicItem *item = [[RHMusicItem alloc] init];
    item.title = @"布瓜的世界";
    item.artist = @"江若琳";
    item.albumTitle = @"Show You";
    item.avatar = @"https://img3.doubanio.com/img/fmadmin/small/882354.jpg";
    item.picture = @"https://img3.doubanio.com/lpic/s4068296.jpg";
    item.musicPath = @"http://mr3.doubanio.com/78582e4bfd69f104becbab4d3553587c/0/fm/song/p1753656_128k.mp4";
    [tempQueuedMusicItems addObject:item];
    
    item = [[RHMusicItem alloc] init];
    item.title = @"He's a Pirate";
    item.artist = @"David Garrett";
    item.albumTitle = @"Encore";
    item.avatar = @"https://img3.doubanio.com/img/fmadmin/small/33305.jpg";
    item.picture = @"https://img1.doubanio.com/lpic/s3334547.jpg";
    item.musicPath = @"http://mr3.doubanio.com/f62be60f9326c46059f53c2173ac5a14/1/fm/song/p1512166_128k.mp4";
    [tempQueuedMusicItems addObject:item];
    
    _queuedMusicItems = tempQueuedMusicItems;
}

@end
