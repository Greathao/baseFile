//
//  LHBaseViewController.h
//  LHProjectShell
//
//  Created by liuhao on 2018/12/7.
//  Copyright © 2018 liuhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHNavgationView.h"
#import "LHBlockAnimationView.h"
#import "LHNetWorkErrorView.h"
#import "HLNetWorkRequest.h"
NS_ASSUME_NONNULL_BEGIN

@interface LHBaseViewController : UIViewController


@property (nonatomic,strong,readonly) LHNavgationView *lh_nav;


/*=================================================================================
 =====================================子类按需调用===================================
 ==================================================================================*/
#pragma mark - navgation设置

/// 设置导航栏title
/// @param title text
-(void)setNavTitle:(NSString*)title;

/// 设置导航栏颜色
/// @param color 颜色
-(void)setNavBackgroundColor:(UIColor*)color;

/// 设置导航栏标题字体大小
/// @param font 字体
-(void)setNavTitleFont:(UIFont*)font;

/// 设置左侧按钮标题
/// @param title text
-(void)setNavLeftItemTitle:(NSString*)title;

/// 设置右边导航标题
/// @param title  text
-(void)setNavRightItemTitle:(NSString*)title;


/// 设置左边标题颜色
/// @param color 颜色
-(void)setNavLeftItemTitleColor:(UIColor*)color;

/// 设置右边标题颜色
/// @param color 颜色
-(void)setNavRightItemTitleColor:(UIColor*)color;


/// 设置左边标题字体大小
/// @param font 字体
-(void)setNavLeftItemTitleFont:(UIFont*)font;


/// 设置右边标题字体大小
/// @param font 字体
-(void)setNavRightItemTitleFont:(UIFont*)font;




/// 设置左按钮图片
/// @param image normal图片
/// @param highImage 高亮图片
-(void)setNavLeftItemImage:(NSString*)image  highImage:(NSString *)highImage;

/// 设置右按钮图片
/// @param image normal图片
/// @param highImage 高亮图片
-(void)setNavRightItemImage:(NSString*)image  highImage:(NSString *)highImage;


/// 向左追加一个按钮
/// @param view view
/// @param clickBack 回调
-(void)setNavAddLeftItemView:(UIView *)view clickCallback:(void(^)(UIView *view))clickBack;


/// 向又追加一个按钮
/// @param view view
/// @param clickBack 回调
-(void)setNavAddRightItemView:(UIView *)view clickCallback:(void(^)(UIView *view))clickBack;


#pragma mark - 加载中/错误
/// 全屏加载中
-(void)startLoading;

/// 取消加载中动画
-(void)stopLoading;

/// 网络错误页面
/// @param callbackBlock 重新加载按钮
-(void)showErrorViewRefreshCallbackBlock:(void (^)(void))callbackBlock;

/// 取消网络错误页面
-(void)dismissErrorView;
 
/*=================================================================================
 =====================================子类按需重写===================================
 ==================================================================================*/
#pragma mark - 导航栏按钮触发事件
/// 最左边按钮触发事件
-(void)leftTouchAction;

/// 最右边按钮触发事件
-(void)rightTouchAction;

#pragma mark - 手势
///子类重写 是否开启侧滑手势 默认开启
- (BOOL)isInteractivePopGestureRecognizer;



@end

NS_ASSUME_NONNULL_END
