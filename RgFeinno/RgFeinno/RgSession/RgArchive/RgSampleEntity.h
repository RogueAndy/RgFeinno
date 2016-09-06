//
//  RgSampleEntity.h
//  RgFeinno
//
//  Created by Rogue Andy on 16/9/6.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RgSampleEntity : NSObject<NSCoding>

@property (nonatomic, strong) NSString *username;

@property (nonatomic, assign) NSInteger userage;

@property (nonatomic, assign) double height;

@end


@interface RgTwoEntity : NSObject<NSCoding>

@property (nonatomic, strong) NSString *username;

@property (nonatomic, strong) NSString *cuohao;

@end