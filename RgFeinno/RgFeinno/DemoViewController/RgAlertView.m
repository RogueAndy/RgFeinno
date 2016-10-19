//
//  RgAlertView.m
//  RgFeinno
//
//  Created by rogue on 16/10/18.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import "RgAlertView.h"
#import "RgLinkLabel.h"

@interface RgAlertView()

@property (nonatomic) CGRect alertFrame;

@property (nonatomic, strong) UIColor *style;

@property (nonatomic, strong) UILabel *alertTitleLabel;

@property (nonatomic, strong) UILabel *tipLabel;

@property (nonatomic, strong) CAShapeLayer *splitline;

@property (nonatomic, strong) RgLinkLabel *contentLabel;

@property (nonatomic, strong) UIButton *leftButton;

@property (nonatomic, strong) UIButton *rightButton;

// 标签的属性

@property (nonatomic, strong) NSMutableArray *rg_linkAttributes;

@end

@implementation RgAlertView

+ (instancetype)initWithFrame:(CGRect)frame style:(UIColor *)color {

    RgAlertView *alert = [[RgAlertView alloc] initWithFrame:frame];
    alert.alertFrame = frame;
    alert.style = color;
    return alert;

}

#pragma mark - 给每个标签设置对应的字体属性

- (void)setTitle:(NSString *)title tip:(NSString *)tip content:(NSString *)content linkAttributes:(nullable NSArray *)attributes {
    
    [self.rg_linkAttributes removeAllObjects];
    [self.rg_linkAttributes addObjectsFromArray:attributes];
    [self.contentLabel setLinkAttributes:self.rg_linkAttributes];
    
    self.alertTitleLabel.text = title;
    self.tipLabel.text = tip;
    self.contentLabel.text = content;
    
    [self loadLayout];

}

- (void)setStyle:(UIColor *)style {

    _style = style;
    self.layer.borderColor = _style.CGColor;
    self.leftButton.backgroundColor = _style;
    self.rightButton.backgroundColor = _style;
    [self.leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.alertTitleLabel.textColor = _style;

}

- (instancetype)initWithFrame:(CGRect)frame {

    if(self = [super initWithFrame:frame]) {
    
        [self loadSubview];
        [self loadLayout];
    
    }
    
    return self;
    
}

- (void)loadSubview {
    
    self.rg_linkAttributes = [NSMutableArray new];
    
    self.alertTitleLabel = [[UILabel alloc] init];
    self.alertTitleLabel.font = [UIFont systemFontOfSize:16];
    self.alertTitleLabel.textColor = [UIColor colorWithRed:50/255.f green:50/255.f blue:50/255.f alpha:1];
    self.alertTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.alertTitleLabel];
    
    self.tipLabel = [[UILabel alloc] init];
    self.tipLabel.font = [UIFont systemFontOfSize:14];
    self.tipLabel.textColor = [UIColor colorWithRed:170/255.f green:170/255.f blue:170/255.f alpha:1];
    self.tipLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.tipLabel];
    
    self.splitline = [CAShapeLayer layer];
    [self.layer addSublayer:self.splitline];
    
    self.contentLabel = [[RgLinkLabel alloc] initWithFrame:CGRectMake(20, 40, 280, 80)];
    self.contentLabel.font = [UIFont systemFontOfSize:13];
    self.contentLabel.textColor = [UIColor colorWithRed:70/255.f green:70/255.f blue:70/255.f alpha:1];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.lineBreakMode = NSLineBreakByClipping;
    [self addSubview:self.contentLabel];
    self.contentLabel.userInteractionEnabled = YES;
    self.userInteractionEnabled = YES;
    
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [self.leftButton setTitle:@"立即升级" forState:UIControlStateNormal];
    [self addSubview:self.leftButton];
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.rightButton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton setTitle:@"暂不升级" forState:UIControlStateNormal];
    [self addSubview:self.rightButton];

    self.contentLabel.backgroundColor = [UIColor whiteColor];
    __weak RgAlertView *weakSelf = self;
    self.contentLabel.userHandleLinkTapHandler = ^(RgLinkLabel * label, NSString * string, NSRange range) {
    
        if(weakSelf.linkAction) {
        
            weakSelf.linkAction(string);
        
        }
    
    };
    
}

