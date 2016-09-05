//
//  RgHttpServers.h
//  ConnectDemo_IOS
//
//  Created by Rogue on 16/7/18.
//  Copyright © 2016年 Rogue. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RgHTTPResponceType) {
    
    RgHTTPResponceSuccess            = 1,
    RgHTTPResponceTimeOut            = -1,
    RgHTTPResponceAccessTokenInvalid = -2
    
};

@interface RgHttpServers : NSObject

/**
 *  普通接口地址
 *
 *  @param headers    请求头参数设置，可以不设置即为默认
 *  @param URLString  地址
 *  @param parameters 参数
 *  @param complete   回调函数
 *
 *  @return 任务
 */

+ (NSURLSessionDataTask *)POST:(NSString *)URLString headers:(NSDictionary *)headers parameters:(id)parameters completeHandle:(void (^) (NSURLSessionDataTask *task, id responceObject, NSError *error, NSString *message, NSInteger messageType))complete;

/**
 *  上传文件
 *
 *  @param URLString  地址
 *  @param headers    请求头参数设置，可以不设置即为默认
 *  @param fileName   文件名称,而且必须写完整 例如图片  picture.jpg
 *  @param mineType   文件类型 e'g image/jpeg
 *  @param parameters 参数
 *  @param datas      文件流
 *  @param complete   回调函数
 *
 *  @return 任务
 */

+ (NSURLSessionDataTask *)POST:(NSString *)URLString headers:(NSDictionary *)headers fileName:(NSString *)fileName mineType:(NSString *)mineType parameters:(id)parameters datas:(NSData *)datas completeHandle:(void (^) (NSURLSessionDataTask *task, id responceObject, NSError *error, NSString *message, NSInteger messageType))complete;

/**
 *  上传图片
 *
 *  @param URLString  图片
 *  @param headers    请求头参数设置，可以不设置即为默认
 *  @param imageName  文件名称，如果没有名称，则默认用时间戳来命名
 *  @param parameters 参数
 *  @param datas      文件流
 *  @param complete   回调函数
 *
 *  @return 任务
 */

+ (NSURLSessionDataTask *)POST:(NSString *)URLString headers:(NSDictionary *)headers imageName:(NSString *)imageName parameters:(id)parameters datas:(NSData *)datas completeHandle:(void (^) (NSURLSessionDataTask *task, id responceObject, NSError *error, NSString *message, NSInteger messageType))complete;

@end
