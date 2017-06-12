//
//  RgCamera.h
//  RgFeinno
//
//  Created by Rogue Andy on 16/8/29.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  相片类型
 */
typedef NS_ENUM(NSInteger, RgCameraPhoto) {
    /**
     *  拍摄相片
     */
    RgCameraPhotoShoot       = 0,
    /**
     *  本地相册
     */
    RgCameraPhotoLocalSource = 1
};

/**
 *  视频类型
 */
typedef NS_ENUM(NSInteger, RgCameraVideo) {
    /**
     *  拍摄视频
     */
    RgCameraVideoShoot       = 0,
    /**
     *  本地视频
     */
    RgCameraVideoLocalSource = 1,
    
    RgCameraVideoShootCool   = 2
};

@interface RgCamera : UIImagePickerController

/**
 *  打开相册或者拍照使用的方法
 *
 *  @param type             拍照类型
 *  @param fontColor        导航栏字体颜色
 *  @param barColor         导航栏背景颜色
 *  @param parentController 使用 pushViewController 方法的主宰类
 *  @param complete         在存在回调方法的时候，需要手动设置让 UIImagePickerController 类消失，比如执行完回调，用 [caremaEntity dismissViewControllerAnimated: YES completion: nil] , 如果回调方法为 nil 则不用用户手动执行，程序会自动执行 dismissViewControllerAnimated 方法
 *
 *  @return 相机实体
 */

+ (instancetype)cameraPhotoType:(RgCameraPhoto)type barFontColor:(UIColor *)fontColor barColor:(UIColor *)barColor pushInParentController:(UIViewController *)parentController didFinishPickingPhotoWithInfo:(void (^)(NSDictionary *cameraInfo, UIImagePickerController *caremaEntity))complete;

/**
 打开本地视频或录制视频使用的方法

 @param type 视频类型
 @param fontColor 导航栏字体颜色
 @param barColor 导航栏背景颜色
 @param videoMaxSecond 视频录制秒数限制(如果时长设置为 0, 代表不限制拍摄视频的时长)
 @param videoMaxSize 视频录制大小限制(如果大小设置为 0, 代表不限制拍摄视频的大小)
 @param parentController 使用 pushViewController 方法的主宰类
 @param complete 在存在回调方法的时候，需要手动设置让 UIImagePickerController 类消失，比如执行完回调，用 [caremaEntity dismissViewControllerAnimated: YES completion: nil] , 如果回调方法为 nil 则不用用户手动执行，程序会自动执行 dismissViewControllerAnimated 方法
 @return 相机实体
 */

+ (instancetype)cameraVideoType:(RgCameraVideo)type barFontColor:(UIColor *)fontColor barColor:(UIColor *)barColor maxSecond:(CGFloat)videoMaxSecond maxSize:(CGFloat)videoMaxSize pushInParentController:(UIViewController *)parentController didFinishPickingVideoWithInfo:(void (^)(NSString *videoURL, UIImagePickerController *caremaEntity))complete;

@end
