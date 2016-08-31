//
//  RgUMShare.m
//  RgFeinno
//
//  Created by Rogue Andy on 16/8/31.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import "RgUMShare.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"

static RgUMShare *share = nil;

@interface RgUMShare()<UMSocialUIDelegate>

@property (nonatomic, strong) NSString *wxAppid;

@property (nonatomic, strong) NSString *wxAppSecret;

@property (nonatomic, strong) NSString *wxUrl;

@property (nonatomic, strong) NSString *qqAppid;

@property (nonatomic, strong) NSString *qqAppKey;

@property (nonatomic, strong) NSString *qqUrl;

@property (nonatomic, strong) NSString *sinaAppkey;

@property (nonatomic, strong) NSString *sinaSecret;

@property (nonatomic, strong) NSString *sinaUrl;

@property (nonatomic, strong) NSString *umengAppkey;

@end

@implementation RgUMShare

#pragma mark - 单例模式

+ (instancetype)shareInstance {

    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        share = [[self alloc] init];
        
    });
    
    return share;

}

#pragma mark - 外部调用的静态方法

+ (void)setUMSocialAPPKey:(NSString *)appkey wxAppid:(NSString *)wxAppid wxAppSecret:(NSString *)wxSecret qqAppid:(NSString *)qqAppid qqAppkey:(NSString *)qqKey {

    [[RgUMShare shareInstance] setUMSocialAPPKey:appkey wxAppid:wxAppid wxAppSecret:wxSecret qqAppid:qqAppid qqAppkey:qqKey];

}

+ (BOOL)handleOpenURL:(NSURL *)url {

    return [UMSocialSnsService handleOpenURL:url];

}

+ (void)shareWithUmengType:(RgUMShareType)type title:(NSString *)title content:(NSString *)content shareUrl:(NSString *)url presentInViewController:(UIViewController *)presentController shareImage:(UIImage *)image {

    [[RgUMShare shareInstance] shareWithUmengType:type title:title content:content shareUrl:url presentInViewController:presentController shareImage:image];

}

#pragma mark - 懒汉模式

- (NSString *)wxUrl {

    if(!_wxUrl) {
    
        _wxUrl = @"http://www.umeng.com/social";
    
    }
    
    return _wxUrl;

}

- (NSString *)qqUrl {

    if(!_qqUrl) {
    
        _qqUrl = @"http://www.umeng.com/social";
    
    }
    
    return _qqUrl;

}

- (NSString *)sinaUrl {

    if(!_sinaUrl) {
    
        _sinaUrl = @"http://sns.whalecloud.com/sina2/callback";
    
    }
    
    return _sinaUrl;

}

- (void)setUMSocialAPPKey:(NSString *)appkey wxAppid:(NSString *)wxAppid wxAppSecret:(NSString *)wxSecret qqAppid:(NSString *)qqAppid qqAppkey:(NSString *)qqKey {

    self.wxAppid = wxAppid;
    self.wxAppSecret = wxSecret;
    self.qqAppid = qqAppid;
    self.qqAppKey = qqKey;
    self.umengAppkey = appkey;
    [UMSocialData setAppKey:appkey];

}

- (void)shareWithUmengType:(RgUMShareType)type title:(NSString *)title content:(NSString *)content shareUrl:(NSString *)url presentInViewController:(UIViewController *)presentController shareImage:(UIImage *)image {

    [UMSocialSnsService presentSnsIconSheetView:presentController
                                         appKey:self.umengAppkey
                                      shareText:content
                                     shareImage:image
                                shareToSnsNames:@[UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina, UMShareToSms]
                                       delegate:self];
    
    
    switch (type) {
        case RgQQ: {
            
            [UMSocialQQHandler setQQWithAppId:self.qqAppid appKey:self.qqAppKey url:self.qqUrl];
            
            [UMSocialData defaultData].extConfig.title = title;
            [UMSocialData defaultData].extConfig.qzoneData.url = url;
            
            break;
        }
        case RgQQZone: {
            
            [UMSocialQQHandler setQQWithAppId:self.qqAppid appKey:self.qqAppKey url:self.qqUrl];
            
            [UMSocialData defaultData].extConfig.title = title;
            [UMSocialData defaultData].extConfig.qqData.url = url;
            
            break;
        }
        case RgWeiXin: {
            
            [UMSocialWechatHandler setWXAppId:self.wxAppid appSecret:self.wxAppSecret url:self.wxUrl];
            
            [UMSocialData defaultData].extConfig.title = title;
            [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
            
            break;
        }
        case RgWeiXinZone: {
            
            [UMSocialWechatHandler setWXAppId:self.wxAppid appSecret:self.wxAppSecret url:self.wxUrl];
            
            [UMSocialData defaultData].extConfig.title = title;
            [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
            
            break;
        }
        case RgSina: {
            
            [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:self.sinaAppkey secret:self.sinaSecret RedirectURL:self.sinaUrl];
            
            [UMSocialData defaultData].extConfig.sinaData.urlResource.url = url;
            [UMSocialData defaultData].extConfig.sinaData.shareText = [NSString stringWithFormat:@"%@,%@", title, url];
            [UMSocialData defaultData].extConfig.sinaData.urlResource.resourceType = UMSocialUrlResourceTypeDefault;
            
            break;
        }
        case RgMessage: {
            
            [UMSocialData defaultData].extConfig.smsData.shareText = content;
            [UMSocialData defaultData].extConfig.smsData.shareImage = image;
            [UMSocialData defaultData].extConfig.smsData.snsName = title;
            
            break;
        }
    }

}

@end
