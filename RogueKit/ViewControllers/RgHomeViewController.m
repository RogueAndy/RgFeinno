//
//  RgHomeViewController.m
//  RogueKitDemo
//
//  Created by Rogue on 16/1/25.
//  Copyright © 2016年 Rogue. All rights reserved.
//

#import "RgHomeViewController.h"
#import "RgLoadingController.h"

@interface RgHomeViewController ()

@end

@implementation RgHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    self.title = @"Home";
    
    [RgLoadingController showLoadingActivityViewOn:self hudType:RgLoadingGIF];
    
}

@end
