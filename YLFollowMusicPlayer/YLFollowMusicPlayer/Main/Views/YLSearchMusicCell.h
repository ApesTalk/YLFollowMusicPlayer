//
//  YLSearchMusicCell.h
//  YLFollowMusicPlayer
//
//  Created by lumin on 2017/3/4.
//  Copyright © 2017年 YL. All rights reserved.
//

#import "YLBaseTableViewCell.h"

@interface YLSearchMusicCell : YLBaseTableViewCell
@property(nonatomic,strong)UIImageView *icon;///< 图标
@property(nonatomic,strong)UILabel *nameLabel;///< 歌曲名字
@property(nonatomic,strong)UILabel *signerLabel;///< 歌手名字

@end
