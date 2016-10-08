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
 *  普通接口地址,但是使用 afn 默认进行一些加密
 *
 *  @param headers    请求头参数设置，可以不设置即为默认 @{@"accept": @"application/json", @"Content-Type": @"application/json"}
 *  @param URLString  地址
 *  @param parameters 参数
 *  @param complete   回调函数
 *
 *  @return 任务
 */

+ (NSURLSessionDataTask *)POSTWithAFN:(NSString *)URLString headers:(NSDictionary *)headers parameters:(id)parameters completeHandle:(void (^)(NSURLSessionDataTask *, id, NSError *, NSString *, NSInteger))complete;

/**
 *  普通接口地址,没有使用 afn 默认的参数加密方式
 *
 *  @param headers    请求头参数设置，可以不设置即为默认 @{@"accept": @"application/json", @"Content-Type": @"application/json"}
 *  @param URLString  地址
 *  @param parameters 参数
 *  @param complete   回调函数
 *
 *  @return 任务
 */

+ (NSURLSessionDataTask *)POST:(NSString *)URLString headers:(NSDictionary *)headers parameters:(id)parameters completeHandle:(void (^) (NSURLSessionDataTask *task, id responceObject, NSError *error, NSString *message, NSInteger messageType))complete;

/**
 *  上传文件,没有使用 afn 默认的参数加密方式
 *
 *  @param URLString  地址
 *  @param headers    请求头参数设置，可以不设置即为默认 @{@"accept": @"application/json", @"Content-Type": @"application/json"}
 *  @param fileName   文件名称,而且必须写完整 例如图片  picture.jpg
 *  @param mineType   文件类型 e'g image/jpeg ,video
 *  @param parameters 参数
 *  @param datas      文件流(图片或视频转化成 NSData 类型之后)
 *  @param complete   回调函数
 *
 *  @return 任务
 */

+ (NSURLSessionDataTask *)POST:(NSString *)URLString headers:(NSDictionary *)headers fileName:(NSString *)fileName mineType:(NSString *)mineType parameters:(id)parameters datas:(NSData *)datas completeHandle:(void (^) (NSURLSessionDataTask *task, id responceObject, NSError *error, NSString *message, NSInteger messageType))complete;

/**
 *  上传文件,使用 afn 默认的参数加密方式
 *
 *  @param URLString  地址
 *  @param headers    请求头参数设置，可以不设置即为默认 @{@"accept": @"application/json", @"Content-Type": @"application/json"}
 *  @param fileName   文件名称,而且必须写完整 例如图片  picture.jpg
 *  @param mineType   文件类型 e'g image/jpeg ,video
 *  @param parameters 参数
 *  @param datas      文件流(图片或视频转化成 NSData 类型之后)
 *  @param complete   回调函数
 *
 *  @return 任务
 */

+ (NSURLSessionDataTask *)POSTWithAFN:(NSString *)URLString headers:(NSDictionary *)headers fileName:(NSString *)fileName mineType:(NSString *)mineType parameters:(id)parameters datas:(NSData *)datas completeHandle:(void (^) (NSURLSessionDataTask *task, id responceObject, NSError *error, NSString *message, NSInteger messageType))complete;

/**
 *  上传图片
 *
 *  @param URLString  图片
 *  @param headers    请求头参数设置，可以不设置即为默认 @{@"accept": @"application/json", @"Content-Type": @"application/json"}
 *  @param imageName  文件名称，如果没有名称，则默认用时间戳来命名
 *  @param parameters 参数
 *  @param datas      文件流
 *  @param complete   回调函数
 *
 *  @return 任务
 */

+ (NSURLSessionDataTask *)POST:(NSString *)URLString headers:(NSDictionary *)headers imageName:(NSString *)imageName parameters:(id)parameters datas:(NSData *)datas completeHandle:(void (^) (NSURLSessionDataTask *task, id responceObject, NSError *error, NSString *message, NSInteger messageType))complete;

/**
 *  图片上传
 *
 *  @param URLString  地址
 *  @param headers    http 头部描述 @{@"accept": @"application/json", @"Content-Type": @"application/json"}
 *  @param imageName  图片名字
 *  @param parameters 参数
 *  @param datas      图片
 *  @param complete   回调函数
 *
 *  @return 任务
 */

+ (NSURLSessionDataTask *)POSTWithAFN:(NSString *)URLString headers:(NSDictionary *)headers imageName:(NSString *)imageName parameters:(id)parameters datas:(NSData *)datas completeHandle:(void (^) (NSURLSessionDataTask *task, id responceObject, NSError *error, NSString *message, NSInteger messageType))complete;

/**
 *  新媒农信上传图片至服务器
 *
 *  @param URLString  地址
 *  @param headers    http 头部描述 @{@"accept": @"application/json", @"Content-Type": @"application/json"}
 *  @param imageName  图片名字
 *  @param parameters 参数
 *  @param datas      图片
 *  @param dictionary formData 添加的参数
 *  @param complete   回调函数
 *
 *  @return 任务
 */

+ (NSURLSessionDataTask *)POSTImageWithFeinno:(NSString *)URLString headers:(NSDictionary *)headers imageName:(NSString *)imageName parameters:(id)parameters datas:(NSData *)datas formParameter:(NSDictionary *)dictionary completeHandle:(void (^) (NSURLSessionDataTask *task, id responceObject, NSError *error, NSString *message, NSInteger messageType))complete;

@end
