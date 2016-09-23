//
//  UIImagePickerController+RgCameraNavigationController.m
//  RgCameraKit
//
//  Created by Rogue Andy on 16/9/23.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import "UIImagePickerController+RgCameraNavigationController.h"

@implementation UIImagePickerController (RgCameraNavigationController)

- (void)setCameraBarWithFontColor:(UIColor *)fontColor barColor:(UIColor *)barColor {
    
    self.navigationBar.tintColor = fontColor;
    self.navigationBar.barTintColor = barColor;
    
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : fontColor}];
    
}

@end
