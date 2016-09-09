//
//  RgCameraAfterViewController.m
//  RgFeinno
//
//  Created by Rogue Andy on 16/9/9.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import "RgCameraAfterViewController.h"

@interface RgCameraAfterViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation RgCameraAfterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(camera:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor orangeColor];
    button.frame = CGRectMake(20, 160, CGRectGetWidth(self.view.frame) - 40, 40);
    [self.view addSubview:button];
    
}

- (void)camera:(UIButton *)sender {

    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {

    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController pushViewController:[RgCameraShowViewController initWithImage:image] animated:YES];

}

@end



@interface RgCameraShowViewController()

@property (nonatomic, strong) UIImage *originalImage;

@end

@implementation RgCameraShowViewController

+ (instancetype)initWithImage:(UIImage *)image {

    RgCameraShowViewController *vc = [[RgCameraShowViewController alloc] init];
    vc.originalImage = image;
    return vc;

}

- (void)viewDidLoad {

    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    imageView.image = self.originalImage;
    [self.view addSubview:imageView];

}

@end
