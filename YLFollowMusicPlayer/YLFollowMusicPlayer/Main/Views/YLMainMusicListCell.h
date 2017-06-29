//
//  YLMainMusicListCell.h
//  YLFollowMusicPlayer
//
//  Created by lumin on 2017/3/2.
//  Copyright © 2017年 YL. All rights reserved.
//

#import "YLBaseTableViewCell.h"

@interface YLMainMusicListCell : YLBaseTableViewCell
@property(nonatomic,strong)UIImageView *posterView;///< 海报图
@property(nonatomic,strong)UILabel *nameLabel;///< 标题
@property(nonatomic,strong)UILabel *signerLabel;///< 歌手

@end
