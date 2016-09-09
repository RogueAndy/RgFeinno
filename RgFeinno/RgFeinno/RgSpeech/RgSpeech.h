//
//  RgSpeech.h
//  RgFeinno
//
//  Created by Rogue Andy on 16/9/9.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RgSpeech : NSObject

/**
 *  开始播放语音，传入的参数是语音准备播放的话(如果你在播放中，或者已暂停的情况下，调用方法会停止上一次的播放内容重新播放新内容)
 *
 *  @param speechString 文字参数
 */

+ (void)startSpeech:(NSString *)speechString;

/**
 *  结束语音播放
 */

+ (void)endSpeech;

/**
 *  暂停播放
 */

+ (void)pauseSpeech;

/**
 *  继续播放
 */

+ (void)continueSpeech;

@end
