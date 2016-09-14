//
//  RgUploadImageViewController.m
//  RgFeinno
//
//  Created by Rogue Andy on 16/9/14.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import "RgUploadImageViewController.h"
#import "YRJSONAdapter.h"
#import "RgHttpDealParameters.h"
#import "Security3DES.h"

@interface RgUploadImageViewController ()

@end

@implementation RgUploadImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *bu = [UIButton buttonWithType:UIButtonTypeCustom];
    bu.backgroundColor = [UIColor orangeColor];
    [bu addTarget:self action:@selector(upload) forControlEvents:UIControlEventTouchUpInside];
    bu.frame = CGRectMake(20, 100, 100, 40);
    [self.view addSubview:bu];
    
}

- (void)upload {

    NSDictionary *appInfoDict = [NSDictionary dictionaryWithObjectsAndKeys:@"cmweather", @"appCode",
                                 @"iOS", @"platform",
                                 @"58", @"verCode",
                                 @"3.7.4", @"verName",
                                 @"5058804A-432C-40BD-8FFB-2A14ABEB1350", @"userKey",
                                 @"aas", @"chnlCode",
                                 nil];
    NSDictionary *authInfoDict = @{};
    NSDictionary *servReqInfoDict = [NSDictionary dictionaryWithObjectsAndKeys:@"v1.0", @"intVer",
                                     @"/user/uploadShareImage", @"method",@"0",@"testFlag",
                                     nil];
    // mobileReqHeader
    NSDictionary *mobileReqHeaderDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                         appInfoDict, @"appInfo",
                                         authInfoDict, @"authInfo",
                                         @{}, @"extInfo",
                                         nil];
    
    NSDictionary *mobileReqBodyDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                       servReqInfoDict, @"servReqInfo",
                                       nil];
    // sendData
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          mobileReqHeaderDict, @"mobileReqHeader",
                          mobileReqBodyDict, @"mobileReqBody",
                          nil];
    
    UIImage *image = [UIImage imageNamed:@"banner"];
    NSData *data = UIImagePNGRepresentation(image);
    
    NSString *str = [dict JSONRepresentation];
    
    NSData *dataDes = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSString *strJson=[[NSString alloc] initWithData:dataDes encoding:NSUTF8StringEncoding];
    strJson = [Security3DES encryptFeinno:strJson];
    NSDictionary *form = [NSDictionary dictionaryWithObjectsAndKeys:[strJson dataUsingEncoding:NSUTF8StringEncoding], @"json", data,@"shareImage",nil];
    
    [RgHttpDealParameters POSTImageURLFeinno:@"http://218.206.4.40:8660/service"
                                  parameters:nil
                                       datas:data
                               formParameter:form
                              completeHandle:^(NSURLSessionDataTask *task, id responceObject, NSError *error, NSString *message, NSInteger messageType) {
                                  NSLog(@"%@", responceObject);
                              }];

}

@end
