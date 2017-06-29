//
//  YLBaseView.h
//  YLFollowMusicPlayer
//
//  Created by lumin on 2017/3/2.
//  Copyright © 2017年 YL. All rights reserved.
//

#import "YLBaseView.h"

@implementation YLBaseView
- (instancetype)init
{
    if(self = [super init]){
        self.exclusiveTouch = YES;
    }
    return self;
}

@end
