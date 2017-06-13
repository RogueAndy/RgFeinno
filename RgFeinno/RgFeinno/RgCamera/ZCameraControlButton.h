//
//  ZCameraControlButton.h
//  RgFeinno
//
//  Created by rogue on 2017/6/13.
//  Copyright © 2017年 RogueAndy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZCameraButtonType) {

    ZCCloseDownButton = 0,
    ZCCloseXButton    = 1,
    ZCRightButton     = 2,
    ZCCustomButton    = 3

};

@interface ZCameraControlButton : UIButton

/**
 按钮

 @param type 类型
 @param frame 大小设置，圆形
 @return 实例
 */
+ (instancetype)initWithCameraButtonType:(ZCameraButtonType)type frame:(CGRect)frame drawRect:(void (^)(void))drawRect;

@end
