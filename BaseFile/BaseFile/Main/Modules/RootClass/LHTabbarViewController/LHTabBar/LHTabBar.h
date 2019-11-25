//
//  LHTabbar.h
//  LHProjectShell
//
//  Created by liuhao on 2018/12/7.
//  Copyright © 2018 liuhao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LHTabBarConfig.h"
#import "LHTabBarItem.h"


NS_ASSUME_NONNULL_BEGIN

#define defColor   [UIColor colorWithRed:102.0f/255.0 green:102.0f/255.0 blue:102.0f/255.0 alpha:1.0]
#define selColor   [UIColor colorWithRed:65.0f/255.0 green:148.0f/255.0 blue:240.f/255.0 alpha:1.0]


typedef NS_ENUM(NSInteger, LHTabBarAnimType) {
    LHTabBarAnimTypeNormal, //无动画
    LHTabBarAnimTypeJitter, //抖动动画
};


typedef void(^LHCustomBtnAcionBlock)(UIButton*btn,NSInteger index);



@class LHTabBar;

@protocol LHTabBarDelegate <NSObject>

- (void)tabBar:(LHTabBar *)tabBar didSelectIndex:(NSInteger)selectIndex;

@end

@interface LHTabBar : UITabBar
//背景颜色（默认白）
@property (nonatomic,strong) UIColor *bgColor;
//背景图片（默认无）
@property (nonatomic,strong) UIImage *bgImg;
//阴影颜色默认（默认无）
@property (nonatomic,strong) UIColor * shadowColor;
//文字正常颜色
@property (nonatomic,strong) UIColor * titleNormalColor;
//文字选中颜色
@property (nonatomic,strong) UIColor * titleSelectColor;
//是否显示tabBar顶部线条颜色
@property (nonatomic,assign) BOOL isClearTabBarTopLine;
//tabBar顶部线条颜色
@property (nonatomic,strong) UIColor *tabBarTopLineColor;
//点击动画效果
@property (nonatomic,assign) LHTabBarAnimType  animType;

@property (nonatomic,strong) NSArray<LHTabBarModel *>* subItems;
@property (nonatomic,weak  ) id<LHTabBarDelegate> myDelegate;

/** selectedIndex (默认为0) */
@property (nonatomic,assign) NSInteger selectedIndex;

/**
 * 此属性为是否要关闭选中的效果
 */
 @property (nonatomic,assign) BOOL isDeselect;


/**
 初始化方法
 
 @param frame frame
 @param subItems 数据源里边
 @param delegate  每个item的点击事件
 @return LHTabBar
 */
-(instancetype)initWithFrame:(CGRect)frame tabBarItemsModel:(NSArray<LHTabBarModel*>*)subItems delegate:(id<LHTabBarDelegate>)delegate;


/**
 自定义按钮插入到哪个位置
 
 @param btn UIButton
 @param index 插入到哪个位置
 @param btnClickBlock 返回button和下标
 */
- (void)addCustomBtn:(UIButton *)btn AtIndex:(NSInteger)index BtnClickBlock:(LHCustomBtnAcionBlock)btnClickBlock;



@end

NS_ASSUME_NONNULL_END
