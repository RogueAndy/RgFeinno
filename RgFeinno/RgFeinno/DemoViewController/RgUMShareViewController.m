//
//  RgUMShareViewController.m
//  RgFeinno
//
//  Created by Rogue Andy on 16/8/31.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import "RgUMShareViewController.h"
#import "RgUMShare.h"

@implementation RgUMShareViewController

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

    [RgUMShare shareWithUmengType:RgMessage title:@"测试" content:@"测试一下短信发送" shareUrl:@"" presentInViewController:self shareImage:[UIImage imageNamed:@"dd"]];

}

@end
