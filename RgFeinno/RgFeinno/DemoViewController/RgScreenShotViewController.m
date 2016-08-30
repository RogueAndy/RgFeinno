//
//  RgScreenShotViewController.m
//  RgFeinno
//
//  Created by Rogue Andy on 16/8/30.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import "RgScreenShotViewController.h"
#import "RgScreenShot.h"

@interface RgScreenShotViewController()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) UIImageView *shotImage;

@end

@implementation RgScreenShotViewController

- (UIImageView *)shotImage {

    if(!_shotImage) {
    
        _shotImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 400)];
        _shotImage.center = self.view.center;
        _shotImage.userInteractionEnabled = YES;
        _shotImage.layer.borderColor = [UIColor orangeColor].CGColor;
        _shotImage.layer.borderWidth = 2;
        [self.view addSubview:_shotImage];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissImage)];
        [_shotImage addGestureRecognizer:tap];
    
    }
    
    return _shotImage;

}

- (void)viewDidLoad {

    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.userInteractionEnabled = YES;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"截屏" style:UIBarButtonItemStylePlain target:self action:@selector(left)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"显示" style:UIBarButtonItemStylePlain target:self action:@selector(right)];
    
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://baidu.com"]]];
    
    self.shotImage.hidden = YES;
    
}

- (void)left {

    self.shotImage.image = [RgScreenShot imageWithView:self.view];

}

- (void)right {

    self.shotImage.hidden = NO;

}

- (void)dismissImage {

    self.shotImage.hidden = YES;

}

@end

