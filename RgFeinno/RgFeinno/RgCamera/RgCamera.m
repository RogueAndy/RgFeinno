//
//  RgCamera.m
//  RgFeinno
//
//  Created by Rogue Andy on 16/8/29.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import "RgCamera.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import "UIImagePickerController+RgCameraNavigationController.h"
#import "ZProgressButton.h"
#import "ZPlayImageView.h"
#import "ZCameraControlButton.h"

@interface RgCamera()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, ZProgressButtonDelegate>

/**
 *  选中相片之后回调方法
 */

@property (nonatomic, strong) void (^didFinishPickingPhotoWithInfo)(NSDictionary *cameraInfo, UIImagePickerController *caremaEntity);

/**
 *  选中视频之后回调视频地址
 */

@property (nonatomic, strong) void (^didFinishPickingVideoWithInfo)(NSString *videoURL, UIImagePickerController *caremaEntity);

/**
 *  自动判断是否相片还是视频类型， YES 为相片，NO 为视频
 */

@property (nonatomic, assign) BOOL photoOrVideo;

/**
 *  缓存视频流
 */

@property (nonatomic, strong) AVAssetExportSession *exprotSession;

/**
 *  视频显示最大的时间秒
 */

@property (nonatomic, assign) CGFloat videoMaxSecond;

/**
 *  视频最大的大小限制 M
 */

@property (nonatomic, assign) CGFloat videoMaxSize;

/**
 记录视频的类型
 */
@property (nonatomic, assign) RgCameraVideo cameraVideoType;

/** 以下为，自定义仿微信模式的拍摄控件 */

@property (nonatomic, strong) ZProgressButton *recordButton;

@property (nonatomic, strong) ZCameraControlButton *downButton;

@property (nonatomic, strong) ZCameraControlButton *xButton;

@property (nonatomic, strong) ZCameraControlButton *rightButton;

@property (nonatomic, strong) ZCameraControlButton *playButton;

@property (nonatomic, strong) ZPlayImageView *snapshot;

@property (nonatomic, assign) BOOL record_over;

@property (nonatomic, strong) NSDictionary *countdownAttribution;

@end

@implementation RgCamera

#pragma mark - Photo

+ (instancetype)cameraPhotoType:(RgCameraPhoto)type barFontColor:(UIColor *)fontColor barColor:(UIColor *)barColor pushInParentController:(UIViewController *)parentController didFinishPickingPhotoWithInfo:(void (^)(NSDictionary *cameraInfo, UIImagePickerController *caremaEntity))complete {

    RgCamera *camera = [[RgCamera alloc] init];
    return [camera cameraPhotoType:type barFontColor:fontColor barColor:barColor pushInParentController:parentController didFinishPickingPhotoWithInfo:complete];

}

#pragma mark - Video

+ (instancetype)cameraVideoType:(RgCameraVideo)type barFontColor:(UIColor *)fontColor barColor:(UIColor *)barColor maxSecond:(CGFloat)videoMaxSecond maxSize:(CGFloat)videoMaxSize countdownAttribution:(NSDictionary *)attribution pushInParentController:(UIViewController *)parentController didFinishPickingVideoWithInfo:(void (^)(NSString *, UIImagePickerController *))complete {

    RgCamera *camera = [[RgCamera alloc] init];
    return [camera cameraVideoType:type barFontColor:fontColor barColor:barColor maxSecond:videoMaxSecond maxSize:videoMaxSize countdownAttribution:(NSDictionary *)attribution pushInParentController:parentController didFinishPickingVideoWithInfo:complete];

}

#pragma mark - 动态方法创建得到相机实体

- (instancetype)cameraPhotoType:(RgCameraPhoto)type barFontColor:(UIColor *)fontColor barColor:(UIColor *)barColor pushInParentController:(UIViewController *)parentController didFinishPickingPhotoWithInfo:(void (^)(NSDictionary *cameraInfo, UIImagePickerController *caremaEntity))complete {

    self.didFinishPickingPhotoWithInfo = complete;
    self.photoOrVideo = YES;
    self.delegate = self;
    [self setCameraBarWithFontColor:fontColor barColor:barColor];
    
    switch (type) {
        case RgCameraPhotoShoot: {
            
            self.sourceType = UIImagePickerControllerSourceTypeCamera;
          
            break;
        }
        case RgCameraPhotoLocalSource: {
            
            self.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            break;
        }
    }
    
    [parentController presentViewController:self animated:YES completion:nil];

    return self;
}



