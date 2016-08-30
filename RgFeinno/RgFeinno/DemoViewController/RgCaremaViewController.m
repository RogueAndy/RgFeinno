//
//  RgCaremaViewController.m
//  RgFeinno
//
//  Created by Rogue Andy on 16/8/30.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import "RgCaremaViewController.h"
#import "RgLocation.h"
#import "RgCamera.h"

@implementation RgCaremaViewController

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
    
    [RgCamera cameraPhotoType:RgCameraPhotoShoot barFontColor:[UIColor whiteColor] barColor:[UIColor orangeColor] pushInParentController:self didFinishPickingPhotoWithInfo:^(NSDictionary *cameraInfo, UIImagePickerController *caremaEntity) {
        
        [caremaEntity dismissViewControllerAnimated:YES completion:^{
            NSLog(@"------- %@", cameraInfo);
        }];
        
    }];
    
    //    [RgCamera cameraVideoType:RgCameraVideoShoot barFontColor:[UIColor whiteColor] barColor:[UIColor blueColor] pushInParentController:self didFinishPickingVideoWithInfo:^(NSString *videoURL, UIImagePickerController *caremaEntity) {
    //
    //        [caremaEntity dismissViewControllerAnimated:YES completion:^{
    //            NSLog(@"------- %@", videoURL);
    //        }];
    // 
    //    }];
    
}

@end
