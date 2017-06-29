//
//  NSArray+YLBoundsCheck.h
//  YLFollowMusicPlayer
//
//  Created by lumin on 2017/3/3.
//  Copyright © 2017年 YL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (YLBoundsCheck)
/**对数组边界进行检查，避免数组越界*/
- (id)yl_objectAtIndex:(NSUInteger)index;
@end
