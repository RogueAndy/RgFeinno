//
//  RgUMPush.h
//  RgFeinno
//
//  Created by Rogue Andy on 16/9/1.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RgUMPush : NSObject

/**
 *  设置 umeng 推送的基本配置，该方法必须在 AppDelegate.m 文件的 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 方法里执行
 *
 *  @param appkey        友盟推送的 appkey
 *  @param launchOptions 参数
 *  @param isPrint       是否打印出推送日志
 */

+ (void)startWithAppkey:(NSString *)appkey launchOptions:(NSDictionary *)launchOptions printLogs:(BOOL)isPrint;

/**
 *  接受推送的信息，该方法必须在 AppDelegate.m 文件的 - (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo 方法里执行
 *
 *  @param userInfo 参数信息
 */

+ (void)didReceiveRemoteNotification:(NSDictionary *)userInfo;

/**
 *  在 AppDelegate.m 文件的 - (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken 方法里，传入获取得到的 deviceToken ，来获取 NSString 类型的 deviceToken （因为在友盟推送的开发环境，需要手动获取 deviceToken，而且要在后台设置 "production_mode" 为 "false", 查询 deviceToken 在上述方法执行此行代码）
 *
 *  @param deviceTokenData 二进制文件
 *
 *  @return 可视化字符串 deviceToken
 */

+ (NSString *)deviceTokenByData:(NSData *)deviceTokenData;

@end
