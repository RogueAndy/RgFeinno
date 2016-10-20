//
//  RgAlertViewControl.m
//  RgFeinno
//
//  Created by rogue on 16/10/20.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import "RgAlertViewControl.h"
#import "RgAlertView.h"

@interface RgAlertViewControl()

@property (nonatomic, strong) RgAlertView *alertView;

@property (nonatomic, strong) UIColor *style;

@end

@implementation RgAlertViewControl

+ (instancetype)initWithFrame:(CGRect)frame style:(UIColor *)color {

    RgAlertViewControl *alert = [[RgAlertViewControl alloc] initWithFrame:frame];
    alert.style = color;
    return alert;

}

- (void)setTitle:(NSString *)title tip:(NSString *)tip content:(NSString *)content linkAttributes:(NSArray *)attributes {

    [self.alertView setTitle:title tip:tip content:content linkAttributes:attributes];

}

- (instancetype)initWithFrame:(CGRect)frame {

    if(self = [super initWithFrame:frame]) {
    
        [self loadSubview];
        [self loadLayout];
    
    }
    
    return self;

}

- (void)loadSubview {

    self.alertView = [[RgAlertView alloc] initWithFrame:CGRectMake(0, 0, 280, 200)];
    self.alertView.center = self.center;
    [self addSubview:self.alertView];

}

- (void)loadLayout {

    self.backgroundColor = [UIColor clearColor];

}

- (void)setLeftButtonAction:(void (^)(void))leftButtonAction {

    _leftButtonAction = leftButtonAction;
    self.alertView.leftButtonAction = _leftButtonAction;

}

- (void)setRightButtonAction:(void (^)(void))rightButtonAction {

    _rightButtonAction = rightButtonAction;
    self.alertView.rightButtonAction = _rightButtonAction;

}

- (void)setLinkAction:(void (^)(NSString *))linkAction {

    _linkAction = linkAction;
    self.alertView.linkAction = linkAction;

}

- (void)setStyle:(UIColor *)style {

    _style = style;
    self.alertView.style = _style;

}

@end











@interface RgAlertSingleViewControl()

@property (nonatomic, strong) RgAlertSingleView *alertView;

@property (nonatomic, strong) UIColor *style;

@end

@implementation RgAlertSingleViewControl

+ (instancetype)initWithFrame:(CGRect)frame style:(UIColor *)color {

    RgAlertSingleViewControl *alert = [[RgAlertSingleViewControl alloc] initWithFrame:frame];
    alert.style = color;
    return alert;
    
}

- (void)setTitle:(NSString *)title tip:(NSString *)tip content:(NSString *)content linkAttributes:(NSArray *)attributes {

    [self.alertView setTitle:title tip:tip content:content linkAttributes:attributes];

}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if(self = [super initWithFrame:frame]) {
        
        [self loadSubview];
        [self loadLayout];
        
    }
    
    return self;
    
}

- (void)loadSubview {
    
    self.alertView = [[RgAlertSingleView alloc] initWithFrame:CGRectMake(0, 0, 280, 200)];
    self.alertView.center = self.center;
    [self addSubview:self.alertView];
    
}

- (void)loadLayout {
    
    self.backgroundColor = [UIColor clearColor];
    
}

- (void)setSingleButtonAction:(void (^)(void))singleButtonAction {

    _singleButtonAction = singleButtonAction;
    self.alertView.singleButtonAction = _singleButtonAction;

}

- (void)setLinkAction:(void (^)(NSString *))linkAction {
    
    _linkAction = linkAction;
    self.alertView.linkAction = linkAction;
    
}

- (void)setStyle:(UIColor *)style {
    
    _style = style;
    self.alertView.style = _style;
    
}

@end
