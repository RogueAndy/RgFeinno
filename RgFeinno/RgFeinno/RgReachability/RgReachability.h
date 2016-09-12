//
//  RgReachability.h
//  RgFeinno
//
//  Created by Rogue Andy on 16/9/12.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RgReachability : NSObject

/**
 *  只需要在 AppDelegate.m 文件的 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 方法里调用一次该方法
 */

+ (void)startNotifier;

@end
