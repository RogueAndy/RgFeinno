//
//  Security3DES.h
//  3DES
//
//  Created by 赵进雄 on 14-7-7.
//  Copyright (c) 2014年 zhaojinxiong. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <Security/Security.h>
#import "GTMBase64.h"

@interface Security3DES : NSObject

+ (NSString*)TripleDES:(NSString*)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt;

// 加密方法
+ (NSString*)encrypt:(NSString*)plainText;

// 解密方法
+ (NSString*)decrypt:(NSString*)encryptText;

/**
 *  修改了内部方法，新媒 3des 加密
 *
 *  @param plainText 参数
 *
 *  @return 加密后的值
 */

+ (NSString *)encryptFeinno:(NSString *)plainText;

@end
