//
//  UIView+RectCorner.m
//  AttorneyOL
//
//  Created by SK on 2017/9/4.
//  Copyright © 2017年 SK. All rights reserved.
//

#import "UIView+RectCorner.h"
#import <objc/runtime.h>

static NSString * const kcornerRadii = @"rectCornerRadii";
static NSString * const krectCorner = @"rectCorner";

@implementation UIView (RectCorner)

- (void)setRectCornerRadii:(CGFloat)rectCornerRadii{
    CGFloat Radii = [objc_getAssociatedObject(self, &kcornerRadii) floatValue];
    if (Radii != rectCornerRadii) {
        [self willChangeValueForKey:kcornerRadii];
        objc_setAssociatedObject(self, &kcornerRadii,
                                 @(rectCornerRadii),
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self didChangeValueForKey:kcornerRadii];
        [self rectCornerWithCornerRadii:rectCornerRadii Corner:self.rectCorner];
    }
}

- (CGFloat)rectCornerRadii{
    if (!objc_getAssociatedObject(self, &kcornerRadii)) {
        [self setRectCornerRadii:5];
    }
    return [objc_getAssociatedObject(self, &kcornerRadii) floatValue];
}

- (void)setRectCorner:(UIRectCorner)rectCorner{
    [self willChangeValueForKey:krectCorner];
    objc_setAssociatedObject(self, &krectCorner,
                             @(rectCorner),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:krectCorner];
    
    [self rectCornerWithCornerRadii:self.rectCornerRadii Corner:rectCorner];
}
- (UIRectCorner)rectCorner{
    return [objc_getAssociatedObject(self, &krectCorner) intValue];
}

- (void)rectCornerWithCornerRadii:(CGFloat )cornerRadii Corner:(UIRectCorner)corner{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   byRoundingCorners:corner
                                                         cornerRadii:CGSizeMake(cornerRadii,
                                                                                cornerRadii)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

@end
