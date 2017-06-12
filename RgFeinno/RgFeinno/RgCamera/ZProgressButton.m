//
//  ZProgressButton.m
//  ZProgress
//
//  Created by rogue on 2017/6/12.
//  Copyright © 2017年 dazhongge. All rights reserved.
//

#import "ZProgressButton.h"

@interface ZProgressButton()

@property (nonatomic, strong) CAShapeLayer *circleLayer;

@property (nonatomic, strong) UIColor *strokeColor;

@property (nonatomic, assign) CGRect circleFrame;

@property (nonatomic, assign) CGFloat animationDuration;

@property (nonatomic, assign, readwrite) ZPStatus zpstatus;

@end

@implementation ZProgressButton

+ (instancetype)initWithFrame:(CGRect)frame circleFrame:(CGRect)circleFrame strokeColor:(UIColor *)strokeColor backgroundColor:(UIColor *)backgroundColor duration:(CGFloat)duration {

    ZProgressButton *button = [ZProgressButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = backgroundColor;
    button.frame = frame;
    button.zpstatus = ZPNoBeginAnimation;
    button.strokeColor = strokeColor;
    button.circleFrame = circleFrame;
    button.animationDuration = duration;
    [button loadViews];
    [button loadLayout];
    return button;

}

- (void)beginAnimation {

    self.zpstatus = ZPBeginAnimation;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.removedOnCompletion = NO;
    animation.duration = self.animationDuration;
    animation.fromValue = @(0);
    animation.toValue = @(1);
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.circleLayer addAnimation:animation forKey:@""];

}

- (void)endAnimation {

    self.zpstatus = ZPEndAnimation;
    CFTimeInterval pauseTime = [self.circleLayer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.circleLayer.timeOffset = pauseTime;
    self.circleLayer.speed = 0;

}

- (void)loadViews {
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = CGRectGetWidth(self.frame) / 2.0;
    
    self.circleLayer = [CAShapeLayer layer];
    self.circleLayer.fillColor = [[UIColor clearColor] CGColor];
    self.circleLayer.lineWidth = self.frame.size.width - self.circleFrame.size.width;
    self.circleLayer.strokeColor = [self.strokeColor CGColor];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self.circleFrame];
    self.circleLayer.path = path.CGPath;
    [self.layer addSublayer:self.circleLayer];
    self.circleLayer.strokeStart = 0.0;
    self.circleLayer.strokeEnd = 0.0;

}

- (void)loadLayout {
    
    self.circleLayer.frame = CGRectMake(0, 0, self.circleFrame.size.width, self.circleFrame.size.height);
    self.circleLayer.position = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
    
}

@end
