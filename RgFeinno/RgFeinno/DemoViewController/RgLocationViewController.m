//
//  RgLocationViewController.m
//  RgFeinno
//
//  Created by Rogue Andy on 16/8/29.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import "RgLocationViewController.h"
#import "RgLocation.h"

@implementation RgLocationViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *bu = [UIButton buttonWithType:UIButtonTypeCustom];
    bu.backgroundColor = [UIColor orangeColor];
    [bu addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
    bu.frame = CGRectMake(20, 200, 280, 40);
    [self.view addSubview:bu];
    
}

- (void)show {

    [RgLocation requestLocation:^(CLPlacemark *place) {
        
        NSLog(@"%@", place);
        
    }];

}

@end
