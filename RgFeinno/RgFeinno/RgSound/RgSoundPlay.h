//
//  RgSoundPlay.h
//  RgFeinno
//
//  Created by Rogue Andy on 16/9/2.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RgSoundPlay : NSObject

+ (instancetype)soundWithFilePath:(NSString *)filePath;

/**
 *  开始播放并且启动监测声波变化，此方法包含了 - (void)beginRecord 方法
 *
 *  @param changeBlock 启动声波之后，比如进行一些动画效果，自己添加回调功能
 */

- (void)startMonitorAndChangeBlock:(void (^)(CGFloat progress))changeBlock;

/**
 *  结束录音
 */

- (void)endRecord;

@end
