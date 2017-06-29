//
//  YLSlider.m
//  YLSlider
//
//  Created by lumin on 2017/3/11.
//  Copyright © 2017年 YL. All rights reserved.
//

#import "YLSlider.h"

@implementation YLSlider

- (CGRect)trackRectForBounds:(CGRect)bounds
{
    return CGRectMake(0, (bounds.size.height - 2) * 0.5, bounds.size.width, 2);
}

- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value
{
    CGRect frame = [super thumbRectForBounds:bounds trackRect:rect value:value];
    CGFloat progress = value / (self.maximumValue - self.minimumValue);
    CGFloat pastX = progress * self.frame.size.width;
    frame.origin.x = pastX - frame.size.width * 0.5;
    return frame;
}

@end
