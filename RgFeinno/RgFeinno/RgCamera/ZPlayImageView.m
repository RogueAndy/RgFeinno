//
//  ZPlayImageView.m
//  RgFeinno
//
//  Created by rogue on 2017/6/13.
//  Copyright © 2017年 RogueAndy. All rights reserved.
//

#import "ZPlayImageView.h"
#import <AVFoundation/AVFoundation.h>

@interface ZPlayImageView()

@property (nonatomic, strong, readwrite) NSString *video_url;

@property (nonatomic, strong) AVPlayerLayer *avplayerlayer;

@property (nonatomic, strong) AVPlayer *avplayer;

@property (nonatomic, strong) AVPlayerItem *avplayeritem;

/**
 时间轴
 */
@property (nonatomic, strong) CAShapeLayer *timeLayer;

/**
 视频的总时间
 */
@property (nonatomic, assign) CGFloat totaltime;

@end

@implementation ZPlayImageView

- (CAShapeLayer *)getTimeLayer {

    if(!_timeLayer) {
    
        _timeLayer = [CAShapeLayer layer];
        _timeLayer.backgroundColor = [UIColor colorWithRed:151/255.f green:204/255.f blue:82/255.f alpha:1].CGColor;
        _timeLayer.fillColor = [UIColor colorWithRed:7/255.f green:145/255.f blue:107/255.f alpha:1].CGColor;
        _timeLayer.frame = CGRectMake(0, CGRectGetHeight([[UIScreen mainScreen] bounds]) * 2.0 / 3.0, CGRectGetWidth([[UIScreen mainScreen] bounds]),4);
        [self.layer addSublayer:_timeLayer];
    
    }
    
    return _timeLayer;

}

- (void)setVideoUrl:(NSURL *)url {

    self.video_url = [url path];
    self.avplayeritem = [AVPlayerItem playerItemWithURL:url];
    self.avplayer = [AVPlayer playerWithPlayerItem:self.avplayeritem];
    self.avplayerlayer = [AVPlayerLayer playerLayerWithPlayer:self.avplayer];
    self.avplayerlayer.frame = self.bounds;
    [self.layer addSublayer:self.avplayerlayer];
    self.avplayerlayer.hidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(finishPlay:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:nil];

}

- (void)playVideo {

    self.timeLayer.hidden = NO;
    self.avplayerlayer.hidden = NO;
    [self animationCompent:self.totaltime];
    [self.avplayer play];

}

- (void)replayer {
    
    self.avplayeritem = [AVPlayerItem playerItemWithURL:[NSURL fileURLWithPath:self.video_url]];
    // 注册
    [self.avplayeritem addObserver:self
                        forKeyPath:@"status"
                           options:NSKeyValueObservingOptionNew
                           context:nil];
    self.avplayer = [AVPlayer playerWithPlayerItem:self.avplayeritem];
    self.avplayerlayer = [AVPlayerLayer playerLayerWithPlayer:self.avplayer];
    self.avplayerlayer.frame = self.bounds;
    [self.layer addSublayer:self.avplayerlayer];
    
    [self getTimeLayer];

}

- (void)stopVideo {

    [self.avplayeritem removeObserver:self forKeyPath:@"status"]; // 释放注册
    [self.avplayer pause];
    [self.timeLayer removeFromSuperlayer];
    [self.avplayerlayer removeFromSuperlayer];
    self.avplayer = nil;
    self.avplayeritem = nil;
    self.avplayerlayer = nil;
    self.timeLayer = nil;

}

- (void)reset {

    [self.avplayer pause];
    [self.timeLayer removeFromSuperlayer];
    [self.avplayerlayer removeFromSuperlayer];
    self.avplayer = nil;
    self.avplayeritem = nil;
    self.avplayerlayer = nil;
    self.video_url = nil;
    self.timeLayer = nil;
    self.totaltime = 0.0;

}

- (void)animationCompent:(CGFloat)time {

    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:(CGPointMake(0, self.timeLayer.frame.size.height / 2.0))];
    [path addLineToPoint:(CGPointMake(CGRectGetWidth([[UIScreen mainScreen] bounds]), self.timeLayer.frame.size.height / 2.0))];
    
    self.timeLayer.path = path.CGPath;
    self.timeLayer.lineWidth = self.timeLayer.frame.size.height;
    self.timeLayer.strokeColor = [UIColor colorWithRed:7/255.f green:145/255.f blue:107/255.f alpha:1].CGColor;

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.removedOnCompletion = NO;
    animation.duration = time;
    animation.fromValue = @(0);
    animation.toValue = @(1);
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.timeLayer addAnimation:animation forKey:@""];

}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:AVPlayerItemDidPlayToEndTimeNotification];
    NSLog(@"------ %@ is dealloc", [self class]);
    
}

#pragma mark - kvo

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context
{
    
    if ([keyPath isEqualToString:@"status"]) {//状态发生改变
        AVPlayerStatus status = [[change objectForKey:@"new"] integerValue];
        
        switch (status) {
            case AVPlayerStatusReadyToPlay:
            {
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    self.totaltime = floorf(CMTimeGetSeconds(self.avplayeritem.asset.duration));
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self animationCompent:self.totaltime];
                        [self.avplayer play];
                    });
                });
                
            }
                break;
                
            case AVPlayerStatusFailed:
            {
                
            }
                
            default:
            {
                
                
                
            }
                break;
        }
        
    }
    
}

#pragma mark - 通知回调

- (void)finishPlay:(NSNotification *)notification {

    if([_delegate performSelector:@selector(finishPlay)]) {
    
        [_delegate finishPlay];
    
    }

}

@end
