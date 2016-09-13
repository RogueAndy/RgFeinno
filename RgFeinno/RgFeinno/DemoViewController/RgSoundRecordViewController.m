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

- (RgWave *)wave {

    if(!_wave) {
    
        _wave = [[RgWave alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        _wave.center = self.view.center;
        [self.view addSubview:_wave];
    
    }
    
    return _wave;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *bu = [UIButton buttonWithType:UIButtonTypeCustom];
    bu.backgroundColor = [UIColor orangeColor];
    [bu addTarget:self action:@selector(begin) forControlEvents:UIControlEventTouchUpInside];
    bu.frame = CGRectMake(20, 100, 100, 40);
    [self.view addSubview:bu];
    
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.backgroundColor = [UIColor redColor];
    [bt addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];
    bt.frame = CGRectMake(200, 100, 100, 40);
    [self.view addSubview:bt];
    
    UIButton *bb = [UIButton buttonWithType:UIButtonTypeCustom];
    bb.backgroundColor = [UIColor redColor];
    [bb addTarget:self action:@selector(read) forControlEvents:UIControlEventTouchUpInside];
    bb.frame = CGRectMake(20, 160, 100, 40);
    [self.view addSubview:bb];
    
    self.soundRecord = [RgSoundRecord soundRecordWithName:@"audio3.wav"];
    
}

- (void)begin {

    [self.soundRecord startMonitorAndChangeBlock:^(CGFloat progress) {
        
        [self.wave progressFloat:progress];
        
    }];

}

- (void)stop {

    self.fileURL = [self.soundRecord endRecord];
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.wave.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         [self.wave removeFromSuperview];
                         self.wave = nil;
                     }];

}

- (void)read {
    
    self.soundPlay = [RgSoundPlay soundWithFilePath:[NSURL URLWithString:self.fileURL]];
    [self.soundPlay startMonitorAndChangeBlock:^(CGFloat progress) {
        
        NSLog(@"发出声音----- audio: %f", progress);
        
    }];

}

@end
