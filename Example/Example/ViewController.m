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

#import "RHMusicCoverView.h"
#import "RHMusicPlaybackControl.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *playAndPauseButton;
@property (nonatomic, strong) UIButton *previousButton;
@property (nonatomic, strong) UIButton *nextButton;

@property (nonatomic, strong) RHMusicCoverView *musicCoverView;

@property (nonatomic, strong) UILabel *musicNameLabel;
@property (nonatomic, strong) UILabel *musicArtistLabel;

@property (nonatomic, strong) RHMusicPlaybackControl *playbackControl;

@property (nonatomic, strong) NSTimer *musicTimer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGFloat width = CGRectGetWidth(self.view.frame);
    CGFloat height = CGRectGetHeight(self.view.frame);
    
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
    
    //
    CGRect coverFrame = CGRectMake((width - 250)/2, 220, 250, 250);
    _musicCoverView = [[RHMusicCoverView alloc] initWithFrame:coverFrame];
    [_musicCoverView.playButton addTarget:self action:@selector(doTestPlayAndPauseAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_musicCoverView];
    
    //
    CGRect nameFrame = CGRectMake(0, CGRectGetMaxY(_musicCoverView.frame)+15, width, 20);
    _musicNameLabel = [[UILabel alloc] initWithFrame:nameFrame];
    _musicNameLabel.textAlignment = NSTextAlignmentCenter;
    _musicNameLabel.font = [UIFont systemFontOfSize:15.0f];
    _musicNameLabel.textColor = [UIColor darkGrayColor];
    [self.view addSubview:_musicNameLabel];
    
    //
    CGRect artistFrame = CGRectMake(0, CGRectGetMaxY(_musicNameLabel.frame)+5, width, 20);
    _musicArtistLabel = [[UILabel alloc] initWithFrame:artistFrame];
    _musicArtistLabel.textAlignment = NSTextAlignmentCenter;
    _musicArtistLabel.font = [UIFont systemFontOfSize:15.0f];
    _musicArtistLabel.textColor = [UIColor darkGrayColor];
    [self.view addSubview:_musicArtistLabel];
    
    //
    CGRect controlFrame = CGRectMake(0, height-110, width, 110);
    _playbackControl = [[RHMusicPlaybackControl alloc] initWithFrame:controlFrame];
    [_playbackControl.playAndPauseButton addTarget:self action:@selector(doTestPlayAndPauseAction) forControlEvents:UIControlEventTouchUpInside];
    [_playbackControl.previousButton addTarget:self action:@selector(doTestPreviousButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_playbackControl.nextButton addTarget:self action:@selector(doTestNextButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_playbackControl];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([RHDOUMusicPlaybackService sharedInstance].isPlaying) {
        [self startMusicTimer];
    }
}

- (void)doTestPlayAndPauseAction
{
    [[RHDOUMusicPlaybackService sharedInstance] togglePlayPause];
}

- (void)doTestPreviousButtonAction
{
    [[RHDOUMusicPlaybackService sharedInstance] previous];
    [self startMusicTimer];
    _musicCoverView.playButton.hidden = YES;
    RHMusicItem *item = [RHDOUMusicPlaybackService sharedInstance].currentMusicItem;
    _musicNameLabel.text = item.title;
    _musicArtistLabel.text = item.artist;
}

- (void)doTestNextButtonAction
{
    [[RHDOUMusicPlaybackService sharedInstance] next];
    [self startMusicTimer];
    _musicCoverView.playButton.hidden = YES;
    RHMusicItem *item = [RHDOUMusicPlaybackService sharedInstance].currentMusicItem;
    _musicNameLabel.text = item.title;
    _musicArtistLabel.text = item.artist;
}

- (void)stopMusicTimer
{
    if (_musicTimer) {
        [_musicTimer invalidate];
        _musicTimer = nil;
    }
}

- (void)startMusicTimer
{
    if (_musicTimer) {
        return;
    }
    _musicTimer = [NSTimer scheduledTimerWithTimeInterval:1/20 target:self selector:@selector(refreshProgress) userInfo:nil repeats:YES];
}

- (void)refreshProgress
{
    [_musicCoverView refreshCoverTransform];
}

@end
