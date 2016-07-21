//
//  RHMusicItem.m
//  Example
//
//  Created by zhuruhong on 16/7/21.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import "RHMusicItem.h"
#import <MediaPlayer/MediaPlayer.h>

@implementation RHMusicItem

@end

@implementation RHMusicItem (nowPlayingInfo)

- (NSDictionary *)rh_nowPlayingInfo
{
    NSMutableDictionary *nowPlayingInfo = [NSMutableDictionary dictionary];
    
    if (self.artist.length > 0) {
        nowPlayingInfo[MPMediaItemPropertyArtist] = self.artist;
    }
    
    if (self.title.length > 0) {
        nowPlayingInfo[MPMediaItemPropertyTitle] = self.title;
    }
    
    if (self.albumTitle.length > 0) {
        nowPlayingInfo[MPMediaItemPropertyAlbumTitle] = self.albumTitle;
    }
    
    return nowPlayingInfo;
}

@end