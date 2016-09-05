//
//  RgSound.h
//  RgFeinno
//
//  Created by Rogue Andy on 16/9/1.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RgSoundRecord : NSObject

/**
 *  创建录音文件以及文件名
 *
 *  @param fileName 文件名
 *
 *  @return 对象
 */

+ (instancetype)soundRecordWithName:(NSString *)fileName;

/**
 *  开始录音
 */

- (void)beginRecord;

/**
 *  暂停录音（较少使用）
 */

- (void)pause;

/**
 *  结束录音
 */

- (void)endRecord;

/**
 *  播放当前录音
 */

- (void)readRecord;

/**
 *  开始录音并且启动监测声波变化，此方法包含了 - (void)beginRecord 方法
 *
 *  @param changeBlock 启动声波之后，比如进行一些动画效果，自己添加回调功能
 */

- (void)startMonitorAndChangeBlock:(void (^)(CGFloat progress))changeBlock;

@end
