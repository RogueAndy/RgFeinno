//
//  RgSpeechViewController.m
//  RgFeinno
//
//  Created by Rogue Andy on 16/9/9.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import "RgSpeechViewController.h"
#import "RgSpeech.h"

@interface RgSpeechViewController ()

@end

@implementation RgSpeechViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *bu = [UIButton buttonWithType:UIButtonTypeCustom];
    bu.backgroundColor = [UIColor orangeColor];
    [bu addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
    bu.frame = CGRectMake(20, 100, 100, 40);
    [self.view addSubview:bu];
    
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.backgroundColor = [UIColor redColor];
    [bt addTarget:self action:@selector(pause) forControlEvents:UIControlEventTouchUpInside];
    bt.frame = CGRectMake(160, 100, 100, 40);
    [self.view addSubview:bt];
    
    UIButton *b2 = [UIButton buttonWithType:UIButtonTypeCustom];
    b2.backgroundColor = [UIColor orangeColor];
    [b2 addTarget:self action:@selector(end) forControlEvents:UIControlEventTouchUpInside];
    b2.frame = CGRectMake(20, 180, 100, 40);
    [self.view addSubview:b2];
    
    UIButton *b3 = [UIButton buttonWithType:UIButtonTypeCustom];
    b3.backgroundColor = [UIColor redColor];
    [b3 addTarget:self action:@selector(conti) forControlEvents:UIControlEventTouchUpInside];
    b3.frame = CGRectMake(160, 180, 100, 40);
    [self.view addSubview:b3];
    
}

- (void)start:(UIButton *)sender {

    [RgSpeech startSpeech:@"床前明月光，疑是地上霜。举头望明月，低头思故乡"];

}

- (void)pause {

    [RgSpeech pauseSpeech];

}

- (void)end {

    [RgSpeech endSpeech];
    
}

- (void)conti {

    [RgSpeech continueSpeech];

}

@end
