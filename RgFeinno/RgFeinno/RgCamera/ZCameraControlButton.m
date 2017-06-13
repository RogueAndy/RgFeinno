//
//  ZCameraControlButton.m
//  RgFeinno
//
//  Created by rogue on 2017/6/13.
//  Copyright © 2017年 RogueAndy. All rights reserved.
//

#import "ZCameraControlButton.h"

@interface ZCameraControlButton()

@property (nonatomic, assign) ZCameraButtonType zcButtonType;

@end

@implementation ZCameraControlButton

+ (instancetype)initWithCameraButtonType:(ZCameraButtonType)type frame:(CGRect)frame {

    ZCameraControlButton *button = [ZCameraControlButton buttonWithType:UIButtonTypeCustom];
    button.zcButtonType = type;
    button.frame = frame;
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = CGRectGetWidth(frame) / 2.0;
    button.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    return button;

}

- (void)drawRect:(CGRect)rect {

    [super drawRect:rect];
    
    switch (self.zcButtonType) {
        case ZCCloseDownButton:
        {
        
            UIColor *color = [UIColor colorWithRed:150/255.f green:150/255.f blue:150/255.f alpha:1];
            [color set];
            
            UIBezierPath *path = [UIBezierPath bezierPath];
            path.lineWidth = 2;
            [path moveToPoint:CGPointMake(CGRectGetWidth(self.frame) / 5.0, CGRectGetWidth(self.frame) / 3.0 + CGRectGetWidth(self.frame) / 20.0)];
            [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame) / 2.0, CGRectGetWidth(self.frame) * 2 / 3.0 + CGRectGetWidth(self.frame) / 20.0)];
            [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame) * 4 / 5.0, CGRectGetWidth(self.frame) / 3.0 + CGRectGetWidth(self.frame) / 20.0)];
            [path stroke];
        
        }
            break;
        
        case ZCCloseXButton:
        {
            
            UIColor *color = [UIColor colorWithRed:150/255.f green:150/255.f blue:150/255.f alpha:1];
            [color set];
            
            UIBezierPath *pathLeft = [UIBezierPath bezierPath];
            pathLeft.lineWidth = 2;
            [pathLeft moveToPoint:CGPointMake(CGRectGetWidth(self.frame) / 4.0 + CGRectGetWidth(self.frame) / 20.0, CGRectGetWidth(self.frame) / 4.0)];
            [pathLeft addLineToPoint:CGPointMake(CGRectGetWidth(self.frame) * 3 / 4.0 - CGRectGetWidth(self.frame) / 20.0, CGRectGetWidth(self.frame) * 3 / 4.0)];
            [pathLeft stroke];
            
            UIBezierPath *pathRight = [UIBezierPath bezierPath];
            pathRight.lineWidth = 2;
            [pathRight moveToPoint:CGPointMake(CGRectGetWidth(self.frame) * 3 / 4.0 - CGRectGetWidth(self.frame) / 20.0, CGRectGetWidth(self.frame) / 4.0)];
            [pathRight addLineToPoint:CGPointMake(CGRectGetWidth(self.frame) / 4.0 + CGRectGetWidth(self.frame) / 20.0, CGRectGetWidth(self.frame) * 3 / 4.0)];
            [pathRight stroke];
            
        }
            break;
            
        case ZCRightButton:
        {
            
            UIColor *color = [UIColor colorWithRed:150/255.f green:150/255.f blue:150/255.f alpha:1];
            [color set];
            
            UIBezierPath *path = [UIBezierPath bezierPath];
            path.lineWidth = 2;
            [path moveToPoint:CGPointMake(CGRectGetWidth(self.frame) / 5.0, CGRectGetWidth(self.frame) * 2 / 5.0 + CGRectGetWidth(self.frame) / 20.0)];
            [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame) * 3 / 7.0, CGRectGetWidth(self.frame) * 2 / 3.0 + CGRectGetWidth(self.frame) / 20.0)];
            [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame) * 4 / 5.0, CGRectGetWidth(self.frame) / 5.0 + CGRectGetWidth(self.frame) / 20.0)];
            [path stroke];
            
        }
            break;
    
    }

}

@end
