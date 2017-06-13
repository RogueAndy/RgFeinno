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

@end

@implementation ZPlayImageView

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

    self.avplayerlayer.hidden = NO;
    [self.avplayer play];

}

- (void)replayer {
    
    self.avplayeritem = [AVPlayerItem playerItemWithURL:[NSURL fileURLWithPath:self.video_url]];
    self.avplayer = [AVPlayer playerWithPlayerItem:self.avplayeritem];
    self.avplayerlayer = [AVPlayerLayer playerLayerWithPlayer:self.avplayer];
    self.avplayerlayer.frame = self.bounds;
    [self.layer addSublayer:self.avplayerlayer];
    [self.avplayer play];

}

- (void)stopVideo {

    [self.avplayer pause];
    [self.avplayerlayer removeFromSuperlayer];
    self.avplayer = nil;
    self.avplayeritem = nil;
    self.avplayerlayer = nil;

}

- (void)reset {

    [self.avplayer pause];
    [self.avplayerlayer removeFromSuperlayer];
    self.avplayer = nil;
    self.avplayeritem = nil;
    self.avplayerlayer = nil;
    self.video_url = nil;

}

- (void)dealloc {

    NSLog(@"------ %@ is dealloc", [self class]);
    [[NSNotificationCenter defaultCenter] removeObserver:AVPlayerItemDidPlayToEndTimeNotification];

}

#pragma mark - 通知回调

- (void)finishPlay:(NSNotification *)notification {

    if([_delegate performSelector:@selector(finishPlay)]) {
    
        [_delegate finishPlay];
    
    }

}

@end
