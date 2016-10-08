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
