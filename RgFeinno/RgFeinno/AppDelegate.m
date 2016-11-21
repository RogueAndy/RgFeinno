//
//  AppDelegate.m
//  RgFeinno
//
//  Created by Rogue Andy on 16/8/29.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import "AppDelegate.h"
#import "RgLocationViewController.h"
#import "RgScreenShotViewController.h"
#import "RgVideo.h"
#import "RgCutoutImageViewController.h"
#import "RgUMShare.h"
#import "RgUMShareViewController.h"
#import "RgUMPush.h"
#import "RgZipViewController.h"
#import "RgSoundRecordViewController.h"
#import "RgMapViewController.h"
#import "RgArchiveViewController.h"
#import "RgPlistViewController.h"
#import "RgSpeechViewController.h"
#import "RgBugly.h"
#import "RgCameraAfterViewController.h"
#import <BaiduMapAPI_Base/BMKMapManager.h>
#import "RgReachability.h"
#import "RgReachabilityViewController.h"
#import "RgUploadImageViewController.h"
#import "RgCaremaViewController.h"
#import "RgAlertViewController.h"
#import "ViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) BMKMapManager *bmkManager;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [RgUMShare setUMSocialAPPKey:@"57c69e7567e58ebb03003235" wxAppid:@"wxe98ea6c45afc0c23" wxAppSecret:@"dc4df047e348451bcf1bbb6d7358c1e5" qqAppid:@"1105589115" qqAppkey:@"ufjVdIdDTCnmlrlr" sinaAppkey:@"3611028083" sinaSecret:@"cf1f371b1beaf33042e1132c8d1d863f"];
    
    [RgUMPush startWithAppkey:@"57c7c36e67e58ec1280037a3" launchOptions:launchOptions printLogs:NO];
    
    self.bmkManager = [[BMKMapManager alloc] init];
    BOOL ret = [self.bmkManager start:@"gWVph4WasA4hUXQ3pDBZ3tc4ZTtQk2uZ" generalDelegate:nil];
    if(!ret) {
    
        NSLog(@"启动百度地图失败");
    
    }
    
    [RgReachability startNotifier];
    
    /**
     *  腾讯 bugly
     */
    [RgBugly buglyWithAppid:@"192e167175"];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    RgCameraAfterViewController *vc = [RgCameraAfterViewController new];
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = navigation;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}




/**
 *  分享的系统回调方法
 *
 *  @param application       应用
 *  @param url               地址
 *  @param sourceApplication 资源
 *  @param annotation
 *
 *  @return
 */

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [RgUMShare handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}

/**
 *  开发环境下，此处获取 deviceToken
 *
 *  @param application 应用
 *  @param deviceToken deviceToken
 */

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {

    NSLog(@"------------------------- \n%@\n-------------------------", [RgUMPush deviceTokenByData:deviceToken]);

}

/**
 *  接收推送的消息，在前台主动执行此方法，后台推送之后，点击进入前台可执行此方法
 *
 *  @param application 应用
 *  @param userInfo    推送信息
 */

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {

    NSLog(@"%@", userInfo);

}

@end
