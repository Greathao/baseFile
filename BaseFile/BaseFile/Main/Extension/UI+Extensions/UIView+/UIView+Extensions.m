//
//  UIView+Extensions.m
//  iCampsite
//
//  Created by 海狸先生 on 16/4/14.
//  Copyright © 2016年 海狸先生. All rights reserved.
//

#import "UIView+Extensions.h"
#import <objc/runtime.h>

static char kActionHandlerTapBlockKey;
static char kActionHandlerTapGestureKey;
static char kActionHandlerLongPressBlockKey;
static char kActionHandlerLongPressGestureKey;
#pragma mark - UIView
@implementation UIView (Extensions)

- (void)setCornerRadius:(CGFloat)radius
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius  = radius;
}

- (void)setBorder:(UIColor *)color borderWidth:(CGFloat)borderWidth
{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = borderWidth;
}

- (void)setShadowRadius:(CGFloat)radius{
    [self setShadowLayer:[UIColor blackColor] shadowOffset:CGSizeMake(0, 3) shadowOpacity:0.4 isShadow:YES radius:radius];
}

- (void)setShadowRadius:(CGFloat)radius shadowColor:(UIColor *)shadowColor{
    [self setShadowLayer:shadowColor shadowOffset:CGSizeMake(0, 3) shadowOpacity:0.4 isShadow:YES radius:radius];
}

- (void)setShadowRadius:(CGFloat)radius withShadow:(BOOL)shadow withOpacity:(CGFloat)opacity {
    [self setShadowLayer:[UIColor blackColor] shadowOffset:CGSizeMake(0, 3) shadowOpacity:opacity isShadow:shadow radius:radius];
}
- (void)setShadowRadius:(CGFloat)radius shadowOffset:(CGSize)shadowOffset shadowColor:(UIColor *)shadowColor;
{
    [self setShadowLayer:shadowColor shadowOffset:shadowOffset shadowOpacity:0.4 isShadow:YES radius:radius];

}



- (void)setShadowLayer:(UIColor *)color shadowOffset:(CGSize)shadowOffset shadowOpacity:(CGFloat)shadowOpacity isShadow:(BOOL)isShadow radius:(CGFloat)radius{
    self.layer.cornerRadius = radius;
    if (shadow) {
        self.layer.shadowColor = color.CGColor;
        self.layer.shadowOpacity = shadowOpacity;
        self.layer.shadowOffset = shadowOffset;
        self.layer.shadowRadius = 4;
        self.layer.shouldRasterize = NO;
        self.layer.shadowPath = [[UIBezierPath bezierPathWithRoundedRect:[self bounds] cornerRadius:radius] CGPath];
    }
    self.layer.masksToBounds = !shadow;
}

 



+ (id)viewFromXib{
    Class viewClass = [self class];
    NSString *viewClassName = NSStringFromClass(viewClass);
    
    NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:viewClassName owner:nil options:nil];
    
    for (id nibItem in nibArray) {
        if ([nibItem isMemberOfClass:viewClass]) {
            return nibItem;
        }
    }
    
    return nil;
}

+ (id)viewWithXibString:(NSString*)str
{
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:str owner:self options:nil];
    return [array lastObject];
}



- (void)addHeight:(float)value
{
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height+value);
}

- (void)addWidth:(float)value
{
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width+value, self.frame.size.height);
}

- (void)setFrameX:(float)x{
    self.frame=CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}
- (void)setFrameY:(float)y
{
    self.frame=CGRectMake(self.frame.origin.x,y, self.frame.size.width, self.frame.size.height);
}

- (void)setFrameW:(float)w
{
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, w, self.frame.size.height);
}
- (void)setFrameH:(float)h
{
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, h);
}

- (void)setFrameSize:(CGSize)size
{
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
}

- (void)setFrameOrigin:(CGPoint)point
{
    self.frame=CGRectMake(point.x, point.y, self.frame.size.width, self.frame.size.height);
}

// Setters
-(void)setX:(CGFloat)x{
    CGRect r        = self.frame;
    r.origin.x      = x;
    self.frame      = r;
}

-(void)setY:(CGFloat)y{
    CGRect r        = self.frame;
    r.origin.y      = y;
    self.frame      = r;
}

