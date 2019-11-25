//
//  LHNavgationView.h
//  LHProjectShell
//
//  Created by liuhao on 2018/12/27.
//  Copyright © 2018 liuhao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef  void(^LHNavgationLeftActionBlock) (UIView*view);
typedef  void(^LHNavgationRightActionBlock)(UIView*view);

@interface LHNavgationView : UIView

///设置背景图片
@property (nonatomic,copy)   NSString * backgroundImageName;
///设置背景颜色默认白色
@property (nonatomic,strong) UIColor *backgroundColor;
///设置是否显示1像素的线
@property (nonatomic,assign) BOOL isHideButtomLine;
///设置导航栏下面的线颜色
@property (nonatomic,strong) UIColor  * buttomLineColor;
///设置title
@property (nonatomic,copy)   NSString * titleName;

///设置titleFont
@property (nonatomic,strong) UIFont * titleFont;
///标题颜色
@property (nonatomic,strong) UIColor  * titleColor;

/**
 * 左边按钮对象
 */
@property (nonatomic,strong,readonly) NSArray <UIView*>*leftItems;
/**
 * 右边按钮对象
 */
@property (nonatomic,strong,readonly) NSArray <UIView*>*rightItems;


+(instancetype)viewAddTo:(UIView*)view;


-(void)addLeftCustomView:(UIView*)view
             selectBlock:(LHNavgationLeftActionBlock)leftActionBlock;

-(void)addRightCustomView:(UIView*)view
              selectBlock:(LHNavgationRightActionBlock)rightActionBlock;

-(void)addTitleView:(UIView*)view;

@end

NS_ASSUME_NONNULL_END
