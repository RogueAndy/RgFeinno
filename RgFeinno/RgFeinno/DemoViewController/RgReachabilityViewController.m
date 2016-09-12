//
//  RgReachabilityViewController.m
//  RgFeinno
//
//  Created by Rogue Andy on 16/9/12.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import "RgReachabilityViewController.h"
#import "RealReachability.h"

@interface RgReachabilityViewController ()

@property (strong, nonatomic) UILabel *currentLabel;

@end

@implementation RgReachabilityViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    self.currentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 200, CGRectGetWidth(self.view.frame) - 40, 40)];
    self.currentLabel.backgroundColor = [UIColor orangeColor];
    self.currentLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.currentLabel];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(networkChanged:)
                                                 name:kRealReachabilityChangedNotification
                                               object:nil];
    
    ReachabilityStatus status = [GLobalRealReachability currentReachabilityStatus];
    NSLog(@"Initial reachability status:%@",@(status));
    
    if (status == RealStatusNotReachable)
    {
        self.currentLabel.text = @"Network unreachable!";
    }
    
    if (status == RealStatusViaWiFi)
    {
        self.currentLabel.text = @"Network wifi! Free!";
    }
    
    if (status == RealStatusViaWWAN)
    {
        self.currentLabel.text = @"Network WWAN! In charge!";
    }
    
}

- (void)networkChanged:(NSNotification *)notification
{
    RealReachability *reachability = (RealReachability *)notification.object;
    ReachabilityStatus status = [reachability currentReachabilityStatus];
    ReachabilityStatus previousStatus = [reachability previousReachabilityStatus];
    NSLog(@"networkChanged, currentStatus:%@, previousStatus:%@", @(status), @(previousStatus));
    
    if (status == RealStatusNotReachable)
    {
        self.currentLabel.text = @"Network unreachable!";
    }
    
    if (status == RealStatusViaWiFi)
    {
        self.currentLabel.text = @"Network wifi! Free!";
    }
    
    if (status == RealStatusViaWWAN)
    {
        self.currentLabel.text = @"Network WWAN! In charge!";
    }
    
    WWANAccessType accessType = [GLobalRealReachability currentWWANtype];
    
    if (status == RealStatusViaWWAN)
    {
        if (accessType == WWANType2G)
        {
            self.currentLabel.text = @"RealReachabilityStatus2G";
        }
        else if (accessType == WWANType3G)
        {
            self.currentLabel.text = @"RealReachabilityStatus3G";
        }
        else if (accessType == WWANType4G)
        {
            self.currentLabel.text = @"RealReachabilityStatus4G";
        }
        else
        {
            self.currentLabel.text = @"Unknown RealReachability WWAN Status, might be iOS6";
        }
    }
    
    
}

#warning - 一定要移除通知

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
