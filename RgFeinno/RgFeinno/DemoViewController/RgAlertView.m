//
//  RgAlertView.m
//  RgFeinno
//
//  Created by rogue on 16/10/18.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import "RgAlertView.h"


@interface RgAlertView()

@property (nonatomic) CGRect alertFrame;

@property (nonatomic, strong) UIColor *style;

@property (nonatomic, strong) UILabel *alertTitleLabel;

@property (nonatomic, strong) UILabel *tipLabel;

@property (nonatomic, strong) CAShapeLayer *splitline;

//@property (nonatomic, strong) CJLabel *contentLabel;

@end

@implementation RgAlertView

+ (instancetype)initWithFrame:(CGRect)frame style:(UIColor *)color {

    RgAlertView *alert = [[RgAlertView alloc] initWithFrame:frame];
    alert.alertFrame = frame;
    alert.style = color;
    return alert;

}

- (void)setTitle:(NSString *)title tip:(NSString *)tip content:(NSString *)content tapString:(NSString *)tapstring {

//    self.alertTitleLabel.text = title;
//    self.tipLabel.text = tip;
//    self.contentLabel.text = content;
//    [self.contentLabel addLinkString:tapstring
//                    linkAddAttribute:@{NSForegroundColorAttributeName: [UIColor orangeColor], NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]}
//                               block:^(CJLinkLabelModel *linkModel) {
//                                   NSLog(@"点击了");
//                               }];
    
    [self loadLayout];

}

- (void)setStyle:(UIColor *)style {

    _style = style;
    self.layer.borderColor = _style.CGColor;

}

- (instancetype)initWithFrame:(CGRect)frame {

    if(self = [super initWithFrame:frame]) {
    
        [self loadSubview];
        [self loadLayout];
    
    }
    
    return self;
    
}

- (void)loadSubview {
    
//    self.alertTitleLabel = [[UILabel alloc] init];
//    self.alertTitleLabel.font = [UIFont systemFontOfSize:17];
//    self.alertTitleLabel.textColor = [UIColor colorWithRed:50/255.f green:50/255.f blue:50/255.f alpha:1];
//    self.alertTitleLabel.textAlignment = NSTextAlignmentCenter;
//    [self addSubview:self.alertTitleLabel];
//    
//    self.tipLabel = [[UILabel alloc] init];
//    self.tipLabel.font = [UIFont systemFontOfSize:14];
//    self.tipLabel.textColor = [UIColor colorWithRed:170/255.f green:170/255.f blue:170/255.f alpha:1];
//    self.tipLabel.textAlignment = NSTextAlignmentLeft;
//    [self addSubview:self.tipLabel];
//    
//    self.splitline = [CAShapeLayer layer];
//    [self.layer addSublayer:self.splitline];
    
//    self.contentLabel = [[CJLabel alloc] initWithFrame:CGRectMake(20, 40, 280, 80)];
//    self.contentLabel.font = [UIFont systemFontOfSize:14];
//    self.contentLabel.textColor = [UIColor colorWithRed:70/255.f green:70/255.f blue:70/255.f alpha:1];
//    self.contentLabel.numberOfLines = 0;
//    self.contentLabel.lineBreakMode = NSLineBreakByClipping;
//    [self addSubview:self.contentLabel];
//    self.contentLabel.userInteractionEnabled = YES;
//    self.userInteractionEnabled = YES;
//    self.contentLabel.text = @"最近学着玩python和django框架，学到连接数据库，居然给我报导入数据库失败，花了3个小时的功夫度娘+自行解决终于成功了，特此记录，帮助和我一样的python新人少走一些弯路";
//    
//    self.contentLabel.backgroundColor = [UIColor greenColor];
//    [self.contentLabel addLinkString:@"连接数据库"
//                    linkAddAttribute:@{NSForegroundColorAttributeName: [UIColor orangeColor], NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]}
//                               block:^(CJLinkLabelModel *linkModel) {
//                                   NSLog(@"点击了");
//                               }];
//    
}

- (void)loadLayout {
    
    self.layer.borderWidth = 3.0;

//    self.alertTitleLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 30);
//    self.tipLabel.frame = CGRectMake(30, CGRectGetMaxY(self.alertTitleLabel.frame), CGRectGetWidth(self.frame) - 2 * 30, 25);
//    self.contentLabel.frame = CGRectMake(self.tipLabel.frame.origin.x, CGRectGetHeight(self.tipLabel.frame) + self.tipLabel.frame.origin.y + 5, CGRectGetWidth(self.tipLabel.frame), [self stringHeight:self.contentLabel.text]);
//    
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(self.tipLabel.frame.origin.x, CGRectGetHeight(self.tipLabel.frame) + self.tipLabel.frame.origin.y)];
//    [path addLineToPoint:CGPointMake(self.tipLabel.frame.origin.x + CGRectGetWidth(self.tipLabel.frame), CGRectGetHeight(self.tipLabel.frame) + self.tipLabel.frame.origin.y)];
//    [path stroke];
//    self.splitline.path = path.CGPath;
//    self.splitline.strokeColor = [UIColor colorWithRed:220/255.f green:220/255.f blue:220/255.f alpha:1].CGColor;

//    self.contentLabel.frame = CGRectMake(20, 30, CGRectGetWidth(self.frame), 100);
    
}

- (CGFloat)stringHeight:(NSString *)parameter {

//    return [parameter boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.contentLabel.frame), CGFLOAT_MAX)
//                                   options:NSStringDrawingUsesLineFragmentOrigin
//                                attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:70/255.f green:70/255.f blue:70/255.f alpha:1], NSFontAttributeName: [UIFont systemFontOfSize:14]}
//                                   context:nil].size.height;
    
    return 0;

}

@end
