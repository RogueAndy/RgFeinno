//
//  RgCutImage.h
//  RgFeinno
//
//  Created by Rogue Andy on 16/8/31.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RgCutImage : NSObject

+ (UIImage *)cutoutImage:(UIImage *)cutoutImage cutoutFrame:(CGRect)cutoutFrame;

@end
