//
//  NSString+MD5.h
//  NongXingTong
//
//  Created by Rogue on 16/7/20.
//  Copyright © 2016年 Rogue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (MD5)

// MD5 hash of the file on the filesystem specified by path
+ (NSString *) stringWithMD5OfFile: (NSString *) path;
// The string's MD5 hash
- (NSString *) MD5Hash;

@end