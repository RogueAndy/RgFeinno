//
//  RgCutoutImageViewController.m
//  RgFeinno
//
//  Created by Rogue Andy on 16/8/31.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import "RgCutoutImageViewController.h"
#import "RgCutImage.h"

@interface RgCutoutImageViewController()

@property (nonatomic, strong) UIImageView *showImageView;

@end

@implementation RgCutoutImageViewController

- (UIImageView *)showImageView {

    if(!_showImageView) {
    
        _showImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 160, 300, 270)];
        [self.view addSubview:_showImageView];
    
    }
    
    return _showImageView;

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *bu = [UIButton buttonWithType:UIButtonTypeCustom];
    bu.backgroundColor = [UIColor orangeColor];
    [bu addTarget:self action:@selector(left) forControlEvents:UIControlEventTouchUpInside];
    bu.frame = CGRectMake(20, 100, 100, 40);
    [self.view addSubview:bu];
    
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.backgroundColor = [UIColor redColor];
    [bt addTarget:self action:@selector(right) forControlEvents:UIControlEventTouchUpInside];
    bt.frame = CGRectMake(200, 100, 100, 40);
    [self.view addSubview:bt];
    
}

- (void)left {

    _showImageView.image = [RgCutImage cutoutImage:[UIImage imageNamed:@"1111111"] cutoutFrame:CGRectMake(0, 0, 50, 50)];

}

- (void)right {

    _showImageView.image = [RgCutImage cutoutImage:[UIImage imageNamed:@"banner"] cutoutFrame:CGRectMake(0, 0, 100, 100)];

}

@end
