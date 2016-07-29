//
//  RHMusicCoverView.m
//  Example
//
//  Created by zhuruhong on 16/7/27.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import "RHMusicCoverView.h"

@implementation RHMusicCoverView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        CGFloat width = CGRectGetWidth(frame);
        CGFloat height = CGRectGetHeight(frame);
        CGFloat coverWidth = MIN(width, height);
        CGFloat radius = coverWidth / 2;
        
        _coverImageView = [[UIImageView alloc] init];
        _coverImageView.frame = CGRectMake(width/2 - radius, height/2 - radius, coverWidth, coverWidth);
        _coverImageView.layer.cornerRadius = radius;
        _coverImageView.layer.borderWidth = 5.f;
        _coverImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self addSubview:_coverImageView];
        
        _playButtonBgView = [[UIView alloc] init];
        _playButtonBgView.frame = _coverImageView.bounds;
        [self addSubview:_playButtonBgView];
        
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _playButton.frame = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
        [_playButtonBgView addSubview:_playButtonBgView];
        
        //
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