- (void)loadLayout {
    
    self.layer.borderWidth = 3.0;

    self.alertTitleLabel.frame = CGRectMake(0, 10, CGRectGetWidth(self.frame), 25);
    self.tipLabel.frame = CGRectMake(30, CGRectGetMaxY(self.alertTitleLabel.frame), CGRectGetWidth(self.frame) - 2 * 30, 20);
    self.contentLabel.frame = CGRectMake(self.tipLabel.frame.origin.x, CGRectGetHeight(self.tipLabel.frame) + self.tipLabel.frame.origin.y + 5, CGRectGetWidth(self.tipLabel.frame), [self stringHeight:self.contentLabel.text]);
    
    self.leftButton.frame = CGRectMake(self.contentLabel.frame.origin.x, CGRectGetHeight(self.contentLabel.frame) + self.contentLabel.frame.origin.y + 5, 70, 28);
    self.rightButton.frame = CGRectMake(CGRectGetWidth(self.frame) - CGRectGetWidth(self.leftButton.frame) - self.leftButton.frame.origin.x, self.leftButton.frame.origin.y, CGRectGetWidth(self.leftButton.frame), CGRectGetHeight(self.leftButton.frame));
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(self.tipLabel.frame.origin.x, CGRectGetHeight(self.tipLabel.frame) + self.tipLabel.frame.origin.y)];
    [path addLineToPoint:CGPointMake(self.tipLabel.frame.origin.x + CGRectGetWidth(self.tipLabel.frame), CGRectGetHeight(self.tipLabel.frame) + self.tipLabel.frame.origin.y)];
    [path stroke];
    self.splitline.path = path.CGPath;
    self.splitline.strokeColor = [UIColor colorWithRed:220/255.f green:220/255.f blue:220/255.f alpha:1].CGColor;
    
}

- (CGFloat)stringHeight:(NSString *)parameter {

    return [parameter boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.contentLabel.frame), CGFLOAT_MAX)
                                   options:NSStringDrawingUsesLineFragmentOrigin
                                attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:70/255.f green:70/255.f blue:70/255.f alpha:1], NSFontAttributeName: [UIFont systemFontOfSize:14]}
                                   context:nil].size.height;
    
    return 0;

}

- (void)leftAction {

    if(_leftButtonAction) {
    
        _leftButtonAction();
    
    }
    
}

- (void)rightAction {

    if(_rightButtonAction) {
    
        _rightButtonAction();
    
    }

}

@end




/********************************************************************************************************************************/

@interface RgAlertSingleView()

@property (nonatomic) CGRect alertFrame;

@property (nonatomic, strong) UIColor *style;

@property (nonatomic, strong) UILabel *alertTitleLabel;

@property (nonatomic, strong) UILabel *tipLabel;

@property (nonatomic, strong) CAShapeLayer *splitline;

@property (nonatomic, strong) RgLinkLabel *contentLabel;

@property (nonatomic, strong) UIButton *singleButton;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSInteger timerCount;

// 标签的属性

@property (nonatomic, strong) NSMutableArray *rg_linkAttributes;

@end

@implementation RgAlertSingleView

+ (instancetype)initWithFrame:(CGRect)frame style:(UIColor *)color {
    
    RgAlertSingleView *alert = [[RgAlertSingleView alloc] initWithFrame:frame];
    alert.alertFrame = frame;
    alert.style = color;
    return alert;
    
}

#pragma mark - 给每个标签设置对应的字体属性

- (void)setTitle:(NSString *)title tip:(NSString *)tip content:(NSString *)content linkAttributes:(nullable NSArray *)attributes {
    
    [self.rg_linkAttributes removeAllObjects];
    [self.rg_linkAttributes addObjectsFromArray:attributes];
    [self.contentLabel setLinkAttributes:self.rg_linkAttributes];
    
    self.alertTitleLabel.text = title;
    self.tipLabel.text = tip;
    self.contentLabel.text = content;
    
    self.timerCount = 10;
    [self.singleButton setTitle:[NSString stringWithFormat:@"确定(%ld)", (long)self.timerCount] forState:UIControlStateNormal];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                  target:self
                                                selector:@selector(runTime:)
                                                userInfo:nil
                                                 repeats:YES];
    
    [self loadLayout];
    
}

