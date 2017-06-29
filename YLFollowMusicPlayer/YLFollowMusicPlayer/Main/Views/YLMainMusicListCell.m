//
//  YLMainMusicListCell.h
//  YLFollowMusicPlayer
//
//  Created by lumin on 2017/3/2.
//  Copyright © 2017年 YL. All rights reserved.
//

#import "YLMainMusicListCell.h"
#import "YLMusic.h"
#import "YLUIFactory.h"
#import "UIImageView+WebCache.h"

static CGFloat const kPosterSize = 55.f;
static CGFloat const kIndicatorSize = 20.f;

@implementation YLMainMusicListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        _posterView = [[UIImageView alloc]init];
        [self.contentView addSubview:_posterView];
        _nameLabel = [YLUIFactory labelWithFontSize:16 textColor:[UIColor blackColor]];
        [self.contentView addSubview:_nameLabel];
        _signerLabel = [YLUIFactory labelWithFontSize:10 textColor:[UIColor lightGrayColor]];
        [self.contentView addSubview:_signerLabel];
        
        UIView *contentView = self.contentView;
        [_posterView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@(kPosterSize)).priority(kYLPriorityNearRequired);
            make.top.equalTo(contentView).offset(10);
            make.left.equalTo(contentView).offset(10).priority(kYLPriorityNearRequired);
            make.bottom.equalTo(contentView).offset(-10);
        }];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_posterView).offset(5);
            make.left.equalTo(_posterView.mas_right).offset(10).priority(kYLPriorityNearRequired);
            make.right.equalTo(contentView).offset(-10).priority(kYLPriorityNearRequired);
        }];
        [_signerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_nameLabel.mas_bottom);
            make.bottom.equalTo(_posterView).offset(-5);
            make.left.equalTo(_posterView.mas_right).offset(10).priority(kYLPriorityNearRequired);
            make.right.equalTo(contentView).offset(-10).priority(kYLPriorityNearRequired);
        }];
    }
    return self;
}

- (void)refreshWithObject:(NSObject *)obj
{
    if([obj isKindOfClass:[YLMusic class]]){
        YLMusic *music = (YLMusic *)obj;
        NSString *path = [[NSBundle mainBundle]pathForResource:@"musicbg1" ofType:@"jpeg"];
        UIImage *holder = [UIImage imageWithContentsOfFile:path];
        [_posterView sd_setImageWithURL:[NSURL URLWithString:music.poster] placeholderImage:holder];
        _nameLabel.text = music.name;
        _signerLabel.text = music.singer;
    }
}

@end
