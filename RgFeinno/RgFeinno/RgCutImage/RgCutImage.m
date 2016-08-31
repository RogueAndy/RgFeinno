//
//  RgCutImage.m
//  RgFeinno
//
//  Created by Rogue Andy on 16/8/31.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import "RgCutImage.h"

@implementation RgCutImage

#pragma mark - 对某个图像 UIImage 进行裁剪，而 cutoutFrame 的坐标相对应图片的左上角，大小有自己设定

+ (UIImage *)cutoutImage:(UIImage *)cutoutImage cutoutFrame:(CGRect)cutoutFrame {

    CGImageRef cutoutImageRef = cutoutImage.CGImage;
    CGImageRef returnImageRef = CGImageCreateWithImageInRect(cutoutImageRef, cutoutFrame);
    return [[UIImage alloc] initWithCGImage:returnImageRef];
    
}

@end
