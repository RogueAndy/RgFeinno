//
//  UIImagePickerController+RgCameraNavigationController.h
//  RgCameraKit
//
//  Created by Rogue Andy on 16/9/23.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImagePickerController (RgCameraNavigationController)

/**
 分类设置属性

 @param fontColor 导航栏字体颜色
 @param barColor 导航栏背景颜色
 */
- (void)setCameraBarWithFontColor:(UIColor *)fontColor barColor:(UIColor *)barColor;

@end
