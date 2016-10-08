//
//  RgHttpServers.m
//  ConnectDemo_IOS
//
//  Created by Rogue on 16/7/18.
//  Copyright © 2016年 Rogue. All rights reserved.
//

#import "RgHttpServers.h"
#import "AFNetworking.h"

@implementation RgHttpServers

+ (NSURLSessionDataTask *)POSTWithAFN:(NSString *)URLString headers:(NSDictionary *)headers parameters:(id)parameters completeHandle:(void (^)(NSURLSessionDataTask *, id, NSError *, NSString *, NSInteger))complete {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if(headers && headers.allKeys > 0) {
        
        for(NSString *key in headers.allKeys) {
            
            [manager.requestSerializer setValue:[headers objectForKey:key] forHTTPHeaderField:key];
            
        }
        
    }
    
    manager.requestSerializer.timeoutInterval = 20;
    
    return [manager POST:URLString
              parameters:parameters
                progress:nil
                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                     
                     if(complete) {
                         complete(task, responseObject, nil, @"", RgHTTPResponceSuccess);
                     }
                     
                 }
                 failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                     
                     if (complete) {
                         complete(task, nil, error, @"网络链接失败", RgHTTPResponceTimeOut);
                     }
                     
                 }];
    
}

+ (NSURLSessionDataTask *)POST:(NSString *)URLString headers:(NSDictionary *)headers parameters:(id)parameters completeHandle:(void (^)(NSURLSessionDataTask *, id, NSError *, NSString *, NSInteger))complete {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if(headers && headers.allKeys > 0) {
    
        for(NSString *key in headers.allKeys) {
        
            [manager.requestSerializer setValue:[headers objectForKey:key] forHTTPHeaderField:key];
        
        }
    
    }
    
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString * _Nonnull(NSURLRequest * _Nonnull request, id  _Nonnull parameters, NSError * _Nullable __autoreleasing * _Nullable error) {
        
        return parameters;
        
    }];
    manager.requestSerializer.timeoutInterval = 20;
    
    return [manager POST:URLString
              parameters:parameters
                progress:nil
                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                     
                     if(complete) {
                         complete(task, responseObject, nil, @"", RgHTTPResponceSuccess);
                     }
                     
                 }
                 failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                     
                     if (complete) {
                         complete(task, nil, error, @"网络链接失败", RgHTTPResponceTimeOut);
                     }
                     
                 }];
    
}

+ (NSURLSessionDataTask *)POST:(NSString *)URLString headers:(NSDictionary *)headers fileName:(NSString *)fileName mineType:(NSString *)mineType parameters:(id)parameters datas:(NSData *)datas completeHandle:(void (^)(NSURLSessionDataTask *, id, NSError *, NSString *, NSInteger))complete {

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if(headers && headers.allKeys > 0) {
        
        for(NSString *key in headers.allKeys) {
            
            [manager.requestSerializer setValue:[headers objectForKey:key] forHTTPHeaderField:key];
            
        }
        
    }
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString * _Nonnull(NSURLRequest * _Nonnull request, id  _Nonnull parameters, NSError * _Nullable __autoreleasing * _Nullable error) {
        
        return parameters;
        
    }];
    manager.requestSerializer.timeoutInterval = 20;
    
    return [manager POST:URLString
              parameters:parameters
constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    
    [formData appendPartWithFileData:datas name:@"file" fileName:fileName mimeType:mineType];
    
}
                progress:nil
                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                     
                     if(complete) {
                         complete(task, responseObject, nil, @"", RgHTTPResponceSuccess);
                     }
                     
                 }
                 failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                     
                     if (complete) {
                         complete(task, nil, error, @"网络链接失败", RgHTTPResponceTimeOut);
                     }
                     
                 }];

}

+ (NSURLSessionDataTask *)POSTWithAFN:(NSString *)URLString headers:(NSDictionary *)headers fileName:(NSString *)fileName mineType:(NSString *)mineType parameters:(id)parameters datas:(NSData *)datas completeHandle:(void (^)(NSURLSessionDataTask *, id, NSError *, NSString *, NSInteger))complete {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if(headers && headers.allKeys > 0) {
        
        for(NSString *key in headers.allKeys) {
            
            [manager.requestSerializer setValue:[headers objectForKey:key] forHTTPHeaderField:key];
            
        }
        
    }
    
    manager.requestSerializer.timeoutInterval = 20;
    
    return [manager POST:URLString
              parameters:parameters
constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    
    [formData appendPartWithFileData:datas name:@"file" fileName:fileName mimeType:mineType];
    
}
                progress:nil
                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                     
                     if(complete) {
                         complete(task, responseObject, nil, @"", RgHTTPResponceSuccess);
                     }
                     
                 }
                 failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                     
                     if (complete) {
                         complete(task, nil, error, @"网络链接失败", RgHTTPResponceTimeOut);
                     }
                     
                 }];
    
}

+ (NSURLSessionDataTask *)POST:(NSString *)URLString headers:(NSDictionary *)headers imageName:(NSString *)imageName parameters:(id)parameters datas:(NSData *)datas completeHandle:(void (^)(NSURLSessionDataTask *, id, NSError *, NSString *, NSInteger))complete {

    if(!imageName || imageName.length == 0) {
        
        imageName = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
        imageName = [imageName stringByAppendingString:@".jpg"];
        
    }
    
    return [self POST:URLString headers:headers fileName:imageName mineType:@"image/jpeg" parameters:parameters datas:datas completeHandle:complete];

}

+ (NSURLSessionDataTask *)POSTWithAFN:(NSString *)URLString headers:(NSDictionary *)headers imageName:(NSString *)imageName parameters:(id)parameters datas:(NSData *)datas completeHandle:(void (^)(NSURLSessionDataTask *, id, NSError *, NSString *, NSInteger))complete {
    
    if(!imageName || imageName.length == 0) {
        
        imageName = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
        imageName = [imageName stringByAppendingString:@".jpg"];
        
    }
    
    return [self POSTWithAFN:URLString headers:headers fileName:imageName mineType:@"image/jpeg" parameters:parameters datas:datas completeHandle:complete];
    
}

+ (NSURLSessionDataTask *)POSTImageWithFeinno:(NSString *)URLString headers:(NSDictionary *)headers imageName:(NSString *)imageName parameters:(id)parameters datas:(NSData *)datas formParameter:(NSDictionary *)dictionary completeHandle:(void (^) (NSURLSessionDataTask *task, id responceObject, NSError *error, NSString *message, NSInteger messageType))complete {

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if(headers && headers.allKeys > 0) {
        
        for(NSString *key in headers.allKeys) {
            
            [manager.requestSerializer setValue:[headers objectForKey:key] forHTTPHeaderField:key];
            
        }
        
    }
    
    manager.requestSerializer.timeoutInterval = 20;
    
    return [manager POST:URLString
              parameters:parameters
constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    
    NSArray *keys = dictionary.allKeys;
    for(NSInteger i = 0; i < keys.count; i++) {
    
        [formData appendPartWithFormData:[dictionary objectForKey:[keys objectAtIndex:i]] name:[keys objectAtIndex:i]];
    
    }
    
    [formData appendPartWithFileData:datas name:@"file" fileName:@"shareImage.jpg" mimeType:@"jpg"];
    
}
                progress:nil
                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                     
                     if(complete) {
                         complete(task, responseObject, nil, @"", RgHTTPResponceSuccess);
                     }
                     
                 }
                 failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                     
                     if (complete) {
                         complete(task, nil, error, @"网络链接失败", RgHTTPResponceTimeOut);
                     }
                     
                 }];

}

@end
