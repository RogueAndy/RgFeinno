//
//  RgSoundRecordViewController.m
//  RgFeinno
//
//  Created by Rogue Andy on 16/9/5.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import "RgSoundRecordViewController.h"
#import "RgSoundRecord.h"

@interface RgSoundRecordViewController ()

@property (nonatomic, strong) RgSoundRecord *soundRecord;

@end

@implementation RgSoundRecordViewController

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
    
    self.soundRecord = [RgSoundRecord soundRecordWithName:@"20160905"];
    
}

- (void)begin {

    [self.soundRecord startMonitorAndChangeBlock:^(CGFloat progress) {
        
        NSLog(@"----- audio: %f", progress);
        
    }];

}

- (void)stop {

    [self.soundRecord endRecord];

}

- (void)read {

    [self.soundRecord readRecord];

}

@end
