//
//  YLPlayTitleView.h
//  YLFollowMusicPlayer
//
//  Created by TK-001289 on 2017/3/9.
//  Copyright © 2017年 YL. All rights reserved.
//

#import "YLPlayTitleView.h"
#import "YLUIFactory.h"
#import "YLMusic.h"

@implementation YLPlayTitleView

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        _titleLabel = [YLUIFactory labelWithFontSize:15 textColor:[UIColor blackColor] alignment:NSTextAlignmentCenter];
        _titleLabel.frame = CGRectMake(0, 0, frame.size.width, frame.size.height * 2 / 3.0);
        [self addSubview:_titleLabel];
        _subTitleLabel = [YLUIFactory labelWithFontSize:10 textColor:[UIColor blackColor] alignment:NSTextAlignmentCenter];
        _subTitleLabel.frame = CGRectMake(0, frame.size.height * 2 / 3.0, frame.size.width, frame.size.height / 3.0);
        [self addSubview:_subTitleLabel];
    }
    return self;
}

- (void)refreshWithMusic:(YLMusic *)music
{
    _titleLabel.text = music.name;
    _subTitleLabel.text = music.singer;
}

- (void)setTintColor:(UIColor *)tintColor
{
    _titleLabel.textColor = tintColor;
    _subTitleLabel.textColor = tintColor;
}

@end
