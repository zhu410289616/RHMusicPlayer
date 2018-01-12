//
//  RHDOUMusicPlaybackService.h
//  Example
//
//  Created by zhuruhong on 16/7/21.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import "RHMusicPlaybackService.h"
#import "DOUAudioStreamer.h"
#import "RHMusicItem+DOUAudioFile.h"

@interface RHDOUMusicPlaybackService : RHMusicPlaybackService

+ (instancetype)sharedInstance;

- (DOUAudioStreamer *)player;
- (RHMusicItem *)currentMusicItem;
/** 播放对应歌曲 */
- (void)playMusic:(RHMusicItem *)musicItem;

@end
