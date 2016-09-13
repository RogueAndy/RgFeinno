//
//  RgHttpDealParameters.m
//  NongXingTong
//
//  Created by Rogue on 16/7/19.
//  Copyright © 2016年 Rogue. All rights reserved.
//

#import "RgHttpDealParameters.h"
#import "Security3DES.h"
#import "RgHttpServers.h"

@implementation RgHttpDealParameters

+ (NSURLSessionDataTask *)POSTURLWith3Des:(NSString *)URLString parameters:(id)parameters completeHandle:(void (^)(NSURLSessionDataTask *, id, NSError *, NSString *, NSInteger))complete {
    
    NSString *parameterString = [self DataTOjsonString:parameters];
    parameterString = [Security3DES encrypt:parameterString];
    return [RgHttpServers POST:URLString
                       headers:@{@"accept": @"application/json"}
                    parameters:parameters
                completeHandle:complete];
    
}

+ (NSURLSessionDataTask *)POSTURL:(NSString *)URLString parameters:(id)parameters completeHandle:(void (^) (NSURLSessionDataTask *task, id responceObject, NSError *error, NSString *message, NSInteger messageType))complete {

    return [RgHttpServers POSTWithAFN:URLString
                              headers:@{@"accept": @"application/json"}
                           parameters:parameters
                       completeHandle:complete];

}

+ (NSURLSessionDataTask *)POSTURLWith3Des:(NSString *)URLString parameters:(id)parameters datas:(NSData *)datas completeHandle:(void (^) (NSURLSessionDataTask *task, id responceObject, NSError *error, NSString *message, NSInteger messageType))complete {

    NSString *parameterString = [self DataTOjsonString:parameters];
    parameterString = [Security3DES encrypt:parameterString];
    
    return [RgHttpServers POST:URLString
                       headers:@{@"accept": @"application/json", @"Content-Type": @"application/json"}
                     imageName:@"test.jpg"
                    parameters:parameters
                         datas:datas
                completeHandle:complete];

}

+ (NSURLSessionDataTask *)POSTURL:(NSString *)URLString parameters:(id)parameters datas:(NSData *)datas completeHandle:(void (^) (NSURLSessionDataTask *task, id responceObject, NSError *error, NSString *message, NSInteger messageType))complete {
    
    return [RgHttpServers POSTWithAFN:URLString
                              headers:@{@"accept": @"application/json", @"Content-Type": @"application/json"}
                            imageName:@"test.jpg"
                           parameters:parameters
                                datas:datas
                       completeHandle:complete];

}

#pragma mark - 转化成 Json 格式，以便 3des 加密

+ (NSString *)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:0
                                                         error:&error];
    
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

@end
