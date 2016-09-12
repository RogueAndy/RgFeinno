//
//  RgSoundPlay.m
//  RgFeinno
//
//  Created by Rogue Andy on 16/9/2.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import "RgSoundPlay.h"
#import <AVFoundation/AVFoundation.h>

@interface RgSoundPlay()<AVAudioPlayerDelegate>

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@property (nonatomic, strong) NSURL *audioFileName;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) void (^monitorChange)(CGFloat);

@end

@implementation RgSoundPlay

+ (instancetype)soundWithFilePath:(NSURL *)filePath {

    RgSoundPlay *play = [[RgSoundPlay alloc] init];
    play.audioFileName = filePath;
    return play;
    
}

- (void)startMonitorAndChangeBlock:(void (^)(CGFloat))changeBlock {

    self.monitorChange = changeBlock;
    
    if(self.monitorChange) {
    
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(audioPowerChange:) userInfo:nil repeats:YES];
    
    }

}

- (void)endRecord {

    [self invalidate];
    [self.audioPlayer stop];

}

- (void)invalidate {
    
    [self.timer invalidate];
    self.timer = nil;
    
}

#pragma mark - 懒汉模式

- (AVAudioPlayer *)audioPlayer {
    
    if(!_audioPlayer) {
        
        NSError *error = nil;
        _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:self.audioFileName error:&error];
        _audioPlayer.numberOfLoops = 0;
        _audioPlayer.delegate = self;
        [_audioPlayer prepareToPlay];
        if(error) {
            
            NSLog(@"create AudioPlayer error");
            return nil;
            
        }
        
    }
    
    return _audioPlayer;
    
}

- (void)audioPowerChange:(NSTimer *)timer {
    
    CGFloat progress = self.audioPlayer.currentTime / self.audioPlayer.duration;
    self.monitorChange(progress);
    
}

#pragma mark - Audio Player Delegate

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {

    [self invalidate];

}

@end
