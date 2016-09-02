//
//  RgZipArchive.m
//  RgFeinno
//
//  Created by Rogue Andy on 16/9/2.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import "RgZipArchive.h"
#import "SSZipArchive.h"

@implementation RgZipArchive

+ (BOOL)unzipFileAtPath:(NSString *)path toDestination:(NSString *)destination {

    return [SSZipArchive unzipFileAtPath:path toDestination:destination];

}

+ (BOOL)createZipFileAtPath:(NSString *)path withFilesAtPaths:(NSArray *)paths {

    return [SSZipArchive createZipFileAtPath:path withFilesAtPaths:paths];

}

@end
