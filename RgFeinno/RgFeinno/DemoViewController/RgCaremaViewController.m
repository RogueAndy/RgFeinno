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
#import "RgHttpServers.h"

@interface RgCaremaViewController()<UIActionSheetDelegate>

@end

@implementation RgCaremaViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *bu = [UIButton buttonWithType:UIButtonTypeCustom];
    bu.backgroundColor = [UIColor orangeColor];
    [bu setTitle:@"选择拍摄模式" forState:UIControlStateNormal];
    bu.titleLabel.textColor = [UIColor whiteColor];
    [bu addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
    bu.frame = CGRectMake(20, 200, CGRectGetWidth(self.view.frame) - 40, 40);
    [self.view addSubview:bu];
    
}

- (void)show {
    
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"选择相册或拍摄" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍摄", @"本地相册", nil];
    [action showInView:self.view];
    
    return;
    
//    [RgCamera cameraPhotoType:RgCameraPhotoLocalSource barFontColor:[UIColor whiteColor] barColor:[UIColor orangeColor] pushInParentController:self didFinishPickingPhotoWithInfo:^(NSDictionary *cameraInfo, UIImagePickerController *caremaEntity) {
//        
//        [caremaEntity dismissViewControllerAnimated:YES completion:^{
//            NSLog(@"------- %@", cameraInfo);
//        }];
//        
//    }];
    
        [RgCamera cameraVideoType:RgCameraVideoShoot
                     barFontColor:[UIColor whiteColor]
                         barColor:[UIColor orangeColor]
                        maxSecond:10
                          maxSize:200
           pushInParentController:self
    didFinishPickingVideoWithInfo:^(NSString *videoURL, UIImagePickerController *caremaEntity) {
        
        NSLog(@"%@", videoURL);
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:videoURL]];
       //http://218.201.73.186:8777/upload/?path=nxt&type= http://218.201.73.49:6892/upload/?path=xm&type=image
        [RgHttpServers POST:@"http://218.201.73.186:8777/upload/?path=nxt&type=video"
                    headers:nil
                   fileName:@"testvideo.mp4"
                   mineType:@"video"
                 parameters:nil
                      datas:data
             completeHandle:^(NSURLSessionDataTask *task, id responceObject, NSError *error, NSString *message, NSInteger messageType) {
                 
                 NSLog(@"----%@", responceObject);
                 
             }];
        
    }];
    
}

@end
