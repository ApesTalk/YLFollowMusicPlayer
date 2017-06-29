//
//  YLMusic.h
//  YLFollowMusicPlayer
//
//  Created by lumin on 2017/3/2.
//  Copyright © 2017年 YL. All rights reserved.
//

#import "YLBaseObject.h"
#import "DOUAudioFile.h"

@interface YLMusic : YLBaseObject <DOUAudioFile>
@property(nonatomic,copy)NSString *name;///< 歌名
@property(nonatomic,copy)NSString *poster;///< 海报路径
@property(nonatomic,copy)NSString *singer;///< 歌手
@property(nonatomic,copy)NSString *signerIcon;///< 歌手头像
@property(nonatomic,copy)NSString *lrc;///< 歌词地址
@property(nonatomic,assign,getter=isPlaying)BOOL playing;///< 是否正在播放
@property(nonatomic,assign,getter=isFavorited)BOOL favorite;///< 是否喜欢
@property(nonatomic,assign)CGFloat duration;///< 时长
@property (nonatomic, strong) NSURL *audioFileURL;

@end
