//
//  RHMusicPlayback.h
//  Example
//
//  Created by zhuruhong on 16/7/21.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RHMusicPlayback <NSObject>

- (void)play;
- (void)pause;

- (BOOL)isPlaying;
- (void)togglePlayPause;

- (void)next;
- (void)previous;

- (void)stop;

@end
