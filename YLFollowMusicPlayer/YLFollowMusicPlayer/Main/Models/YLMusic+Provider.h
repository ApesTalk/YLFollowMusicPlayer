//
//  YLMusic+Provider.h
//  YLFollowMusicPlayer
//
//  Created by TK-001289 on 2017/6/23.
//  Copyright © 2017年 YL. All rights reserved.
//

#import "YLMusic.h"

@interface YLMusic (Provider)
+ (NSArray *)yl_remoteTracks;
+ (NSArray *)yl_musicLibraryTracks;
@end
