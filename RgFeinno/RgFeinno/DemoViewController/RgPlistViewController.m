//
//  RgPlistViewController.m
//  RgFeinno
//
//  Created by Rogue Andy on 16/9/6.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import "RgPlistViewController.h"
#import "RgPlist.h"

@interface RgPlistViewController ()

@end

@implementation RgPlistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *bu = [UIButton buttonWithType:UIButtonTypeCustom];
    bu.backgroundColor = [UIColor orangeColor];
    [bu addTarget:self action:@selector(archive) forControlEvents:UIControlEventTouchUpInside];
    bu.frame = CGRectMake(20, 100, 100, 40);
    [self.view addSubview:bu];
    
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.backgroundColor = [UIColor redColor];
    [bt addTarget:self action:@selector(unarchive) forControlEvents:UIControlEventTouchUpInside];
    bt.frame = CGRectMake(160, 100, 100, 40);
    [self.view addSubview:bt];
    
}

- (void)archive {
    
    [RgPlist plistWithFileName:@"wang" array:@[@"44", @"22", @"33"]];
    [RgPlist plistWithFileName:@"wang" addArray:@[@"66", @"55", @{@"name": @"zhonglingjie"}]];
    
    //    RgSampleEntity *entity = [[RgSampleEntity alloc] init];
    //    entity.userage = 12;
    //    entity.height = 1.72;
    //    entity.username = @"jack";
    
//    RgSampleEntity *entity1 = [[RgSampleEntity alloc] init];
//    entity1.userage = 20;
//    entity1.height = 1.79;
//    entity1.username = @"mark";
//    //
//    RgTwoEntity *entity2 = [[RgTwoEntity alloc] init];
//    entity2.username = @"Rogue";
//    entity2.cuohao = @"Andy";
    
    //    if([RgArchive addContentArchiveWithFileName:@"six" object:@[entity1, entity2]]) {
    //
    //        NSLog(@"YES");
    //
    //    }
    
//    if([RgArchive archiveWithFileName:@"eight" object:[NSMutableArray arrayWithObjects:entity1, entity2, nil]]) {
//        
//        NSLog(@"归档成功了");
//        
//    }
    
}

- (void)unarchive {
    
    NSLog(@"%@", [RgPlist plistArrayWitFileName:@"wang"]);
    
//    NSArray *arrays = [RgArchive unarchiveWitFileName:@"eight"];
//    [arrays enumerateObjectsUsingBlock:^(NSObject * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        
//        if([obj isKindOfClass:[RgSampleEntity class]]) {
//            
//            RgSampleEntity *entity = (RgSampleEntity *)obj;
//            NSLog(@"%@-- %ld-- %f", entity.username, (long)entity.userage, entity.height);
//            
//        } else if([obj isKindOfClass:[RgTwoEntity class]]) {
//            
//            RgTwoEntity *entity = (RgTwoEntity *)obj;
//            NSLog(@"%@ === %@", entity.username, entity.cuohao);
//            
//        }
//        
//    }];
    
}

@end
