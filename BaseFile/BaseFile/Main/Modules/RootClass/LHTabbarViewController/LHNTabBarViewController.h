//
//  LHTabBarViewController.h
//  JokeProject
//
//  Created by liuhao on 16/12/17.
//  Copyright © 2016年 liuhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHTabBarConfig.h"
#import "LHTabBar.h"
 
/// 再次点击   通知 发送 最上层显示的vc
extern NSString * const ONCEAGAIN_TABBARSELECT_NOTIFICATION;


@interface LHNTabBarViewController : UITabBarController

@property (nonatomic,strong) LHTabBar *lh_tabbar;
/**
 * 1、此属性判断是否是tabbar管理的带navgationVC的VC(默认是)
 * 2、(默认删除tabbar的Nav)
 */
@property (nonatomic,assign) BOOL  isNoNavRootVC;

/**
 * 1、 此属性是在默认情况下 判断是否给tabbar管理的 navgationVC的RootVC 添加左按钮返回（默认无返回）
 * 2、 当此类被push 或者 present 出来时候需要开启 返回 如果是app整个根视图无需更改
 */
@property (nonatomic,assign) BOOL  isOpenLeftButton;
 

/**
 * 用此方法初始化需要严格按照domePlist内容编写。
 */
-(instancetype)initWithConfigPlistName:(NSString*)plistName;

-(void)isHiddenTabbar:(BOOL)ishidden;

-(void)setSelectedIndex:(NSUInteger)selectedIndex;


@end
