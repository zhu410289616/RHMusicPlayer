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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    RHMusicPlaybackConfiguration *configuration = [RHMusicPlaybackConfiguration defaultConfiguration];
    [configuration testMusicItem];
    
    [[RHDOUMusicPlaybackService sharedInstance].queueManager enqueueMusicItems:configuration.queuedMusicItems];
    [[RHDOUMusicPlaybackService sharedInstance] play];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
