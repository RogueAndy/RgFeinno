//
//  RgAlertView.h
//  RgFeinno
//
//  Created by rogue on 16/10/18.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RgAlertView : UIView

+ (instancetype)initWithFrame:(CGRect)frame style:(UIColor *)color;

- (void)setTitle:(NSString *)title tip:(NSString *)tip content:(NSString *)content;

@end
