//
//  RgHttpDealParameters.h
//  NongXingTong
//
//  Created by Rogue on 16/7/19.
//  Copyright © 2016年 Rogue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RgHttpDealParameters : NSObject

/**
 *  普通接口地址
 *
 *  @param URLString  地址
 *  @param parameters 需要 3des 加密的参数
 *  @param complete   回调函数
 *
 *  @return 任务
 */

+ (NSURLSessionDataTask *)POSTURLWith3Des:(NSString *)URLString parameters:(id)parameters completeHandle:(void (^) (NSURLSessionDataTask *task, id responceObject, NSError *error, NSString *message, NSInteger messageType))complete;

/**
 *  普通接口地址
 *
 *  @param URLString  地址
 *  @param parameters 需要 3des 加密的参数
 *  @param complete   回调函数
 *
 *  @return 任务
 */

+ (NSURLSessionDataTask *)POSTURL:(NSString *)URLString parameters:(id)parameters completeHandle:(void (^) (NSURLSessionDataTask *task, id responceObject, NSError *error, NSString *message, NSInteger messageType))complete;

/**
 *  图片接口地址
 *
 *  @param URLString  地址
 *  @param parameters 需要 3des 加密的参数
 *  @param datas      流文件
 *  @param complete   回调函数
 *
 *  @return 任务
 */

+ (NSURLSessionDataTask *)POSTURLWith3Des:(NSString *)URLString parameters:(id)parameters datas:(NSData *)datas completeHandle:(void (^) (NSURLSessionDataTask *task, id responceObject, NSError *error, NSString *message, NSInteger messageType))complete;

/**
 *  图片接口地址
 *
 *  @param URLString  地址
 *  @param parameters 需要 3des 加密的参数
 *  @param datas      流文件
 *  @param complete   回调函数
 *
 *  @return 任务
 */

+ (NSURLSessionDataTask *)POSTURL:(NSString *)URLString parameters:(id)parameters datas:(NSData *)datas completeHandle:(void (^) (NSURLSessionDataTask *task, id responceObject, NSError *error, NSString *message, NSInteger messageType))complete;

@end