- (instancetype)cameraVideoType:(RgCameraVideo)type barFontColor:(UIColor *)fontColor barColor:(UIColor *)barColor maxSecond:(CGFloat)videoMaxSecond maxSize:(CGFloat)videoMaxSize countdownAttribution:(NSDictionary *)attribution pushInParentController:(UIViewController *)parentController didFinishPickingVideoWithInfo:(void (^)(NSString *videoURL, UIImagePickerController *caremaEntity))complete {
    
    self.countdownAttribution = attribution;
    self.cameraVideoType = type;
    self.videoMaxSize = videoMaxSize;
    self.videoMaxSecond = videoMaxSecond;
    self.didFinishPickingVideoWithInfo = complete;
    self.photoOrVideo = NO;
    self.delegate = self;
    [self setCameraBarWithFontColor:fontColor barColor:barColor];
    
    switch (type) {
        case RgCameraVideoShoot: {
        
            self.sourceType = UIImagePickerControllerSourceTypeCamera;
            self.videoMaximumDuration = self.videoMaxSecond;
            self.mediaTypes = @[(__bridge NSString *)kUTTypeMovie];
            self.videoQuality = UIImagePickerControllerQualityTypeHigh;
            self.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
        
        }
            break;
        case RgCameraVideoLocalSource: {
        
            self.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            self.mediaTypes = @[(__bridge NSString *)kUTTypeMovie];
        
        }
            break;
            
        case RgCameraVideoShootCool: {
        
            self.sourceType = UIImagePickerControllerSourceTypeCamera;
            self.mediaTypes = @[(__bridge NSString *)kUTTypeMovie];
            self.videoQuality = UIImagePickerControllerQualityTypeHigh;
            self.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
            [self setShowsCameraControls:NO];
        
        }
            break;
    }
    
    [parentController presentViewController:self animated:YES completion:nil];
    
    return self;
}

