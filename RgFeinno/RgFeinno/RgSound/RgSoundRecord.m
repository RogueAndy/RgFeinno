//
//  RgSound.m
//  RgFeinno
//
//  Created by Rogue Andy on 16/9/1.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import "RgSoundRecord.h"
#import <AVFoundation/AVFoundation.h>

@interface RgSoundRecord()<AVAudioRecorderDelegate>

@property (nonatomic, strong) AVAudioRecorder *audioRecorder;

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@property (nonatomic, strong) NSString *audioFileName;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) void (^monitorChange)(CGFloat);

@end

@implementation RgSoundRecord

+ (instancetype)soundRecordWithName:(NSString *)fileName {

    RgSoundRecord *sound = [[RgSoundRecord alloc] init];
    [sound setAudioSession];
    [sound setAudioFileName:fileName];
    return sound;

}

#pragma mark - 设置音频会话

- (void)setAudioSession {

    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [session setActive:YES error:nil];

}

#pragma mark - 懒汉模式

- (AVAudioRecorder *)audioRecorder {

    if(!_audioRecorder) {
    
        NSURL *url = [self getAudioSavePath];
        NSDictionary *setting = [self getAudioSettting];
        NSError *error = nil;
        _audioRecorder = [[AVAudioRecorder alloc] initWithURL:url settings:setting error:&error];
        _audioRecorder.delegate = self;
        _audioRecorder.meteringEnabled = YES;
        if(error) {
        
            NSLog(@"create AudioRecorder error");
            return nil;
        
        }
    
    }
    
    return _audioRecorder;

}

- (AVAudioPlayer *)audioPlayer {

    if(!_audioPlayer) {
    
        NSURL *url = [self getAudioSavePath];
        NSError *error = nil;
        _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        _audioPlayer.numberOfLoops = 0;
        [_audioPlayer prepareToPlay];
        if(error) {
        
            NSLog(@"create AudioPlayer error");
            return nil;
        
        }
        
    }
    
    return _audioPlayer;

}

#pragma mark - 生成音频文件路劲

- (NSURL *)getAudioSavePath {

    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:[self getAudioFileName]];
    NSURL *fileURL = [NSURL fileURLWithPath:path];
    
    return fileURL;
    
}

- (NSString *)getAudioFileName {

    NSString *path = nil;
    
    if(!self.audioFileName || [self.audioFileName length] == 0) {
    
        NSString *timeInterval = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
        path = [NSString stringWithFormat:@"%@.mp3", timeInterval];
        
    } else {
    
        path = self.audioFileName;
    
    }
    
    return path;

}

#pragma mark - 设置音频格式

- (NSDictionary *)getAudioSettting {

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
    [parameters setObject:@(8000) forKey:AVSampleRateKey];
    [parameters setObject:@(1) forKey:AVNumberOfChannelsKey];
    [parameters setObject:@(8) forKey:AVLinearPCMBitDepthKey];
    [parameters setObject:@(YES) forKey:AVLinearPCMIsFloatKey];
    
    return parameters;

}

- (void)invalidate {

    [self.timer invalidate];
    self.timer = nil;

}

#pragma mark - Audio Delegate 

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {

    [self invalidate];

}

#pragma mark - 外部可调用的动态方法

#pragma mark - 开始录音

- (void)beginRecord {

    if(![self.audioRecorder isRecording]) {
    
        [self.audioRecorder record];
    
    }

}

#pragma mark - 暂停录音

- (void)pause {

    if([self.audioRecorder isRecording]) {
    
        [self.audioRecorder pause];
    
    }

}

#pragma mark - 停止录音

- (void)endRecord {

    [self.audioRecorder stop];
    [self invalidate];

}

#pragma mark - read record

- (void)readRecord {

    [self invalidate];
    
    if(![self.audioPlayer isPlaying]) {
    
        [self.audioPlayer play];
    
    }

}

#pragma mark - 启动监测声波变化

- (void)startMonitorAndChangeBlock:(void (^)(CGFloat progress))changeBlock {

    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(audioPowerChange:) userInfo:nil repeats:YES];
    self.monitorChange = changeBlock;
    
}

- (void)audioPowerChange:(NSTimer *)timer {

    [self.audioRecorder updateMeters];
    float power = [self.audioRecorder averagePowerForChannel:0]; //取得第一个通道的音频，注意音频强度范围时-160到0
    CGFloat progress = (1.0 / 160.0) * (power + 160.0);
    self.monitorChange(progress);

}

@end
