//
//  YLPlayerViewController.h
//  YLFollowMusicPlayer
//
//  Created by lumin on 2017/3/4.
//  Copyright © 2017年 YL. All rights reserved.
//

#import "YLBaseViewController.h"
@class YLMusic;

@interface YLPlayerViewController : YLBaseViewController
@property (nonatomic, copy) NSArray *musicList;

+ (instancetype)sharePalyer;

- (void)loadMusics:(NSArray *)musics;
- (BOOL)isPlaying;

@end
//http://msching.github.io/blog/2014/11/06/audio-in-ios-8/
