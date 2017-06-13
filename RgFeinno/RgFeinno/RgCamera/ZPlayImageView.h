//
//  ZPlayImageView.h
//  RgFeinno
//
//  Created by rogue on 2017/6/13.
//  Copyright © 2017年 RogueAndy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>

@protocol ZPlayImageDelegate <NSObject>

@optional

- (void)finishPlay;

@end

@interface ZPlayImageView : UIImageView

@property (nonatomic, weak) id<ZPlayImageDelegate> delegate;

/**
 视频的临时存储地址
 */
@property (nonatomic, strong, readonly) NSString *video_url;

/**
 创建一个播放器地址
 
 @param url 地址
 */
- (void)setVideoUrl:(NSURL *)url;

/**
 开始播放
 */
- (void)playVideo;

/**
 重新播放
 */
- (void)replayer;

/**
 停止播放
 */
- (void)stopVideo;

/**
 重置
 */
- (void)reset;

@end
