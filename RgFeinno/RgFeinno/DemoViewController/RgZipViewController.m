//
//  RgZipViewController.m
//  RgFeinno
//
//  Created by Rogue Andy on 16/9/2.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import "RgZipViewController.h"
#import "SSZipArchive.h"

@interface RgZipViewController ()

@end

@implementation RgZipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *bu = [UIButton buttonWithType:UIButtonTypeCustom];
    bu.backgroundColor = [UIColor orangeColor];
    [bu addTarget:self action:@selector(ys) forControlEvents:UIControlEventTouchUpInside];
    bu.frame = CGRectMake(20, 100, 100, 40);
    [self.view addSubview:bu];
    
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.backgroundColor = [UIColor redColor];
    [bt addTarget:self action:@selector(jy) forControlEvents:UIControlEventTouchUpInside];
    bt.frame = CGRectMake(160, 100, 100, 40);
    [self.view addSubview:bt];
    
}

- (void)jy {

    [SSZipArchive unzipFileAtPath:@"/Users/rogueandy/Desktop/test2.zip" toDestination:@"/Users/rogueandy/Desktop/test3"];
    
}

- (void)ys {

    [SSZipArchive createZipFileAtPath:@"/Users/rogueandy/Desktop/test2.zip" withFilesAtPaths:@[@"/Users/rogueandy/Desktop/test.png"]];

}

@end
