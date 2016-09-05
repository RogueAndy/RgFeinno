//
//  RgUserDefaults.m
//  RgFeinno
//
//  Created by Rogue Andy on 16/9/5.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import "RgUserDefaults.h"

@implementation RgUserDefaults

+ (void)setObject:(NSObject *)anObject forKey:(NSString *)aKey {

    RgUserDefaults *defaults = [[RgUserDefaults alloc] init];
    [defaults setObject:anObject forKey:aKey];
    
}

+ (NSObject *)objectForKey:(NSString *)aKey {

    RgUserDefaults *defaults = [[RgUserDefaults alloc] init];
    return [defaults objectForKey:aKey];

}

+ (void)removeAllObject {

    RgUserDefaults *defaults = [[RgUserDefaults alloc] init];
    return [defaults removeAllObject];

}

+ (void)removeObjectWithKey:(NSString *)akey {

    RgUserDefaults *defaults = [[RgUserDefaults alloc] init];
    return [defaults removeObjectWithKey:akey];

}

- (void)setObject:(NSObject *)anObject forKey:(NSString *)aKey {

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:anObject forKey:aKey];
    [defaults synchronize];

}

- (NSObject *)objectForKey:(NSString *)aKey {

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:aKey];

}

- (void)removeAllObject {

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [defaults dictionaryRepresentation];
    for (NSString *key in dic) {
        
        [defaults removeObjectForKey:key];
    
    }
    [defaults synchronize];

}

- (void)removeObjectWithKey:(NSString *)akey {

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:akey];
    [defaults synchronize];

}

@end