- (void)setStyle:(UIColor *)style {
    
    _style = style;
    self.layer.borderColor = _style.CGColor;
    self.singleButton.backgroundColor = _style;
    [self.singleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.alertTitleLabel.textColor = _style;
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if(self = [super initWithFrame:frame]) {
        
        [self loadSubview];
        [self loadLayout];
        
    }
    
    return self;
    
}

- (void)loadSubview {
    
    self.rg_linkAttributes = [NSMutableArray new];
    
    self.alertTitleLabel = [[UILabel alloc] init];
    self.alertTitleLabel.font = [UIFont systemFontOfSize:16];
    self.alertTitleLabel.textColor = [UIColor colorWithRed:50/255.f green:50/255.f blue:50/255.f alpha:1];
    self.alertTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.alertTitleLabel];
    
    self.tipLabel = [[UILabel alloc] init];
    self.tipLabel.font = [UIFont systemFontOfSize:14];
    self.tipLabel.textColor = [UIColor colorWithRed:170/255.f green:170/255.f blue:170/255.f alpha:1];
    self.tipLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.tipLabel];
    
    self.splitline = [CAShapeLayer layer];
    [self.layer addSublayer:self.splitline];
    
    self.contentLabel = [[RgLinkLabel alloc] initWithFrame:CGRectMake(20, 40, 280, 80)];
    self.contentLabel.font = [UIFont systemFontOfSize:13];
    self.contentLabel.textColor = [UIColor colorWithRed:70/255.f green:70/255.f blue:70/255.f alpha:1];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.lineBreakMode = NSLineBreakByClipping;
    [self addSubview:self.contentLabel];
    self.contentLabel.userInteractionEnabled = YES;
    self.userInteractionEnabled = YES;
    
    self.singleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.singleButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.singleButton addTarget:self action:@selector(singleAction) forControlEvents:UIControlEventTouchUpInside];
    [self.singleButton setTitle:@"确定" forState:UIControlStateNormal];
    [self addSubview:self.singleButton];
    
    self.contentLabel.backgroundColor = [UIColor whiteColor];
    __weak RgAlertSingleView *weakSelf = self;
    self.contentLabel.userHandleLinkTapHandler = ^(RgLinkLabel * label, NSString * string, NSRange range) {
        
        if(weakSelf.linkAction) {
            
            weakSelf.linkAction(string);
            
        }
        
    };
    
}

- (void)loadLayout {
    
    self.layer.borderWidth = 3.0;
    
    self.alertTitleLabel.frame = CGRectMake(0, 10, CGRectGetWidth(self.frame), 25);
    self.tipLabel.frame = CGRectMake(30, CGRectGetMaxY(self.alertTitleLabel.frame), CGRectGetWidth(self.frame) - 2 * 30, 20);
    self.contentLabel.frame = CGRectMake(self.tipLabel.frame.origin.x, CGRectGetHeight(self.tipLabel.frame) + self.tipLabel.frame.origin.y + 5, CGRectGetWidth(self.tipLabel.frame), [self stringHeight:self.contentLabel.text]);
    
    self.singleButton.frame = CGRectMake((CGRectGetWidth(self.frame) - 90) / 2.0, CGRectGetHeight(self.contentLabel.frame) + self.contentLabel.frame.origin.y + 5, 90, 28);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(self.tipLabel.frame.origin.x, CGRectGetHeight(self.tipLabel.frame) + self.tipLabel.frame.origin.y)];
    [path addLineToPoint:CGPointMake(self.tipLabel.frame.origin.x + CGRectGetWidth(self.tipLabel.frame), CGRectGetHeight(self.tipLabel.frame) + self.tipLabel.frame.origin.y)];
    [path stroke];
    self.splitline.path = path.CGPath;
    self.splitline.strokeColor = [UIColor colorWithRed:220/255.f green:220/255.f blue:220/255.f alpha:1].CGColor;
    
}

- (CGFloat)stringHeight:(NSString *)parameter {
    
    return [parameter boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.contentLabel.frame), CGFLOAT_MAX)
                                   options:NSStringDrawingUsesLineFragmentOrigin
                                attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:70/255.f green:70/255.f blue:70/255.f alpha:1], NSFontAttributeName: [UIFont systemFontOfSize:14]}
                                   context:nil].size.height;
    
    return 0;
    
}

- (void)singleAction {
    
    if(_singleButtonAction) {
        
        _singleButtonAction();
        
    }
    
}

- (void)runTime:(NSTimer *)timer {

    if(self.timerCount == 0) {
    
        [self.timer invalidate];
        return;
    
    }
    
    [self.singleButton setTitle:[NSString stringWithFormat:@"确定(%ld)", (long)self.timerCount] forState:UIControlStateNormal];
    
    self.timerCount--;

}

@end