-(void)setWidth:(CGFloat)width{
    CGRect r        = self.frame;
    r.size.width    = width;
    self.frame      = r;
}

-(void)setHeight:(CGFloat)height{
    CGRect r        = self.frame;
    r.size.height   = height;
    self.frame      = r;
}

-(void)setOrigin:(CGPoint)origin{
    self.x          = origin.x;
    self.y          = origin.y;
}

-(void)setSize:(CGSize)size{
    self.width      = size.width;
    self.height     = size.height;
}

-(void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

-(void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

-(void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

-(void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

// Getters
-(CGFloat)x{
    return self.frame.origin.x;
}

-(CGFloat)y{
    return self.frame.origin.y;
}

-(CGFloat)width{
    return self.frame.size.width;
}

-(CGFloat)height{
    return self.frame.size.height;
}

-(CGPoint)origin{
    return CGPointMake(self.x, self.y);
}

-(CGSize)size{
    return CGSizeMake(self.width, self.height);
}

-(CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

-(CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

-(CGFloat)centerX {
    return self.center.x;
}

-(CGFloat)centerY {
    return self.center.y;
}

-(UIView *)lastSubviewOnX{
    if(self.subviews.count > 0){
        UIView *outView = self.subviews[0];
        for(UIView *v in self.subviews)
            if(v.x > outView.x)
                outView = v;
        return outView;
    }
    return nil;
}

-(UIView *)lastSubviewOnY{
    if(self.subviews.count > 0){
        UIView *outView = self.subviews[0];
        for(UIView *v in self.subviews)
            if(v.y > outView.y)
                outView = v;
        return outView;
    }
    return nil;
}

//振动动画－类心跳动画
- (void)showShakeAnimation{
    
    [UIView animateWithDuration:0.1 animations:^{
        self.transform=CGAffineTransformMakeScale(1.01f, 1.01f);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.transform=CGAffineTransformMakeScale(0.99f, 0.99f);
        } completion:^(BOOL finished) {
            self.transform=CGAffineTransformMakeScale(1.0f, 1.0f);
        }];
    }];
}

//振动动画－类app删除动画
- (void)shakeAnimation:(BOOL)shake
{
    if(shake) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.fromValue = [NSNumber numberWithFloat:-0.05];
        animation.toValue = [NSNumber numberWithFloat:+0.05];
        animation.duration = 0.1;
        animation.autoreverses = YES; //是否重复
        animation.repeatCount = MAXFLOAT;
        [self.layer addAnimation:animation forKey:@"shake"];
    }
    else {
        [self.layer removeAnimationForKey:@"shake"];
    }
}

// 左右晃动
- (void)shakeAction
{
    // 晃动次数
    static int numberOfShakes = 4;
    // 晃动幅度（相对于总宽度）
    static float vigourOfShake = 0.04f;
    // 晃动延续时常（秒）
    static float durationOfShake = 0.5f;
    
    CAKeyframeAnimation *shakeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    // 方法一：绘制路径
    CGRect frame = self.frame;
    // 创建路径
    CGMutablePathRef shakePath = CGPathCreateMutable();
    // 起始点
    CGPathMoveToPoint(shakePath, NULL, CGRectGetMidX(frame), CGRectGetMidY(frame));
    for (int index = 0; index < numberOfShakes; index++)
    {
        // 添加晃动路径 幅度由大变小
        CGPathAddLineToPoint(shakePath, NULL, CGRectGetMidX(frame) - frame.size.width * vigourOfShake*(1-(float)index/numberOfShakes),CGRectGetMidY(frame));
        CGPathAddLineToPoint(shakePath, NULL,  CGRectGetMidX(frame) + frame.size.width * vigourOfShake*(1-(float)index/numberOfShakes),CGRectGetMidY(frame));
    }
    // 闭合
    CGPathCloseSubpath(shakePath);
    shakeAnimation.path = shakePath;
    shakeAnimation.duration = durationOfShake;
    // 释放
    CFRelease(shakePath);
    
    [self.layer addAnimation:shakeAnimation forKey:kCATransition];
}

// 上下晃动
- (void)shakeAction_top_bottom
{
    // 晃动次数
    static int numberOfShakes = 4;
    // 晃动幅度（相对于总宽度）
    static float vigourOfShake = 0.2f;
    // 晃动延续时常（秒）
    static float durationOfShake = 0.5f;
    
    CAKeyframeAnimation *shakeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    // 方法一：绘制路径
    CGRect frame = self.frame;
    // 创建路径
    CGMutablePathRef shakePath = CGPathCreateMutable();
    // 起始点
    CGPathMoveToPoint(shakePath, NULL, CGRectGetMidX(frame), CGRectGetMidY(frame));
    for (int index = 0; index < numberOfShakes; index++){
        // 添加晃动路径 幅度由大变小
        CGPathAddLineToPoint(shakePath, NULL, CGRectGetMidX(frame), CGRectGetMidY(frame)- frame.size.height * vigourOfShake*(1-(float)index/numberOfShakes));
        CGPathAddLineToPoint(shakePath, NULL,  CGRectGetMidX(frame), CGRectGetMidY(frame)+ frame.size.height * vigourOfShake*(1-(float)index/numberOfShakes));
    }
    // 闭合
    CGPathCloseSubpath(shakePath);
    shakeAnimation.path = shakePath;
    shakeAnimation.duration = durationOfShake;
    // 释放
    CFRelease(shakePath);
    
    [self.layer addAnimation:shakeAnimation forKey:kCATransition];
}

//消失动画
- (void)dissAnimation{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark -添加手势
- (void)addTapActionWithBlock:(GestureActionBlock)block
{
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kActionHandlerTapGestureKey);
    if (!gesture)
    {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &kActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}
- (void)handleActionForTapGesture:(UITapGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        GestureActionBlock block = objc_getAssociatedObject(self, &kActionHandlerTapBlockKey);
        if (block)
        {
            block(gesture);
        }
    }
}
- (void)addLongPressActionWithBlock:(GestureActionBlock)block
{
    UILongPressGestureRecognizer *gesture = objc_getAssociatedObject(self, &kActionHandlerLongPressGestureKey);
    if (!gesture)
    {
        gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForLongPressGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kActionHandlerLongPressGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &kActionHandlerLongPressBlockKey, block, OBJC_ASSOCIATION_COPY);
}
- (void)handleActionForLongPressGesture:(UITapGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        GestureActionBlock block = objc_getAssociatedObject(self, &kActionHandlerLongPressBlockKey);
        if (block){
            block(gesture);
        }
    }
}

// 虚线
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

+ (UIViewController *)VCWithName:(NSString *)name identifier:(NSString *)identifier {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:name bundle:nil];
    return [sb instantiateViewControllerWithIdentifier:identifier];
}

- (void)addEmitterWithImgName:(NSString *)imageName{
    
    CAEmitterLayer *snowEmitter = [CAEmitterLayer layer];
    snowEmitter.emitterPosition = CGPointMake(self.bounds.size.width / 2.0, -30);
    snowEmitter.emitterSize  = CGSizeMake(self.bounds.size.width * 2.0, 0.0);
    snowEmitter.emitterShape = kCAEmitterLayerLine;
    snowEmitter.emitterMode  = kCAEmitterLayerOutline;
    
    CAEmitterCell *snowflake = [CAEmitterCell emitterCell];
    
    snowflake.birthRate	= 1.0;
    snowflake.lifetime	= 120.0;
    snowflake.velocity	= -10;
    snowflake.velocityRange = 10;
    snowflake.yAcceleration = 2;
    snowflake.emissionRange = 0.5 * M_PI;
    snowflake.spinRange = 0.25 * M_PI;
    snowflake.contents  = (id) [[UIImage imageNamed:imageName] CGImage];
    snowflake.color	= [[UIColor colorWithRed:0.600 green:0.658 blue:0.743 alpha:1.000] CGColor];
    
    snowEmitter.shadowOpacity = 1.0;
    snowEmitter.shadowRadius  = 0.0;
    snowEmitter.shadowOffset  = CGSizeMake(0.0, 1.0);
    snowEmitter.shadowColor   = [[UIColor whiteColor] CGColor];
    snowEmitter.emitterCells = [NSArray arrayWithObject:snowflake];
    [self.layer insertSublayer:snowEmitter atIndex:0];
}

@end
