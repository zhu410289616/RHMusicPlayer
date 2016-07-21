//
//  RHMusicItem.h
//  Example
//
//  Created by zhuruhong on 16/7/21.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RHMusicItem : NSObject

@property (nonatomic, strong) NSString *artist;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *albumTitle;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *picture;
@property (nonatomic, strong) NSString *musicPath;

@end

@interface RHMusicItem (nowPlayingInfo)

- (NSDictionary *)rh_nowPlayingInfo;

@end
