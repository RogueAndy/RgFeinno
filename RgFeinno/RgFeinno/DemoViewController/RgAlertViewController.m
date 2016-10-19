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
    
    self.alertView = [RgAlertView initWithFrame:CGRectMake(0, 0, 280, 180) style:[UIColor orangeColor]];
    self.alertView.center = self.view.center;
    [self.view addSubview:self.alertView];

    [self.alertView setTitle:@"测试" tip:@"提示" content:@"最近学着玩<a>python</a>和<a>django</a>框架，学到连接数据库，居然给我报导入数据库失败，花了3个小时的功夫度娘+自行解决终于成功了，特此记录，帮助和我一样的<a>python</a>新人少走一些弯路"];
    
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
    
    
}

- (void)s1 {

    [self.alertView setTitle:@"测试" tip:@"提示" content:@"因为<a>Nullability</a> Annotations是<a>Xcode</a> 6.3新加入的，所以我们需要考虑之前的老代码。实际上，<a>苹果</a>已以帮我们处理好了这种兼容问题，我们可以安全地使用它们："];
    
}

- (void)s2 {

    [self.alertView setTitle:@"测试" tip:@"提示" content:@"我们都知道在<a>swift</a>中，可以使用!和?来表示一个对象是optional的还是non-optional，如<a>view</a>?和view!。而在<a>Objective-C</a>中则没有这一区分"];

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
