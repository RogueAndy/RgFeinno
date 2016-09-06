//
//  RgArchive.h
//  RgFeinno
//
//  Created by Rogue Andy on 16/9/6.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RgArchive : NSObject

/**
 *  归档文件名设置，归档之后的文件都是以 NSArray 存储的
 *
 *  @param fileName 文件名称，比如想要 text.txt 只需写入 text 而不用添加后缀 .txt (对于同一文件名，使用此方法，相当于覆盖以前的内容)
 *  @param object   归档的 NSObject 对象
 *
 *  @return 是否归档成功
 */

+ (BOOL)archiveWithFileName:(NSString * __nonnull)fileName object:(NSObject * __nonnull)object;

/**
 *  归档，再原来文件的基础之上，添加一些内容，不会覆盖原文件的内容
 *
 *  @param fileName  文件名
 *  @param addObject 需要添加的对象
 *
 *  @return 是否归档陈宫
 */

+ (BOOL)addContentArchiveWithFileName:(NSString * __nonnull)fileName object:(NSObject * __nonnull)addObject;

/**
 *  读档文件
 *
 *  @param fileName 文件名称，不需要写入后缀
 *
 *  @return 归档读出来的对象
 */

+ (nullable NSArray *)unarchiveWitFileName:(NSString * __nonnull)fileName;

@end
