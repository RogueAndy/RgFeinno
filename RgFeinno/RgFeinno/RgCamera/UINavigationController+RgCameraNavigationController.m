//
//  UINavigationController+RgCameraNavigationController.m
//  RgFeinno
//
//  Created by Rogue Andy on 16/8/29.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import "UINavigationController+RgCameraNavigationController.h"

@implementation UINavigationController (RgCameraNavigationController)

- (void)setCameraBarWithFontColor:(UIColor *)fontColor barColor:(UIColor *)barColor {
    
    self.navigationBar.tintColor = fontColor;
    self.navigationBar.barTintColor = barColor;
    self.navigationItem.hidesBackButton = YES;
    
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : fontColor}];
    
}

@end