#pragma mark - viewDidLoad

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    if(self.cameraVideoType == RgCameraVideoShootCool) {
    
        self.snapshot = [[ZPlayImageView alloc] init];
        self.snapshot.frame = self.view.bounds;
        self.snapshot.hidden = YES;
        self.cameraOverlayView = self.snapshot;
        
        self.downButton = [ZCameraControlButton initWithCameraButtonType:ZCCloseDownButton frame:CGRectMake(0, 0, 40, 40) drawRect:nil];
        [self.downButton addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
        self.downButton.center = CGPointMake(40, 42);
        [self.view addSubview:self.downButton];
        
        self.recordButton = [ZProgressButton initWithFrame:CGRectMake(0, 0, 80, 80) circleFrame:CGRectMake(0, 0, 70, 70) strokeColor:[UIColor orangeColor] backgroundColor:[UIColor whiteColor] duration:10 countdown:YES countdownAttribution:self.countdownAttribution];
        self.recordButton.delegate = self;
        self.recordButton.center = CGPointMake(CGRectGetWidth(self.view.frame) / 2.0, CGRectGetHeight(self.view.frame) - 70);
        [self.recordButton addTarget:self action:@selector(recordAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.recordButton];
    
    }
    
}

#pragma mark - control buttons

- (void)readyShowRecordOver {

    if(!_xButton) {
    
        _xButton = [ZCameraControlButton initWithCameraButtonType:ZCCloseXButton frame:CGRectMake(0, 0, 50, 50) drawRect:nil];
        [_xButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _xButton.center = CGPointMake(25 + 30, CGRectGetHeight(self.view.frame) - 25 - 30);
        [self.view addSubview:_xButton];
    
    }
    
    if(!_rightButton) {
        
        _rightButton = [ZCameraControlButton initWithCameraButtonType:ZCRightButton frame:CGRectMake(0, 0, 50, 50) drawRect:nil];
        [_rightButton addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
        _rightButton.center = CGPointMake(CGRectGetWidth(self.view.frame) - 25 - 30, CGRectGetHeight(self.view.frame) - 25 - 30);
        [self.view addSubview:_rightButton];
        
    }
    
    if(!_playButton) {
    
        _playButton = [ZCameraControlButton initWithCameraButtonType:ZCPlayButton frame:CGRectMake(0, 0, 60, 60) drawRect:nil];
        [_playButton addTarget:self action:@selector(playAction) forControlEvents:UIControlEventTouchUpInside];
        _playButton.center = CGPointMake(CGRectGetWidth(self.view.frame) / 2.0, CGRectGetHeight(self.view.frame) - 25 - 30);
        [self.view addSubview:_playButton];
    
    }
    
    _xButton.hidden = NO;
    _rightButton.hidden = NO;
    _playButton.hidden = NO;

}

- (void)readyHideRecordOver {

    _downButton.hidden = YES;
    _recordButton.hidden = YES;

}

- (void)readyShowRecordBefore {

    _downButton.hidden = NO;
    _recordButton.hidden = NO;
    [_recordButton reset];

}

- (void)readyHideRecordBefore {

    _xButton.hidden = YES;
    _rightButton.hidden = YES;
    _playButton.hidden = YES;

}

#pragma mark - ZProgressButtonDelegate

- (void)progressAnimationOver {

    [self.recordButton endAnimation];
    
    [self readyShowRecordOver];
    [self readyHideRecordOver];
    [self stopVideoCapture];
    self.record_over = YES;

}

#pragma mark - button Action

- (void)playAction {

    [self.snapshot playVideo];

}

- (void)sureAction {

    if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(self.snapshot.video_url)) {
        
        UISaveVideoAtPathToSavedPhotosAlbum(self.snapshot.video_url, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);//保存视频到相簿
    }

}

- (void)backAction {

    [self readyHideRecordBefore];
    [self readyShowRecordBefore];
    self.snapshot.hidden = YES;
    [self.snapshot reset];

}

- (void)closeAction {

    [self.recordButton endAnimation];
    [self.recordButton reset];
    self.snapshot.hidden = YES;
    [self.snapshot reset];
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)recordAction:(ZProgressButton *)sender {

    switch (sender.zpstatus) {
        case ZPNoBeginAnimation:
        {
        
            [self.recordButton beginAnimation];
            [self takePicture];
            [self startVideoCapture];
            self.record_over = NO;
        
        }
            break;
            
        case ZPBeginAnimation:
        {
            
            [self.recordButton endAnimation];
            
            [self readyShowRecordOver];
            [self readyHideRecordOver];
            [self stopVideoCapture];
            self.record_over = YES;
            
        }
            break;
            
        case ZPEndAnimation:
        {
            
            
            
        }
            break;
    }

}

#pragma mark - Image PickerViewController Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    /**
     * 若是自定义录制模式，且正在播放，截取第一帧的图片
     */
    if(self.cameraVideoType == RgCameraVideoShootCool && self.recordButton.zpstatus == ZPBeginAnimation) {
    
        self.snapshot.image = info[UIImagePickerControllerOriginalImage];
        return;
    
    }
    
    /**
     * 若是自定义录制模式，且已经录制完毕，显示出第一帧图片的 imageview
     */
    if(self.cameraVideoType == RgCameraVideoShootCool && self.recordButton.zpstatus == ZPEndAnimation) {
        
        self.snapshot.hidden = NO;
        NSURL *videoUrl = [info valueForKey:UIImagePickerControllerMediaURL];
        [self.snapshot setVideoUrl:videoUrl];
        return;
        
    }
    
    if(self.photoOrVideo) {
    
        if(self.didFinishPickingPhotoWithInfo) {
            
            self.didFinishPickingPhotoWithInfo(info, picker);
        
        } else {
        
            [picker dismissViewControllerAnimated:YES completion:nil];
        
        }
        
        return;
    
    }
    
    NSURL *url = [info objectForKey:UIImagePickerControllerMediaURL];
    [self imagePickerController:picker didFinishPickingMediaWithURL:url];

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithURL:(NSURL *)url {

    if(!url) { // 地址不存在，则提示无法上传，重新选取，这种事系统错误
        
        [self unloadMovieAndDismissImageviewController:picker alertMessage:@"系统没有找到该视频地址"];
        return;
        
    }
    
    /**
     *  首先判断视频的时间长度大小，不能超过 60 秒，否则不能执行下一步操作
     */
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:url options:nil];
    CGFloat avAssetDuration = CMTimeGetSeconds(avAsset.duration);
    if(self.videoMaxSecond != 0 && avAssetDuration > self.videoMaxSecond) {
        
        [self unloadMovieAndDismissImageviewController:picker alertMessage:[NSString stringWithFormat:@"您所拍摄的视频时间超过了 %ld S", (NSInteger)self.videoMaxSecond]];
        return;
        
    }
    
    /**
     *  接下来对视频大小进行判断，如果高于 150 M 则无法上传
     */
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    float fileSize = data.length / 1024.0 / 1024;
    
    if (self.videoMaxSize != 0 && fileSize > self.videoMaxSize) {
        
        [self unloadMovieAndDismissImageviewController:picker alertMessage:[NSString stringWithFormat:@"您所拍摄的视频大小超过了 %ld M", (NSInteger)self.videoMaxSize]];
        return;
        
    }
    
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    
    if ([compatiblePresets containsObject:AVAssetExportPresetMediumQuality]) {
        
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetLowQuality];
        self.exprotSession = exportSession;
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];
        [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
        NSString *outputPath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/rgCamera_vedio_%@.mp4", [formater stringFromDate:[NSDate date]]];
        
        exportSession.outputURL = [NSURL fileURLWithPath: outputPath];
        exportSession.shouldOptimizeForNetworkUse = YES;
        exportSession.outputFileType = AVFileTypeMPEG4;
        
        __weak RgCamera *weakSelf = self;
        void (^convertFinish)(NSURL *path) = ^(NSURL *path) {
            
            if(weakSelf.didFinishPickingVideoWithInfo) {
                
                weakSelf.didFinishPickingVideoWithInfo(path.absoluteString, picker);
                return;
                
            }
            
            [picker dismissViewControllerAnimated:YES completion:nil];
            
        };
        
        [exportSession exportAsynchronouslyWithCompletionHandler:^{
            switch ([exportSession status]) {
                case AVAssetExportSessionStatusFailed: {
                    
                    [self unloadMovieAndDismissImageviewController:picker alertMessage:@"转换视频失败"];
                    
                }
                    break;
                    
                case AVAssetExportSessionStatusCancelled:
                {
                    
                    [self unloadMovieAndDismissImageviewController:picker alertMessage:@"取消转换视频"];
                    
                }
                    break;
                case AVAssetExportSessionStatusCompleted: {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        convertFinish([NSURL fileURLWithPath:outputPath]);
                    });
                    
                }
                    break;
                    
                default:
                    break;
            }
        }];
    } else {
        
        [self unloadMovieAndDismissImageviewController:picker alertMessage:@"无法转换视频"];
        
    }

}

//视频保存后的回调
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
    [self imagePickerController:self didFinishPickingMediaWithURL:[NSURL fileURLWithPath:videoPath]];
    
}



#pragma mark - 其余一些自定义方法

#pragma mark - 取消上传视频

- (void)unloadMovieAndDismissImageviewController:(UIImagePickerController *)picker alertMessage:(NSString *)alertMessage {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    if(alertMessage) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:alertMessage delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        [self dispatch_async_main:^{
            [alert show];
        }];
        
    }
    
}

#pragma mark - 主线程使用

- (void)dispatch_async_main:(void (^)(void))complete {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        complete();
    });
    
}

- (void)dealloc {

    self.recordButton.delegate = nil;
    self.recordButton = nil;
    self.downButton = nil;
    self.xButton = nil;
    self.rightButton = nil;
    NSLog(@"--------- the RgCamera is dismissing----------");

}

@end
