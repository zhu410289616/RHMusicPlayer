//
//  RHMusicPlaybackConfiguration.h
//  Example
//
//  Created by zhuruhong on 16/7/21.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RHMusicPlaybackConfiguration : NSObject

@property (nonatomic, copy) NSArray *queuedMusicItems;

+ (RHMusicPlaybackConfiguration *)defaultConfiguration;

- (void)testMusicItem;

@end
