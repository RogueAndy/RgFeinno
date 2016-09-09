//
//  RgSpeech.m
//  RgFeinno
//
//  Created by Rogue Andy on 16/9/9.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import "RgSpeech.h"
#import <AVFoundation/AVFoundation.h>

static RgSpeech *speech = nil;

@interface RgSpeech()<AVSpeechSynthesizerDelegate>

@property (nonatomic, strong) AVSpeechSynthesizer *speechSynthesizer;

@end

@implementation RgSpeech

#pragma mark - 单例模式

+ (instancetype)shareInstance {

    static dispatch_once_t once;
    _dispatch_once(&once, ^{
        
        speech = [[self alloc] init];
        
    });
    
    return speech;

}

#pragma mark - 外部调用的静态方法

+ (void)startSpeech:(NSString *)speechString {
    
    [[self shareInstance] startSpeech:speechString];

}

+ (void)endSpeech {

    [[self shareInstance] endSpeech];

}

+ (void)pauseSpeech {

    [[self shareInstance] pauseSpeech];

}

+ (void)continueSpeech {

    [[self shareInstance] continueSpeech];

}

#pragma mark - 懒汉模式

- (AVSpeechSynthesizer *)speechSynthesizer {

    if(!_speechSynthesizer) {
    
        _speechSynthesizer = [[AVSpeechSynthesizer alloc] init];
        _speechSynthesizer.delegate = self;
    
    }
    
    return _speechSynthesizer;

}

#pragma mark - 操控方法

- (void)startSpeech:(NSString *)speechString {
    
    if([self.speechSynthesizer isPaused] || [self.speechSynthesizer isSpeaking]) {
    
        [self.speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryWord];
    
    }
    
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:speechString];
    utterance.rate = 0.5;
    
    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];
    utterance.voice = voice;
    [self.speechSynthesizer speakUtterance:utterance];

}

- (void)endSpeech {

    [self.speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryWord];

}

- (void)pauseSpeech {

    [self.speechSynthesizer pauseSpeakingAtBoundary:AVSpeechBoundaryWord];

}

- (void)continueSpeech {

    [self.speechSynthesizer continueSpeaking];

}

#pragma mark - Speech Delegate

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance {

    NSLog(@"-------------开始播放语音");

}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance {

    NSLog(@"-------------结束播放语音");

}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didPauseSpeechUtterance:(AVSpeechUtterance *)utterance {

    NSLog(@"-------------暂停播放语音");

}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didContinueSpeechUtterance:(AVSpeechUtterance *)utterance {

    NSLog(@"-------------继续播放语音");

}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance *)utterance {

    NSLog(@"-------------取消播放语音");

}

@end
