//
//  RgReachability.m
//  RgFeinno
//
//  Created by Rogue Andy on 16/9/12.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import "RgReachability.h"
#import "RealReachability.h"

@implementation RgReachability

+ (void)startNotifier {

    [GLobalRealReachability startNotifier];

}

@end
