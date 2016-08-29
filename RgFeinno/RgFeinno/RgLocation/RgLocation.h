//
//  RgLocation.h
//  RgFeinno
//
//  Created by Rogue Andy on 16/8/29.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface RgLocation : NSObject

/**
 *  请求定位并且返回定位之后的数据
 *
 *  @param locationComplete 回调成功返回定位的数据，否则返回 nil
 */

+ (void)requestLocation:(void (^)(CLPlacemark *place))locationComplete;

@end
