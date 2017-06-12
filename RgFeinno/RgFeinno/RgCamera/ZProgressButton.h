//
//  ZProgressButton.h
//  ZProgress
//
//  Created by rogue on 2017/6/12.
//  Copyright © 2017年 dazhongge. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 按钮播放状态

 - ZPNoBeginAnimation: 未播放状态
 - ZPBeginAnimation: 播放状态
 - ZPEndAnimation: 结束播放状态
 */
typedef NS_ENUM(NSInteger, ZPStatus) {

    ZPNoBeginAnimation = 0,
    ZPBeginAnimation   = 1,
    ZPEndAnimation     = 2

};

@interface ZProgressButton : UIButton

@property (nonatomic, assign, readonly) ZPStatus zpstatus;

+ (instancetype)initWithFrame:(CGRect)frame circleFrame:(CGRect)circleFrame strokeColor:(UIColor *)strokeColor backgroundColor:(UIColor *)backgroundColor duration:(CGFloat)duration;

- (void)beginAnimation;

- (void)endAnimation;

@end
