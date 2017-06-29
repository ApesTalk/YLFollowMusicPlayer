//
//  NSArray+YLBoundsCheck.m
//  YLFollowMusicPlayer
//
//  Created by lumin on 2017/3/3.
//  Copyright © 2017年 YL. All rights reserved.
//

#import "NSArray+YLBoundsCheck.h"

@implementation NSArray (YLBoundsCheck)
- (id)yl_objectAtIndex:(NSUInteger)index
{
    if(index < self.count){
        return self[index];
    }else{
        return nil;
    }
}
@end
