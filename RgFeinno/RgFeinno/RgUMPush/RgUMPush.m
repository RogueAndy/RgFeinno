//
//  RgUMPush.m
//  RgFeinno
//
//  Created by Rogue Andy on 16/9/1.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import "RgUMPush.h"
#import "UMessage.h"

@implementation RgUMPush

+ (void)startWithAppkey:(NSString *)appkey launchOptions:(NSDictionary *)launchOptions printLogs:(BOOL)isPrint {

    [UMessage startWithAppkey:appkey launchOptions:launchOptions];
    [UMessage registerForRemoteNotifications];
    [UMessage setLogEnabled:isPrint];

}

+ (void)didReceiveRemoteNotification:(NSDictionary *)userInfo {

    [UMessage didReceiveRemoteNotification:userInfo];

}

+ (NSString *)deviceTokenByData:(NSData *)deviceTokenData {

    return [[[[deviceTokenData description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];

}

@end
