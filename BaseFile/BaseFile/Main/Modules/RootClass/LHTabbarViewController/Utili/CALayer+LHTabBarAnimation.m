//
//  CALayer+LHAnimation.m
//  LHProjectShell
//
//  Created by liuhao on 2018/12/11.
//  Copyright © 2018 liuhao. All rights reserved.
//

#import "CALayer+LHTabBarAnimation.h"

@implementation CALayer (LHTabBarAnimation)
-(void)add_lhTransform_scaleAnimationforKey:(NSString *)key;{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //速度控制函数，控制动画运行的节奏
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.2;       //执行时间
    animation.repeatCount = 1;      //执行次数
    animation.autoreverses = YES;    //完成动画后会回到执行动画之前的状态
    animation.fromValue = [NSNumber numberWithFloat:0.7];   //初始伸缩倍数
    animation.toValue = [NSNumber numberWithFloat:1.3];     //结束伸缩倍数
    [self addAnimation:animation forKey:key];
}
@end
