//
//  RgWave.m
//  RgFeinno
//
//  Created by Rogue Andy on 16/9/13.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import "RgWave.h"

@interface RgWave()

@property (nonatomic, strong) CAShapeLayer *waveLayer;

@end

@implementation RgWave

- (CAShapeLayer *)waveLayer {

    if(!_waveLayer) {
    
        _waveLayer = [CAShapeLayer layer];
        _waveLayer.fillColor = [UIColor whiteColor].CGColor;
        [self.layer addSublayer:_waveLayer];
    
    }
    
    return _waveLayer;

}

- (instancetype)initWithFrame:(CGRect)frame {

    if(self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        [self loadSubview];
        [self loadLayout];
        
    }
    
    return self;

}

- (instancetype)init {

    if(self = [super init]) {
    
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        [self loadSubview];
        [self loadLayout];
    
    }
    
    return self;

}

- (void)loadSubview {
    
    self.waveLayer.backgroundColor = [UIColor whiteColor].CGColor;

}

- (void)loadLayout {


}

- (void)progressFloat:(CGFloat)progress {

    CGFloat lineHeight = CGRectGetHeight(self.frame) * progress;
    CGFloat maxHeight = CGRectGetHeight(self.frame);
    CGFloat averWidth = CGRectGetWidth(self.frame) / 5.0;
    CGFloat lineWidth = averWidth * (3.0 / 5.0);
    CGFloat averSpace = (averWidth - lineWidth) / 2.0;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, maxHeight)];
    
    for(NSInteger i = 0; i < 5; i++) {
    
        [path addLineToPoint:CGPointMake(averSpace + (lineWidth + averSpace * 2) * i, maxHeight)];
        [path addLineToPoint:CGPointMake(averSpace + (lineWidth + averSpace * 2) * i, maxHeight - lineHeight)];
        [path addLineToPoint:CGPointMake(averSpace + lineWidth + (lineWidth + averSpace * 2) * i, maxHeight - lineHeight)];
        [path addLineToPoint:CGPointMake(averSpace + lineWidth + (lineWidth + averSpace * 2) * i, maxHeight)];
        
        if(i < 5 - 1) {
        
            [path addLineToPoint:CGPointMake(averSpace + lineWidth + (lineWidth + averSpace * 2) * (i + 1), maxHeight)];
            continue;
        
        }
        
        [path addLineToPoint:CGPointMake(averSpace + lineWidth + (lineWidth + averSpace * 2) * (i + 1) - averSpace, maxHeight)];
        
    
    }
    
    self.waveLayer.path = path.CGPath;
    [self.waveLayer fillColor];

}

@end
