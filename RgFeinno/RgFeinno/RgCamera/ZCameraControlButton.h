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
    ZCRightButton     = 2

};

@interface ZCameraControlButton : UIButton

+ (instancetype)initWithCameraButtonType:(ZCameraButtonType)type frame:(CGRect)frame;

@end
