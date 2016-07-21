//
//  RHMusicPlaybackService.h
//  Example
//
//  Created by zhuruhong on 16/7/21.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RHMusicPlayback.h"

// empirically, this is the playback threshold that determines what "back" means: either "skip backward" or "restart"
extern NSTimeInterval const SystemMusicPlaybackServiceStartThreshold;

@interface RHMusicPlaybackService : NSObject <RHMusicPlayback>

@end
