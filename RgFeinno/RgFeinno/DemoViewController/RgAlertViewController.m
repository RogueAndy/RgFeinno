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
#import "RgAlertViewControl.h"

@interface RgAlertViewController ()

@property (nonatomic, strong) RgAlertView *alertView;

@property (nonatomic, strong) RgAlertSingleView *singleView;

@property (nonatomic, strong) RgAlertViewControl *alertViewControl;

@property (nonatomic, strong) RgAlertSingleViewControl *alertSingleViewControl;

@end

@implementation RgAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.singleView = [RgAlertSingleView initWithFrame:CGRectMake(0, 0, 280, 200) style:[UIColor orangeColor]];
//    self.singleView.center = self.view.center;
//    self.singleView.singleButtonAction = ^{
//        
//        NSLog(@"----马上确定");
//        
//    };
//    self.singleView.linkAction = ^(NSString *linkString) {
//        
//        NSLog(@"----%@", linkString);
//        
//    };
//    [self.view addSubview:self.singleView];
    
    
    
    
//    NSArray *att = @[
//                     @{NSFontAttributeName: [UIFont systemFontOfSize:15],
//                       NSForegroundColorAttributeName: [UIColor orangeColor]
//                       },
//                     @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle], NSForegroundColorAttributeName: [UIColor orangeColor],
//                       NSFontAttributeName: [UIFont systemFontOfSize:15],
//                       NSForegroundColorAttributeName: [UIColor orangeColor]
//                       },
//                     @{NSFontAttributeName: [UIFont systemFontOfSize:15],
//                       NSForegroundColorAttributeName: [UIColor orangeColor]
//                       }
//                     ];
    
    [self.singleView setTitle:@"登陆成功"
                         tip:@"提示"
                     content:@"恭喜您，您的18306090027已经升级为12582通行证。该通行证可以在12582基地下所有系统登录，该账号在12582基地其它系统中的老密码将失效"
              linkAttributes:nil];
    
    
//    self.alertView = [RgAlertView initWithFrame:CGRectMake(0, 0, 280, 200) style:[UIColor orangeColor]];
//    self.alertView.center = self.view.center;
//    self.alertView.leftButtonAction = ^{
//    
//        NSLog(@"----马上升级");
//    
//    };
//    self.alertView.rightButtonAction = ^{
//    
//        NSLog(@"----算了不升级");
//    
//    };
//    self.alertView.linkAction = ^(NSString *linkString) {
//    
//        NSLog(@"----%@", linkString);
//    
//    };
//    [self.view addSubview:self.alertView];
//    
    NSArray *att = @[
                     @{NSFontAttributeName: [UIFont systemFontOfSize:15],
                       NSForegroundColorAttributeName: [UIColor orangeColor]
                       },
                     @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle], NSForegroundColorAttributeName: [UIColor orangeColor],
                       NSFontAttributeName: [UIFont systemFontOfSize:15],
                       NSForegroundColorAttributeName: [UIColor orangeColor]
                       },
                     @{NSFontAttributeName: [UIFont systemFontOfSize:15],
                       NSForegroundColorAttributeName: [UIColor orangeColor]
                       }
                     ];
//
//    [self.alertView setTitle:@"登陆成功"
//                         tip:@"提示"
//                     content:@"尊敬的用户，您当前的账号可以升级为12582通行证！12582通行证新增了更多功能<a>>></a><a>点击查看</a>\n点击立即升级后跳转到12582<a>密码重置</a>界面"
//              linkAttributes:att];
    
    UIButton *sender = [UIButton buttonWithType:UIButtonTypeCustom];
    sender.backgroundColor = [UIColor orangeColor];
    [sender addTarget:self action:@selector(s1) forControlEvents:UIControlEventTouchUpInside];
    sender.frame = CGRectMake(20, 80, 200, 40);
    [self.view addSubview:sender];
    
    UIButton *sender2 = [UIButton buttonWithType:UIButtonTypeCustom];
    sender2.backgroundColor = [UIColor orangeColor];
    [sender2 addTarget:self action:@selector(s2) forControlEvents:UIControlEventTouchUpInside];
    sender2.frame = CGRectMake(20, 130, 200, 40);
    [self.view addSubview:sender2];
    
//    self.alertViewControl = [RgAlertViewControl initWithFrame:self.view.frame style:[UIColor orangeColor]];
//    [self.view addSubview:self.alertViewControl];
//    
//    [self.alertViewControl setTitle:@"登陆成功"
//                         tip:@"提示"
//                     content:@"尊敬的用户，您当前的账号可以升级为12582通行证！12582通行证新增了更多功能<a>>></a><a>点击查看</a>\n点击立即升级后跳转到12582<a>密码重置</a>界面"
//              linkAttributes:att];
//    
//    self.alertViewControl.leftButtonAction = ^{
//        
//        NSLog(@"----马上升级");
//        
//    };
//    self.alertViewControl.rightButtonAction = ^{
//        
//        NSLog(@"----算了不升级");
//        
//    };
//    self.alertViewControl.linkAction = ^(NSString *linkString) {
//        
//        NSLog(@"----%@", linkString);
//        
//    };

    self.alertSingleViewControl = [RgAlertSingleViewControl initWithFrame:self.view.frame style:[UIColor orangeColor]];
    [self.view addSubview:self.alertSingleViewControl];

    [self.alertSingleViewControl setTitle:@"登陆成功"
                          tip:@"提示"
                      content:@"恭喜您，您的18306090027已经升级为12582通行证。该通行证可以在12582基地下所有系统登录，该账号在12582基地其它系统中的老密码将失效"
               linkAttributes:nil];
//    [self.alertSingleViewControl setTitle:@"登陆成功"
//                                tip:@"提示"
//                            content:@"尊敬的用户，您当前的账号可以升级为12582通行证！12582通行证新增了更多功能<a>>></a><a>点击查看</a>\n点击立即升级后跳转到12582<a>密码重置</a>界面"
//                     linkAttributes:att];
    
    self.alertSingleViewControl.linkAction = ^(NSString *linkString) {
        
        NSLog(@"----%@", linkString);
        
    };
    
    self.alertSingleViewControl.singleButtonAction = ^{
    
        NSLog(@"-----确定按钮");
    
    };
    
}

- (void)s1 {

    NSLog(@"~~~~~~~~~~~~");
//    [self.alertView setTitle:@"测试" tip:@"提示" content:@"因为<a>Nullability</a> Annotations是<a>Xcode</a> 6.3新加入的，所以我们需要考虑之前的老代码。实际上，<a>苹果</a>已以帮我们处理好了这种兼容问题，我们可以安全地使用它们："];
    
}

- (void)s2 {

//    [self.alertView setTitle:@"测试" tip:@"提示" content:@"我们都知道在<a>swift</a>中，可以使用!和?来表示一个对象是optional的还是non-optional，如<a>view</a>?和view!。而在<a>Objective-C</a>中则没有这一区分"];

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
