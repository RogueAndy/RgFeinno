//
//  RgCutImage.m
//  RgFeinno
//
//  Created by Rogue Andy on 16/8/31.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import "RgCutImage.h"

@implementation RgCutImage

+ (UIImage *)cutoutImage:(UIImage *)cutoutImage cutoutFrame:(CGRect)cutoutFrame {

    CGImageRef cutoutImageRef = cutoutImage.CGImage;
    CGImageRef returnImageRef = CGImageCreateWithImageInRect(cutoutImageRef, cutoutFrame);
    return [[UIImage alloc] initWithCGImage:returnImageRef];
    
}

@end
