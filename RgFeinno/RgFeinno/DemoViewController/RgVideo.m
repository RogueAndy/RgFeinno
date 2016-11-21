//
//  RgVideo.m
//  RgFeinno
//
//  Created by Rogue Andy on 16/8/30.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import "RgVideo.h"
#import "KRVideoPlayerController.h"

@interface RgVideo()

@property (nonatomic, strong) KRVideoPlayerController *videoController;

@end

@implementation RgVideo

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    [bt addTarget:self action:@selector(ac) forControlEvents:UIControlEventTouchUpInside];
    [bt setTitle:@"视频" forState:UIControlStateNormal];
    bt.titleLabel.textColor = [UIColor whiteColor];
    bt.frame = CGRectMake(20, 200, CGRectGetWidth(self.view.frame) - 40, 40);
    bt.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:bt];
    
}

- (void)ac {
    
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    self.videoController = [[KRVideoPlayerController alloc] initWithFrame:CGRectMake(0, 0, width, width*(9.0/16.0))];
    self.videoController.contentURL = [NSURL URLWithString:@"http://2119.vod.myqcloud.com/2119_4128da20374f11e69d30d1ccb6dac2a3.f0.mp4"];
    [self.videoController showInWindow];

}


@end
