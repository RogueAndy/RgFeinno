//
//  ZProgressButton.m
//  ZProgress
//
//  Created by rogue on 2017/6/12.
//  Copyright © 2017年 dazhongge. All rights reserved.
//

#import "ZProgressButton.h"

@interface ZProgressButton()<CAAnimationDelegate>

@property (nonatomic, strong) UILabel *countdownLabel;

@property (nonatomic, strong) CAShapeLayer *circleLayer;

@property (nonatomic, strong) UIColor *strokeColor;

@property (nonatomic, assign) CGRect circleFrame;

@property (nonatomic, assign) CGFloat animationDuration;

@property (nonatomic, assign) CGFloat countTimeNumber;

@property (nonatomic, assign, readwrite) ZPStatus zpstatus;

@property (nonatomic, assign) BOOL countdown;

@property (nonatomic, strong) NSTimer *countdownTimer;

@property (nonatomic, strong) NSDictionary *countdownAttribution;

@end

@implementation ZProgressButton

+ (instancetype)initWithFrame:(CGRect)frame circleFrame:(CGRect)circleFrame strokeColor:(UIColor *)strokeColor backgroundColor:(UIColor *)backgroundColor duration:(CGFloat)duration countdown:(BOOL)isShow countdownAttribution:(NSDictionary *)attribution {

    ZProgressButton *button = [ZProgressButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = backgroundColor;
    button.frame = frame;
    button.countdownAttribution = attribution;
    button.countdown = isShow;
    button.zpstatus = ZPNoBeginAnimation;
    button.strokeColor = strokeColor;
    button.circleFrame = circleFrame;
    button.animationDuration = duration;
    [button loadViews];
    [button loadLayout];
    return button;

}

#pragma mark - 外部可调用方法

- (void)beginAnimation {

    self.countTimeNumber = self.animationDuration - 1;
    self.countdownLabel.text = [NSString stringWithFormat:@"%lds", (NSInteger)self.animationDuration];
    self.countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownAction:) userInfo:nil repeats:YES];
    self.circleLayer.strokeStart = 0.0;
    self.circleLayer.strokeEnd = 0.0;
    self.circleLayer.speed = 1;
    self.zpstatus = ZPBeginAnimation;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.delegate = self;
    animation.removedOnCompletion = NO;
    animation.duration = self.animationDuration;
    animation.fromValue = @(0);
    animation.toValue = @(1);
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.circleLayer addAnimation:animation forKey:@""];

}

- (void)endAnimation {

    [self.countdownTimer invalidate];
    self.countdownTimer = nil;
    self.zpstatus = ZPEndAnimation;
    CFTimeInterval pauseTime = [self.circleLayer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.circleLayer.timeOffset = pauseTime;
    self.circleLayer.speed = 0;

}

- (void)reset {

    self.countdownLabel.text = @"";
    self.zpstatus = ZPNoBeginAnimation;
    [self.circleLayer removeAllAnimations];

}

#pragma mark - 组装控件

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
    
    if(self.countdown) {
    
        self.countdownLabel = [[UILabel alloc] init];
        self.countdownLabel.layer.masksToBounds = YES;
        self.countdownLabel.textAlignment = NSTextAlignmentCenter;
        self.countdownLabel.backgroundColor = [UIColor whiteColor];
        self.countdownLabel.textColor = [self.countdownAttribution objectForKey:NSForegroundColorAttributeName];
        self.countdownLabel.font = [self.countdownAttribution objectForKey:NSFontAttributeName];
        [self addSubview:self.countdownLabel];
    
    }

}

- (void)loadLayout {
    
    self.circleLayer.frame = CGRectMake(0, 0, self.circleFrame.size.width, self.circleFrame.size.height);
    self.circleLayer.position = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
    
    if(self.countdown) {
        self.countdownLabel.frame = CGRectMake(0, 0, self.circleFrame.size.width - self.circleLayer.lineWidth / 2.0, self.circleFrame.size.height - self.circleLayer.lineWidth / 2.0);
        self.countdownLabel.center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
        self.countdownLabel.layer.cornerRadius = CGRectGetWidth(self.countdownLabel.frame) / 2.0;
        
    }
    
}

#pragma mark - 计时器

- (void)countDownAction:(NSTimer *)timer {

    if(_countTimeNumber == 0) {
    
        [self.countdownTimer invalidate];
        self.countdownTimer = nil;
        self.countdownLabel.text = [NSString stringWithFormat:@"%lds", (NSInteger)self.countTimeNumber];
        return;
    
    }
    
    self.countdownLabel.text = [NSString stringWithFormat:@"%lds", (NSInteger)self.countTimeNumber];
    self.countTimeNumber--;

}

#pragma mark 实现动画结束调用函数

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag

{
    
    NSLog(@"======= 动画暂停完毕");
    if(self.zpstatus == ZPBeginAnimation) { // 如果动画是通过自动执行完毕，才会调用该方法，否则，不会调用该方法
    
        if([_delegate performSelector:@selector(progressAnimationOver)]) {
        
            [_delegate progressAnimationOver];
        
        }
    
    }
    
}

- (void)dealloc {

    NSLog(@"~~~~~ %@ is dealloc ", [self class]);

}

@end
