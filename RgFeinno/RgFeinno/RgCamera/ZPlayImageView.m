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

}

- (void)playVideo {

    self.avplayerlayer.hidden = NO;
    [self.avplayer play];

}

- (void)reset {

    [self.avplayer pause];
    [self.avplayerlayer removeFromSuperlayer];
    self.avplayer = nil;
    self.avplayeritem = nil;
    self.avplayerlayer = nil;
    self.video_url = nil;

}

@end
