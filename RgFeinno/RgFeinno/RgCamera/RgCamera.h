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
    RgCameraVideoLocalSource = 1
};

@interface RgCamera : UIImagePickerController

/**
 *  打开相册或者拍照使用的方法
 *
 *  @param type             相册或者拍照类型
 *  @param fontColor        导航栏字体颜色
 *  @param barColor         导航栏背景颜色
 *  @param parentController 使用 pushViewController 方法的主宰类
 *  @param complete         回调返回相片数据
 *
 *  @return 相机实体
 */

+ (instancetype)cameraPhotoType:(RgCameraPhoto)type barFontColor:(UIColor *)fontColor barColor:(UIColor *)barColor pushInParentController:(UIViewController *)parentController didFinishPickingPhotoWithInfo:(void (^)(NSDictionary *cameraInfo, UIImagePickerController *caremaEntity))complete;

/**
 *  打开拍摄或者拍照使用的方法
 *
 *  @param type             视频或者拍照类型
 *  @param fontColor        导航栏字体颜色
 *  @param barColor         导航栏背景颜色
 *  @param parentController 使用 pushViewController 方法的主宰类
 *  @param complete         回调返回视频地址数据
 *
 *  @return 相机实体
 */

+ (instancetype)cameraVideoType:(RgCameraVideo)type barFontColor:(UIColor *)fontColor barColor:(UIColor *)barColor maxSecond:(CGFloat)videoMaxSecond maxSize:(CGFloat)videoMaxSize pushInParentController:(UIViewController *)parentController didFinishPickingVideoWithInfo:(void (^)(NSString *videoURL, UIImagePickerController *caremaEntity))complete;

@end
