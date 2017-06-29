//
//  UIImage+Draw.h
//  YouLan_V2.1
//
//  Created by lumin on 15/9/22.
//  Copyright © 2015年 daile. All rights reserved.
//  绘制UIImage的扩展

#import <UIKit/UIKit.h>

@interface UIImage (Draw)
/**
 *  创建指定背景色的UIImage对象
 *
 *  @param color   背景色
 *  @param newRect 尺寸
 *
 *  @return UIImage对象
 */
+(UIImage*)createImageWithColor:(UIColor*) color frame:(CGRect)newRect;


@end
