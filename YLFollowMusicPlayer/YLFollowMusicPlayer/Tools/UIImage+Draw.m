//
//  UIImage+Draw.m
//  YouLan_V2.1
//
//  Created by lumin on 15/9/22.
//  Copyright © 2015年 daile. All rights reserved.
//

#import "UIImage+Draw.h"

@implementation UIImage (Draw)

+(UIImage*)createImageWithColor:(UIColor*) color frame:(CGRect)newRect
{
    CGRect rect = CGRectMake(0.0f, 0.0f, newRect.size.width, newRect.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage*theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
