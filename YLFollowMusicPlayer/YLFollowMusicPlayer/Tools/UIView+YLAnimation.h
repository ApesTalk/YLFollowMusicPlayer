//
//  UIView+YLAnimation.h
//  YLFollowMusicPlayer
//
//  Created by TK-001289 on 2017/3/9.
//  Copyright © 2017年 YL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YLAnimation)
- (void)yl_setAnchorPoint:(CGPoint)point;
- (void)yl_rotateWithAngle:(CGFloat)angle anchorPoint:(CGPoint)point;
- (void)yl_start360DegreeRotateWithDuration:(CFTimeInterval)duration;
- (void)yl_stop360DegreeRotate;

@end

/*
 说明：
 1.当UIView发生变换（transformed）后，不要使用frame属性，因为它往往不能代表视图的正确位置，使用bounds和center属性代替。
 见UIView(UIViewGeometry)中的说明
 2.anchorPoint在视图左上角为(0,0),在视图右下角为(1,1),默认(0.5,0.5)。苹果文档中注释是错误的（normalized layer coordinates - '(0, 0)' is the bottom left corner of the bounds rect）。
 3.如果更改了一个图层的anchorPoint，那么这个图层会发生位移。[iOS围绕某点缩放或旋转的AnchorPoint的设定](http://www.chentoo.com/?p=46 )
 4.point、anchorPoint和frame三者的关系：
 position.x = frame.origin.x + anchorPoint.x * bounds.size.width；
 position.y = frame.origin.y + anchorPoint.y * bounds.size.height
 [这将是你最后一次纠结position与anchorPoint！](http://kittenyang.com/anchorpoint/ )
 5.修改position和anchorPoint会影响frame属性。
 */
