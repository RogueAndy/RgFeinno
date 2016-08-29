//
//  UIViewController+RgCameraViewController.m
//  RgFeinno
//
//  Created by Rogue Andy on 16/8/29.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import "UIViewController+RgCameraViewController.h"

@implementation UIViewController (RgCameraViewController)

- (void)setCameraBarWithFontColor:(UIColor *)fontColor barColor:(UIColor *)barColor {
    
    self.navigationController.navigationBar.tintColor = fontColor;
    self.navigationController.navigationBar.barTintColor = barColor;
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"rg_camera_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(dismissAction:)];
    self.navigationItem.leftBarButtonItem = back;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
}

- (void)dismissAction:(UIButton *)sender {

    [self dismissViewControllerAnimated:YES completion:nil];

}

@end
