//
//  RgLoadingController.h
//  RogueKitDemo
//
//  Created by Rogue on 15/12/17.
//  Copyright © 2015年 Rogue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>

/**
 *  用户提示的类型
 */
typedef NS_ENUM(NSInteger, RgLoadingType) {
    /**
     *  默认的用户提示方法
     */
    RgLoadingDefault     = 0,
    /**
     *  用 gif 动图生成用户提示
     */
    RgLoadingGIF         = 1,
    /**
     *  用 imageView 动画来生成用户提示，需要导入用户的图片数组
     */
    RgLoadingImageArrays = 2
};

@interface RgLoadingController : UIViewController

/**
 *  显示菊花
 *
 *  @param onViewController 某个控制器
 */

+ (void)showLoadingActivityViewOn:(UIViewController *)onViewController;

/**
 *  用户提示
 *
 *  @param onViewController 显示在某个控制器上
 *  @param title            显示提示语
 */

+ (void)showLoadingActivityViewOn:(UIViewController *)onViewController withTitle:(NSString *)title;

/**
 *  显示菊花后隔段时间自动隐藏
 *
 *  @param onViewController 控制器
 *  @param title            提示语
 *  @param after            开始到自动隐藏前的时间
 *  @param completeBlock    隐藏完毕后执行的动作
 */

+ (void)showLoadingSoonDisplayActivityViewOn:(UIViewController *)onViewController withTitle:(NSString *)title withAfter:(CGFloat)after withComplete:(void(^)(void))completeBlock;

/***********************************************  以上方法废弃，默认使用菊花  *******************************************************/

/**
 *  显示菊花
 *
 *  @param onViewController 在具体的控制器上
 *  @param type             普通类型还是 GIF 动图类型
 */

+ (void)showLoadingActivityViewOn:(UIViewController *)onViewController hudType:(RgLoadingType)type;

/**
 *  显示菊花
 *
 *  @param onViewController 在具体的控制器上
 *  @param type             普通类型还是 GIF 动图类型
 *  @param parameter        如果是普通类型，则代表文本，如果是 gif 类型则代表 gif 动图名称
 */

+ (void)showLoadingActivityViewOn:(UIViewController *)onViewController hudType:(RgLoadingType)type titleOrGif:(NSString *)parameter;

/**
 *  显示菊花
 *
 *  @param onViewController 在具体的控制器上
 *  @param type             普通类型还是 GIF 动图类型
 *  @param parameter        如果是普通类型，则代表文本，如果是 gif 类型则代表 gif 动图名称
 *  @param after            设置自动消失结束所需要的时间
 *  @param completeBlock    完成后所执行的 闭包 方法
 */

+ (void)showLoadingSoonDisplayActivityViewOn:(UIViewController *)onViewController hudType:(RgLoadingType)type titleOrGif:(NSString *)parameter withAfter:(CGFloat)after withComplete:(void(^)(void))completeBlock;

/**
 *  隐藏句话
 *
 *  @param onViewController 某个控制器
 */

+ (void)hideLoadingActivityViewOn:(UIViewController *)onViewController;


/***********************************************  0.1.6新增方法，使用图片数组生成帧动画  *******************************************************/

/**
 *  用户提示
 *
 *  @param onViewController 在具体的控制器上
 *  @param timer            循环一次动画所需要的时间
 *  @param imageNames       用图片数组来存入 imageView ,从而生成帧动画
 */

+ (void)showLoadingActivityViewOn:(UIViewController *)onViewController repeatTimer:(NSTimeInterval)timer animationImageNames:(NSArray *)imageNames;

/**
 *  用户提示
 *
 *  @param onViewController 在具体的控制器上
 *  @param timer            循环一次动画所需要的时间
 *  @param imageNames       用图片数组来存入 imageView ,从而生成帧动画
 *  @param after            设置自动消失的时间
 *  @param completeBlock    消失之后执行的回调方法
 */

+ (void)showLoadingSoonDisplayActivityViewOn:(UIViewController *)onViewController repeatTimer:(NSTimeInterval)timer animationImageNames:(NSArray *)imageNames withAfter:(CGFloat)after withComplete:(void(^)(void))completeBlock;

@end
