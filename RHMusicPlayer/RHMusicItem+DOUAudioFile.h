//
//  RHMusicItem+DOUAudioFile.h
//  Example
//
//  Created by zhuruhong on 16/7/21.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import "RHMusicItem.h"
#import "DOUAudioFile.h"

@interface RHMusicItem (DOUAudioFile) <DOUAudioFile>

@property (nonatomic, strong) NSURL *audioFileURL;

@end
