//
//  ViewController.m
//  Example
//
//  Created by zhuruhong on 16/7/21.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import "ViewController.h"

#import "RHMusicPlaybackConfiguration.h"
#import "RHDOUMusicPlaybackService.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *playAndPauseButton;
@property (nonatomic, strong) UIButton *previousButton;
@property (nonatomic, strong) UIButton *nextButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _playAndPauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _playAndPauseButton.frame = CGRectMake(20, 40, 250, 40);
    _playAndPauseButton.layer.borderColor = [UIColor blackColor].CGColor;
    _playAndPauseButton.layer.borderWidth = 0.5;
    _playAndPauseButton.layer.masksToBounds = YES;
    [_playAndPauseButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_playAndPauseButton setTitle:@"Test PlayAndPause" forState:UIControlStateNormal];
    [_playAndPauseButton addTarget:self action:@selector(doTestPlayAndPauseAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_playAndPauseButton];
    
    _previousButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _previousButton.frame = CGRectMake(20, CGRectGetMaxY(_playAndPauseButton.frame) + 20, 250, 40);
    _previousButton.layer.borderColor = [UIColor blackColor].CGColor;
    _previousButton.layer.borderWidth = 0.5;
    _previousButton.layer.masksToBounds = YES;
    [_previousButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_previousButton setTitle:@"Test previous" forState:UIControlStateNormal];
    [_previousButton addTarget:self action:@selector(doTestPreviousButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_previousButton];
    
    _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextButton.frame = CGRectMake(20, CGRectGetMaxY(_previousButton.frame) + 20, 250, 40);
    _nextButton.layer.borderColor = [UIColor blackColor].CGColor;
    _nextButton.layer.borderWidth = 0.5;
    _nextButton.layer.masksToBounds = YES;
    [_nextButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_nextButton setTitle:@"Test Next" forState:UIControlStateNormal];
    [_nextButton addTarget:self action:@selector(doTestNextButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextButton];
    
    
    //
    RHMusicPlaybackConfiguration *configuration = [RHMusicPlaybackConfiguration defaultConfiguration];
    [configuration testMusicItem];
    
    [[RHDOUMusicPlaybackService sharedInstance].queueManager enqueueMusicItems:configuration.queuedMusicItems];
    
}

- (void)doTestPlayAndPauseAction
{
    [[RHDOUMusicPlaybackService sharedInstance] togglePlayPause];
}

- (void)doTestPreviousButtonAction
{
    [[RHDOUMusicPlaybackService sharedInstance] previous];
}

- (void)doTestNextButtonAction
{
    [[RHDOUMusicPlaybackService sharedInstance] next];
}

@end
