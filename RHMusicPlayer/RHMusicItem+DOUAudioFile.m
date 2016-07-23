//
//  RHMusicItem+DOUAudioFile.m
//  Example
//
//  Created by zhuruhong on 16/7/21.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import "RHMusicItem+DOUAudioFile.h"
#import "NSString+Music.h"
#import "NSFileManager+Music.h"

@implementation RHMusicItem (DOUAudioFile)

@dynamic audioFileURL;

- (NSURL *)audioFileURL
{
    if (self.cacheFileURL) {
        return self.cacheFileURL;
    }
    
    NSString *cacheFilePath = [self cacheFilePath];
    if (cacheFilePath.length > 0) {
        self.cacheFileURL = [NSURL fileURLWithPath:cacheFilePath];
        return self.cacheFileURL;
    }
    
    NSRange range = [self.musicPath rangeOfString:@"http"];
    if (range.length > 0) {
        return [NSURL URLWithString:self.musicPath];
    }
    
    return [NSURL fileURLWithPath:self.musicPath];
}

- (NSString *)cacheFilePath
{
    NSString *documentDir = [NSFileManager rh_documentDirectory];
    NSString *cacheDir = [NSFileManager rh_pathWithFilePath:[NSString stringWithFormat:@"%@/music", documentDir]];
    
    NSString *cacheName = [NSString rh_stringWithMD5Encode:self.musicPath];
    NSString *cacheFile = [NSString stringWithFormat:@"%@/%@", cacheDir, cacheName];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:cacheFile isDirectory:NULL]) {
        return cacheFile;
    }
    return nil;
}

@end
