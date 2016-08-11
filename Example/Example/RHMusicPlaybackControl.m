//
//  RHMusicPlaybackControl.m
//  Example
//
//  Created by zhuruhong on 16/8/11.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import "RHMusicPlaybackControl.h"

@implementation RHMusicPlaybackControl

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        CGFloat width = CGRectGetWidth(frame);
        CGFloat height = CGRectGetHeight(frame);
        
        _playAndPauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _playAndPauseButton.frame = CGRectMake((width - 60)/2, (height - 60)/2, 60, 60);
        [_playAndPauseButton setBackgroundImage:[UIImage imageNamed:@"ic_action_play"] forState:UIControlStateNormal];
        [self addSubview:_playAndPauseButton];
        
        _previousButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _previousButton.frame = CGRectMake(CGRectGetMinX(_playAndPauseButton.frame) - 32 - 60, (height - 32)/2, 32, 32);
        [_previousButton setBackgroundImage:[UIImage imageNamed:@"ic_action_prev"] forState:UIControlStateNormal];
        [_previousButton setBackgroundImage:[UIImage imageNamed:@"ic_action_prev_pressed"] forState:UIControlStateHighlighted];
        [_previousButton setBackgroundImage:[UIImage imageNamed:@"ic_action_prev_disable"] forState:UIControlStateDisabled];
        [self addSubview:_previousButton];
        
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextButton.frame = CGRectMake(CGRectGetMaxX(_playAndPauseButton.frame) + 60, (height - 32)/2, 32, 32);
        [_nextButton setBackgroundImage:[UIImage imageNamed:@"ic_action_next"] forState:UIControlStateNormal];
        [_nextButton setBackgroundImage:[UIImage imageNamed:@"ic_action_next_pressed"] forState:UIControlStateHighlighted];
        [_nextButton setBackgroundImage:[UIImage imageNamed:@"ic_action_next_disable"] forState:UIControlStateDisabled];
        [self addSubview:_nextButton];
        
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
