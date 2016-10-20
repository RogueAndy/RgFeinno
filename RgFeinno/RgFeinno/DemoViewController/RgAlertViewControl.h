//
//  RgAlertViewControl.h
//  RgFeinno
//
//  Created by rogue on 16/10/20.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RgAlertViewControl : UIView

@property (nonatomic, strong) void (^linkAction)(NSString *linkString);

@property (nonatomic, strong) void (^leftButtonAction)(void);

@property (nonatomic, strong) void (^rightButtonAction)(void);

+ (instancetype)initWithFrame:(CGRect)frame style:(UIColor *)color;

- (void)setTitle:(NSString *)title tip:(NSString *)tip content:(NSString *)content linkAttributes:(nullable NSArray *)attributes;

@end




@interface RgAlertSingleViewControl : UIView

@property (nonatomic, strong) void (^linkAction)(NSString *linkString);

@property (nonatomic, strong) void (^singleButtonAction)(void);

+ (instancetype)initWithFrame:(CGRect)frame style:(UIColor *)color;

- (void)setTitle:(NSString *)title tip:(NSString *)tip content:(NSString *)content linkAttributes:(nullable NSArray *)attributes;


@end
