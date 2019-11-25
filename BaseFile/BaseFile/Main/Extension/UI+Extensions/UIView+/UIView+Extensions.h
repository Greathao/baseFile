//
//  UIView+Extensions.h
//  iCampsite
//
//  Created by 海狸先生 on 16/4/14.
//  Copyright © 2016年 海狸先生. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^GestureActionBlock)(UIGestureRecognizer *gestureRecoginzer);

#pragma mark - UIView
@interface UIView (Extensions)

/**
 *  设置圆角
 *
 */
- (void)setCornerRadius:(CGFloat)radius;


/**
 *  设置边框
 *
 *  @param color       边框颜色
 *  @param borderWidth 边框宽度
 */
- (void)setBorder:(UIColor *)color borderWidth:(CGFloat)borderWidth;

/**
 *  设置阴影
 *
 */
- (void)setShadowRadius:(CGFloat)radius;

- (void)setShadowRadius:(CGFloat)radius shadowColor:(UIColor *)shadowColor;

- (void)setShadowRadius:(CGFloat)radius withShadow:(BOOL)shadow withOpacity:(CGFloat)opacity;

/**
 * LH修改 2018年06月08日16:44:44
 * 对外开方 阴影方向
 */

- (void)setShadowRadius:(CGFloat)radius shadowOffset:(CGSize)shadowOffset shadowColor:(UIColor *)shadowColor;

 


/**
 *  通过xib名字初始化自定义view
 *
 */
+ (id)viewWithXibString:(NSString*)str;

+ (id)viewFromXib;

//UIView frame 设置
-(void)addWidth:(float)value;

-(void)addHeight:(float)value;

-(void)setFrameX:(float)x;

-(void)setFrameY:(float)y;

-(void)setFrameW:(float)w;

-(void)setFrameH:(float)h;

-(void)setFrameOrigin:(CGPoint)point;

-(void)setFrameSize:(CGSize)size;

/** View's X Position */
@property (nonatomic, assign) CGFloat   x;

/** View's Y Position */
@property (nonatomic, assign) CGFloat   y;

/** View's width */
@property (nonatomic, assign) CGFloat   width;

/** View's height */
@property (nonatomic, assign) CGFloat   height;

/** View's origin - Sets X and Y Positions */
@property (nonatomic, assign) CGPoint   origin;

/** View's size - Sets Width and Height */
@property (nonatomic, assign) CGSize    size;

/** Y vale representing the bottom of the view **/
@property (nonatomic, assign) CGFloat   bottom;

/** X Value representing the right side of the view **/
@property (nonatomic, assign) CGFloat   right;

/** X value of the object's center **/
@property (nonatomic, assign) CGFloat   centerX;

/** Y value of the object's center **/
@property (nonatomic, assign) CGFloat   centerY;

/** Returns the Subview with the heighest X value **/
@property (nonatomic, strong, readonly) UIView *lastSubviewOnX;

/** Returns the Subview with the heighest Y value **/
@property (nonatomic, strong, readonly) UIView *lastSubviewOnY;

//设置图层抖动

/**
 视图是否晃动

 @param shake YES 开始晃动 NO停止晃动
 */
- (void)shakeAnimation:(BOOL)shake;


/**
 类似心脏跳动 跳一次
 */
- (void)showShakeAnimation;


/**
 左右晃动
 */
- (void)shakeAction;

// 上下晃动
- (void)shakeAction_top_bottom;

/**
 视图消失
 */
- (void)dissAnimation;


/**
 *  添加手势
 *
 */
- (void)addTapActionWithBlock:(GestureActionBlock)block;

- (void)addLongPressActionWithBlock:(GestureActionBlock)block;

/**
 *  虚线
 *
 *  @param lineView    虚线的view
 *  @param lineLength  线宽
 *  @param lineSpacing 线间隔
 *  @param lineColor   线颜色
 */
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;

/**
 *  获取storyboard上的VC
 *
 *  @param name       storyboard
 *  @param identifier identifier
 *
 *  @return VC
 */
+ (UIViewController *)VCWithName:(NSString *)name identifier:(NSString *)identifier;

/**
 *  加类似下雪的动画
 *
 *  @param imageName 图片名字
 */
- (void)addEmitterWithImgName:(NSString *)imageName;

@end
