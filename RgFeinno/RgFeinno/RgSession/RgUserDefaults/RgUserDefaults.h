//
//  RgUserDefaults.h
//  RgFeinno
//
//  Created by Rogue Andy on 16/9/5.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RgUserDefaults : NSObject

+ (void)setObject:(NSObject *)anObject forKey:(NSString *)aKey;

+ (NSObject *)objectForKey:(NSString *)aKey;

+ (void)removeAllObject;

+ (void)removeObjectWithKey:(NSString *)akey;

@end
