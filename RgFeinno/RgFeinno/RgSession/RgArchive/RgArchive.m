//
//  RgArchive.m
//  RgFeinno
//
//  Created by Rogue Andy on 16/9/6.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import "RgArchive.h"

static NSString *Rg_Archive_Document_Name = @"RgArchiveDocuments";

@interface RgArchive()

@end

@implementation RgArchive

#pragma mark - 外部调用静态方法

+ (BOOL)archiveWithFileName:(NSString *)fileName object:(NSObject *)object {

    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingFormat:@"/%@", Rg_Archive_Document_Name];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL is;
    if(![fileManager fileExistsAtPath:path isDirectory:&is]) {
    
        BOOL isCreate = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        if(!isCreate) {
            
            return NO;
            
        }
        
    }
    
    path = [path stringByAppendingFormat:@"/%@.data", fileName];
    
    if(![object isKindOfClass:[NSArray class]]) {
    
        NSArray *arrays = [NSArray arrayWithObjects:object, nil];
        return [NSKeyedArchiver archiveRootObject:arrays toFile:path];
    
    }
    return [NSKeyedArchiver archiveRootObject:object toFile:path];

}

+ (BOOL)addContentArchiveWithFileName:(NSString *)fileName object:(NSObject *)addObject {

    NSMutableArray *mutableArrays = [NSMutableArray arrayWithArray:[self unarchiveWitFileName:fileName]];
    
    if([addObject isKindOfClass:[NSArray class]]) {
        
        [mutableArrays addObjectsFromArray:(NSArray *)addObject];
        
        return [self archiveWithFileName:fileName object:mutableArrays];
        
    }
    
    [mutableArrays addObject:addObject];
    
    return [self archiveWithFileName:fileName object:mutableArrays];

}

+ (NSArray *)unarchiveWitFileName:(NSString *)fileName {

    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingFormat:@"/%@/%@.data", Rg_Archive_Document_Name, fileName];
    return (NSArray *)[NSKeyedUnarchiver unarchiveObjectWithFile:path];

}

@end
