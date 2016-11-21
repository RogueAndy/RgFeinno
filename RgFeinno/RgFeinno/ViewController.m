//
//  ViewController.m
//  RgFeinno
//
//  Created by Rogue Andy on 16/8/29.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    UIButton *se = [UIButton buttonWithType:UIButtonTypeCustom];
    se.backgroundColor = [UIColor orangeColor];
    se.frame = CGRectMake(20, 200, 280, 40);
    [se addTarget:self action:@selector(chan) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:se];
    
}

- (void)chan {

    NSString *name = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleNameKey];
    NSLog(@"~~~~~~~~~~~~~~~~ %@", name);
    [[[NSBundle mainBundle] infoDictionary] setValue:@"再一次" forKey:(NSString *)kCFBundleNameKey];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
