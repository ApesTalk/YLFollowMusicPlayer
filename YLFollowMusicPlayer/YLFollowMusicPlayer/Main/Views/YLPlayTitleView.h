//
//  YLPlayTitleView.h
//  YLFollowMusicPlayer
//
//  Created by TK-001289 on 2017/3/9.
//  Copyright © 2017年 YL. All rights reserved.
//

#import "YLBaseView.h"
@class YLMusic;

@interface YLPlayTitleView : YLBaseView
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *subTitleLabel;

- (void)refreshWithMusic:(YLMusic *)music;

@end
