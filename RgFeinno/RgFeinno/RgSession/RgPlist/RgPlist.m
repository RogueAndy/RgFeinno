//
//  RgPlist.m
//  RgFeinno
//
//  Created by Rogue Andy on 16/9/6.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import "RgPlist.h"

static NSString *Rg_Archive_Plist_Name = @"RgArchiveDocuments";

@implementation RgPlist

#pragma mark - 外部调用静态方法

+ (BOOL)plistWithFileName:(NSString *)fileName dictionary:(NSDictionary *)dictionary {
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingFormat:@"/%@", Rg_Archive_Plist_Name];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL is;
    if(![fileManager fileExistsAtPath:path isDirectory:&is]) {
        
        BOOL isCreate = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        if(!isCreate) {
            
            return NO;
            
        }
        
    }
    
    path = [path stringByAppendingFormat:@"/%@.plist", fileName];
    
    return [dictionary writeToFile:path atomically:YES];
    
}

+ (BOOL)plistWithFileName:(NSString *)fileName addDictionary:(NSDictionary *)dictionary {

    NSMutableDictionary *mutable = [NSMutableDictionary dictionaryWithDictionary:[self plistDictionaryWitFileName:fileName]];
    [mutable addEntriesFromDictionary:dictionary];
    
    return [self plistWithFileName:fileName dictionary:mutable];

}

+ (BOOL)plistWithFileName:(NSString *)fileName array:(NSArray *)array {

    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingFormat:@"/%@", Rg_Archive_Plist_Name];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL is;
    if(![fileManager fileExistsAtPath:path isDirectory:&is]) {
        
        BOOL isCreate = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        if(!isCreate) {
            
            return NO;
            
        }
        
    }
    
    path = [path stringByAppendingFormat:@"/%@.plist", fileName];
    
    return [array writeToFile:path atomically:YES];

}

+ (BOOL)plistWithFileName:(NSString *)fileName addArray:(NSArray *)array {

    NSMutableArray *mutable = [NSMutableArray arrayWithArray:[self plistArrayWitFileName:fileName]];
    [mutable addObjectsFromArray:array];
    
    return [self plistWithFileName:fileName array:mutable];

}

+ (NSDictionary *)plistDictionaryWitFileName:(NSString *)fileName {

    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingFormat:@"/%@/%@.plist", Rg_Archive_Plist_Name, fileName];
    return [[NSDictionary alloc] initWithContentsOfFile:path];

}

+ (NSArray *)plistArrayWitFileName:(NSString *)fileName {

    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingFormat:@"/%@/%@.plist", Rg_Archive_Plist_Name, fileName];
    return [[NSArray alloc] initWithContentsOfFile:path];

}

@end
