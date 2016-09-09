//
//  RgBugly.m
//  RgFeinno
//
//  Created by Rogue Andy on 16/9/9.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import "RgBugly.h"
#import <Bugly/Bugly.h>

@implementation RgBugly

+ (void)buglyWithAppid:(NSString *)appid {

    [Bugly startWithAppId:appid];

}

@end
