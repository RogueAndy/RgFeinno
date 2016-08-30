//
//  RgScreenShot.h
//  RgFeinno
//
//  Created by Rogue Andy on 16/8/30.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RgScreenShot : NSObject

+ (UIImage *)imageWithViewController:(UIViewController *)viewController;

+ (UIImage *)imageWithView:(UIView *)view;

+ (UIImage *)imageWithScrollView:(UIScrollView *)scrollView;

@end
