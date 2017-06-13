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

@protocol ZProgressButtonDelegate <NSObject>

@optional

- (void)progressAnimationOver;

@end

@interface ZProgressButton : UIButton

@property (nonatomic, weak) id<ZProgressButtonDelegate> delegate;

@property (nonatomic, assign, readonly) ZPStatus zpstatus;

/**
 new 对象

 @param frame 按钮大小
 @param circleFrame 按钮环状大小
 @param strokeColor 填充环内颜色
 @param backgroundColor 背景色
 @param duration 总时间设置
 @param isShow 是否显示倒计时
 @param attribution 倒计时字体颜色大小设置
 @return 实例
 */
+ (instancetype)initWithFrame:(CGRect)frame circleFrame:(CGRect)circleFrame strokeColor:(UIColor *)strokeColor backgroundColor:(UIColor *)backgroundColor duration:(CGFloat)duration countdown:(BOOL)isShow countdownAttribution:(NSDictionary *)attribution;

/**
 开始动画
 */
- (void)beginAnimation;

/**
 结束动画
 */
- (void)endAnimation;

/**
 重置动画
 */
- (void)reset;

@end
