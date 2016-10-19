//
//  RgAlertViewController.m
//  RgFeinno
//
//  Created by rogue on 16/10/18.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import "RgAlertViewController.h"
#import "RgAlertView.h"
#import "RgLinkLabel.h"

@interface RgAlertViewController ()

@property (nonatomic, strong) RgAlertView *alertView;

@property (nonatomic, strong) RgLinkLabel *rglinklabel;

@end

@implementation RgAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
//    self.linklabel = [[CJLabel alloc] initWithFrame:CGRectMake(20, 120, 280, 100)];
//    self.linklabel.font = [UIFont systemFontOfSize:15];
//    self.linklabel.numberOfLines = 0;
//    self.linklabel.lineBreakMode = NSLineBreakByCharWrapping;
//    self.linklabel.textColor = [UIColor colorWithRed:120/255.f green:120/255.f blue:120/255.f alpha:1];
//    self.linklabel.text = @"最近学着玩python和django框架，学到连接数据库，居然给我报导入数据库失败，花了3个小时的功夫度娘+自行解决终于成功了，特此记录，帮助和我一样的python新人少走一些弯路";
//    [self.view addSubview:self.linklabel];
//    
//    [self.linklabel addLinkString:@"数据库" linkAddAttribute:@{NSForegroundColorAttributeName: [UIColor orangeColor], NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]} block:^(CJLinkLabelModel *linkModel) {
//        
//        NSLog(@"跳转界面");
//        
//    }];
    
    self.rglinklabel = [[RgLinkLabel alloc] initWithFrame:CGRectMake(20, 120, 280, 100)];
    self.rglinklabel.font = [UIFont systemFontOfSize:18];
    self.rglinklabel.userInteractionEnabled = YES;
    self.rglinklabel.numberOfLines = 0;
    self.rglinklabel.lineBreakMode = NSLineBreakByCharWrapping;
    self.rglinklabel.textColor = [UIColor colorWithRed:120/255.f green:120/255.f blue:120/255.f alpha:1];
    self.rglinklabel.text = @"最近学着玩python和django框架，学到<a>连接数据库</a>，居然给我报导入<a>数据库</a>失败，花了3个小时的功夫度娘+自行解决终于成功了，特此记录，帮助和我一样的<a>python</a>新人少走一些弯路";
    [self.view addSubview:self.rglinklabel];
    
    self.rglinklabel.userHandleLinkTapHandler = ^(RgLinkLabel * _Nullable label, NSString * _Nullable string, NSRange range) {
    
        NSLog(@"~~~~~~~~ %@", string);
    
    };
    
//    self.alertView = [RgAlertView initWithFrame:CGRectMake(0, 0, 280, 180) style:[UIColor orangeColor]];
////    self.alertView.userInteractionEnabled = YES;
//    self.alertView.center = self.view.center;
//    [self.view addSubview:self.alertView];
//
//    [self.alertView setTitle:@"测试" tip:@"提示" content:@"最近学着玩python和django框架，学到连接数据库，居然给我报导入数据库失败，花了3个小时的功夫度娘+自行解决终于成功了，特此记录，帮助和我一样的python新人少走一些弯路" tapString:@"连接数据库"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
