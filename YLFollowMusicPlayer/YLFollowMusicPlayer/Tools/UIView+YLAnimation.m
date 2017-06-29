//
//  UIView+YLAnimation.h
//  YLFollowMusicPlayer
//
//  Created by TK-001289 on 2017/3/9.
//  Copyright © 2017年 YL. All rights reserved.
//

#import "UIView+YLAnimation.h"

@implementation UIView (YLAnimation)
- (void)yl_setAnchorPoint:(CGPoint)point
{
    CGPoint oldOrigin = self.frame.origin;
    self.layer.anchorPoint = point;
    CGPoint newOrigin = self.frame.origin;
    CGPoint transition;
    transition.x = newOrigin.x - oldOrigin.x;
    transition.y = newOrigin.y - oldOrigin.y;
    self.center = CGPointMake (self.center.x - transition.x, self.center.y - transition.y);
}

- (void)yl_rotateWithAngle:(CGFloat)angle anchorPoint:(CGPoint)point
{
    [self yl_setAnchorPoint:point];
    self.transform = CGAffineTransformMakeRotation(angle);
}

//        rotationAnimation.cumulative = YES;//旋转累加角度
//        rotationAnimation.removedOnCompletion = NO;
//        rotationAnimation.fillMode = kCAFillModeForwards;

- (void)yl_start360DegreeRotateWithDuration:(CFTimeInterval)duration
{
    //http://www.jianshu.com/p/3ca5f441876e
    CAAnimation *rotationAnimation = [self.layer animationForKey:@"rotationAnimation"];
    if(!rotationAnimation){
        //创建新的动画
        CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.duration = duration;
        rotationAnimation.repeatCount = INFINITY;
        rotationAnimation.toValue = @(M_PI * 2);
        [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        
//        [self yl_stop360DegreeRotate];
    }else{
        
    }
    //继续之前的动画
    CFTimeInterval pausedTime = [self.layer timeOffset];
    self.layer.speed = 1.0;
    self.layer.timeOffset = 0.0;
    self.layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.layer.beginTime = timeSincePause;
}

- (void)yl_stop360DegreeRotate
{
    //暂停动画
    CAAnimation *rotationAnimation = [self.layer animationForKey:@"rotationAnimation"];
    if(rotationAnimation){
        CFTimeInterval currTimeoffset = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
        self.layer.speed = 0.0;
        self.layer.timeOffset = currTimeoffset;
    }
}

@end
