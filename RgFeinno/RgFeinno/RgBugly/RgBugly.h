//
//  RgBugly.h
//  RgFeinno
//
//  Created by Rogue Andy on 16/9/9.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RgBugly : NSObject

/**
 *  设置 bugly 的 appid ，这个 appid 必须在腾讯 bugly 先注册，此方法在 AppDelegate.m 的 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions 方法里调用
 *
 *  @param appid 注册 腾讯 bugly 产品之后的 appid
 */

+ (void)buglyWithAppid:(NSString *)appid;

@end
