//
//  RgMapViewController.m
//  RgFeinno
//
//  Created by Rogue Andy on 16/9/5.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import "RgMapViewController.h"
#import "RgMapView.h"
 
@interface RgMapViewController ()

@end

@implementation RgMapViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *bu = [UIButton buttonWithType:UIButtonTypeCustom];
    bu.backgroundColor = [UIColor orangeColor];
    [bu addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
    bu.frame = CGRectMake(20, 200, 280, 40);
    [self.view addSubview:bu];
    
}

- (void)show {
    
    RgMapKitViewController *vc = [[RgMapKitViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end





@interface RgMapKitViewController()

@property (nonatomic, strong) RgMapView *mapView;

@end

@implementation RgMapKitViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    [self loadSubview];
    [self loadLayout];
}

- (void)loadSubview {

    self.mapView = [[RgMapView alloc] init];
    [self.view addSubview:self.mapView];

}

- (void)loadLayout {

    self.mapView.frame = self.view.bounds;

}

- (void)dealloc {

    NSLog(@"--------------- dealloc");
    
}

@end