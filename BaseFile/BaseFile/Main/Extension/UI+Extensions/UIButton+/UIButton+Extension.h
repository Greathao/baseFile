//
//  UIButton+Extension.h
//  NaiQiao
//
//  Created by liuhao on 2016/11/17.
//
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)

/**
 创建按钮 没选中文字 没选中颜色  选中文字 选中颜色 字体为14

 @param normalTitle 没选中文字
 @param normalTitleColor 没选中颜色
 @param selTitle 选中文字
 @param selTitleColor 选中颜色
 @return UIButton
 */
+ (instancetype)buttonWithNormalTitle:(NSString *)normalTitle normalTitleColor:(UIColor *)normalTitleColor selTitle:(NSString *)selTitle selTitleColor:(UIColor *)selTitleColor target:(id)target action:(SEL)action;

/**
 *  创建按钮有文字,有颜色,有字体,有图片,没有有背景
 *
 *  @param title         标题
 *  @param titleColor    字体颜色
 *  @param font          字号
 *  @param imageName     图像
 *
 *  @return UIButton
 */
+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font imageName:(NSString *)imageName target:(id)target action:(SEL)action;

/**
 *  创建按钮有文字,有颜色,有字体,有图片,有背景
 *
 *  @param title         标题
 *  @param titleColor    字体颜色
 *  @param font          字号
 *  @param imageName     图像
 *  @param backImageName 背景图像
 *
 *  @return UIButton
 */
+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font imageName:(NSString *)imageName target:(id)target action:(SEL)action backImageName:(NSString *)backImageName;



/**
 创建有文字 有文字颜色 有字体

 @param title 标题
 @param titleColor 标题颜色
 @param font 字体
 @return UIButton
 */
+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font target:(id)target action:(SEL)action;

/**
 *  创建按钮有文字,有颜色，有字体，没有图片，有背景
 *
 *  @param title         标题
 *  @param titleColor    标题颜色
 *  @param backImageName 背景图像名称
 *
 *  @return UIButton
 */
+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font target:(id)target action:(SEL)action backImageName:(NSString *)backImageName;
@end
