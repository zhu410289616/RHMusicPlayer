//
//  RHMusicItem+DOUAudioFile.m
//  Example
//
//  Created by zhuruhong on 16/7/21.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import "RHMusicItem+DOUAudioFile.h"

@implementation RHMusicItem (DOUAudioFile)

@dynamic audioFileURL;

- (NSURL *)audioFileURL
{
    NSRange range = [self.musicPath rangeOfString:@"http"];
    if (range.length > 0) {
        return [NSURL URLWithString:self.musicPath];
    }
    
    return [NSURL fileURLWithPath:self.musicPath];
}

@end
