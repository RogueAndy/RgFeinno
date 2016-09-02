//
//  RgZipArchive.h
//  RgFeinno
//
//  Created by Rogue Andy on 16/9/2.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RgZipArchive : NSObject

/**
 *  解压文件
 *
 *  @param path        加压文件的路径，例如 .zip .rar
 *  @param destination 解压后输出文件的路径
 *
 *  @return 解压是否成功
 */

+ (BOOL)unzipFileAtPath:(NSString *)path toDestination:(NSString *)destination;

/**
 *  压缩文件
 *
 *  @param path  压缩文件的路径
 *  @param paths 压缩文件后输出的路径
 *
 *  @return 压缩文件是否成功
 */

+ (BOOL)createZipFileAtPath:(NSString *)path withFilesAtPaths:(NSArray *)paths;

@end
