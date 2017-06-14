//
//  RgSoundRecordViewController.m
//  RgFeinno
//
//  Created by Rogue Andy on 16/9/5.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import "RgSoundRecordViewController.h"
#import "RgSoundRecord.h"
#import "RgSoundPlay.h"
#import "RgWave.h"

@interface RgSoundRecordViewController ()

@property (nonatomic, strong) RgSoundRecord *soundRecord;

@property (nonatomic, strong) NSString *fileURL;

@property (nonatomic, strong) RgSoundPlay *soundPlay;

@property (nonatomic, strong) RgWave *wave;

@end

@implementation RgSoundRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *bu = [UIButton buttonWithType:UIButtonTypeCustom];
    bu.backgroundColor = [UIColor orangeColor];
    [bu setTitle:@"录制音频" forState:UIControlStateNormal];
    bu.titleLabel.textColor = [UIColor whiteColor];
    [bu addTarget:self action:@selector(begin) forControlEvents:UIControlEventTouchUpInside];
    bu.frame = CGRectMake(20, 100, CGRectGetWidth(self.view.frame) - 40, 40);
    [self.view addSubview:bu];
    
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.backgroundColor = [UIColor redColor];
    [bt setTitle:@"停止" forState:UIControlStateNormal];
    bt.titleLabel.textColor = [UIColor whiteColor];
    [bt addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];
    bt.frame = CGRectMake(20, 20, CGRectGetWidth(self.view.frame) - 40, 40);
    [self.view addSubview:bt];
//
//    UIButton *bb = [UIButton buttonWithType:UIButtonTypeCustom];
//    bb.backgroundColor = [UIColor redColor];
//    [bb addTarget:self action:@selector(read) forControlEvents:UIControlEventTouchUpInside];
//    bb.frame = CGRectMake(20, 160, 100, 40);
//    [self.view addSubview:bb];
//    
}

- (void)begin {

    [self loadWave];
    self.soundRecord = [RgSoundRecord soundRecordWithName:@"audio3.wav"];
    
    [self.soundRecord startMonitorAndChangeBlock:^(CGFloat progress) {
        
        [self.wave progressFloat:progress];
        
    }];

}

- (void)stop {

    self.fileURL = [self.soundRecord endRecord];
    NSLog(@"~~~~ %@", self.fileURL);
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.wave.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         [self.wave removeFromSuperview];
                         self.wave = nil;
                         self.soundRecord = nil;
                     }];

}

- (void)read {
    
    [self loadWave];
    
    NSString *mp3 = [[NSBundle mainBundle] pathForResource:@"yiqifei" ofType:@"mp3"];
    
    
    self.soundPlay = [RgSoundPlay soundWithFilePath:[NSURL URLWithString:mp3]];
    [self.soundPlay startMonitorAndChangeBlock:^(CGFloat progress) {
        
        [self.wave progressFloat:progress];
        
    }];

}

- (void)loadWave {

    _wave = [[RgWave alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    _wave.center = CGPointMake(self.view.center.x, self.view.center.y - 80);
    [self.view addSubview:_wave];

}

@end
