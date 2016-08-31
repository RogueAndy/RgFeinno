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

/**
 *  对某个图像 UIImage 进行裁剪，而 cutoutFrame 的坐标相对应图片的左上角，大小有自己设定
 *
 *  @param cutoutImage 需要被裁剪的图片
 *  @param cutoutFrame 裁剪的位置及代销
 *
 *  @return 裁剪完毕后的图片
 */

+ (UIImage *)cutoutImage:(UIImage *)cutoutImage cutoutFrame:(CGRect)cutoutFrame;

@end
