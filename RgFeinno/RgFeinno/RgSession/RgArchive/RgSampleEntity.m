//
//  RgSampleEntity.m
//  RgFeinno
//
//  Created by Rogue Andy on 16/9/6.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import "RgSampleEntity.h"

@implementation RgSampleEntity

/**
 *  定义清楚，当对象存储到文件里时候，存储的对象的属性
 *
 *  @param aCoder
 */

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.username forKey:@"username"];
    [aCoder encodeInteger:self.userage forKey:@"userage"];
    [aCoder encodeDouble:self.height forKey:@"height"];
    
}

/**
 *  把对象从文件中读取出来
 *
 *  @param aDecoder
 *
 *  @return 对象
 */

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if(self = [super init]) {
        
        self.username = [aDecoder decodeObjectForKey:@"username"];
        self.userage = [aDecoder decodeIntegerForKey:@"userage"];
        self.height = [aDecoder decodeDoubleForKey:@"height"];
        
    }
    
    return self;
    
}


@end




@implementation RgTwoEntity

- (void)encodeWithCoder:(NSCoder *)aCoder {

    [aCoder encodeObject:self.username forKey:@"username"];
    [aCoder encodeObject:self.cuohao forKey:@"cuohao"];

}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {

    if(self = [super init]) {
    
        self.username = [aDecoder decodeObjectForKey:@"username"];
        self.cuohao = [aDecoder decodeObjectForKey:@"cuohao"];
    
    }
    
    return self;

}

@end
