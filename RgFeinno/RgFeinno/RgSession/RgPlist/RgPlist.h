//
//  RgPlist.h
//  RgFeinno
//
//  Created by Rogue Andy on 16/9/6.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RgPlist : NSObject

+ (BOOL)plistWithFileName:(NSString * __nonnull)fileName dictionary:(NSDictionary * __nonnull)dictionary;

+ (BOOL)plistWithFileName:(NSString * __nonnull)fileName addDictionary:(NSDictionary * __nonnull)dictionary;

+ (BOOL)plistWithFileName:(NSString * __nonnull)fileName array:(NSArray * __nonnull)array;

+ (BOOL)plistWithFileName:(NSString * __nonnull)fileName addArray:(NSArray * __nonnull)array;

+ (nullable NSDictionary *)plistDictionaryWitFileName:(NSString * __nonnull)fileName;

+ (nullable NSArray *)plistArrayWitFileName:(NSString * __nonnull)fileName;

@end
