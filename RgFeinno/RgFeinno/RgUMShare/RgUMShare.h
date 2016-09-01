//
//  RgUMShare.h
//  RgFeinno
//
//  Created by Rogue Andy on 16/8/31.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  分享类型
 */
typedef NS_ENUM(NSInteger, RgUMShareType) {
    /**
     *  qq
     */
    RgQQ         = 0,
    /**
     *  qq 空间
     */
    RgQQZone     = 1,
    /**
     *  微信
     */
    RgWeiXin     = 2,
    /**
     *  朋友圈
     */
    RgWeiXinZone = 3,
    /**
     *  新浪
     */
    RgSina       = 4,
    /**
     *  短信
     */
    RgMessage    = 5
};

@interface RgUMShare : NSObject

/**
 *  在搭建好 Umeng 分享的一些基本环境之后，必须在 AppDelegate 的 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions 方法里调用此方法，来设置 Umeng 的 appkey
 *
 *  @param appkey      umeng 分享给的 appkey
 *  @param wxAppid     微信 appid
 *  @param wxSecret    微信 secret
 *  @param qqAppid     qq appid
 *  @param qqKey       qq secret
 *  @param sinaAppkey  新浪 appkey
 *  @param sinaSecret  新浪 secret
 */

+ (void)setUMSocialAPPKey:(NSString *)appkey wxAppid:(NSString *)wxAppid wxAppSecret:(NSString *)wxSecret qqAppid:(NSString *)qqAppid qqAppkey:(NSString *)qqKey sinaAppkey:(NSString *)sinaAppkey sinaSecret:(NSString *)sinaSecret;

/**
 *  在 AppDelegate 的 - (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation方法里设置 该方法来执行系统回调
 *
 *  @param url appdelegate 里的 url 参数传入
 *
 *  @return 布尔类型 
 */

+ (BOOL)handleOpenURL:(NSURL *)url;

/**
 *  弹出分享栏层  (该方法废弃，因为 前置参数 type 暂无作用)
 *
 *  @param type              分享的类型
 *  @param title             分享标题
 *  @param content           分享内容
 *  @param url               分享地址
 *  @param presentController 弹出层所在控制器
 *  @param image             分享图片
 */

+ (void)shareWithUmengType:(RgUMShareType)type title:(NSString *)title content:(NSString *)content shareUrl:(NSString *)url presentInViewController:(UIViewController *)presentController shareImage:(UIImage *)image;

/**
 *  弹出分享栏层  (请使用该方法分享，自动弹出选择栏)
 *
 *  @param title             分享标题
 *  @param content           分享内容
 *  @param url               分享地址
 *  @param presentController 弹出层所在控制器
 *  @param image             分享图片
 */

+ (void)shareWithUmengTitle:(NSString *)title content:(NSString *)content shareUrl:(NSString *)url presentInViewController:(UIViewController *)presentController shareImage:(UIImage *)image;

@end
