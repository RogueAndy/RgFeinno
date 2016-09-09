//
//  RgCameraAfterViewController.h
//  RgFeinno
//
//  Created by Rogue Andy on 16/9/9.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import "RgBaseViewController.h"

/**
 *  选择照片后，或者拍摄照片后，进入裁剪界面 示例
 */

@interface RgCameraAfterViewController : RgBaseViewController

@end



@interface RgCameraShowViewController : RgBaseViewController

+ (instancetype)initWithImage:(UIImage *)image;

@end