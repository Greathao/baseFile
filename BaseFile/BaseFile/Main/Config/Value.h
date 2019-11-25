//
//  Value.h
//  BaseFile
//
//  Created by lilekai on 2017/5/6.
//  Copyright © 2017年 lilekai. All rights reserved.
//

#ifndef Value_h
#define Value_h

/////  状态栏的高度从 0.0 全面屏为44  非全面屏为 20
//#define   SP_STATUES_BAR_FRAME_H              [UIApplication sharedApplication].statusBarFrame.size.height
/////  非全面屏 时候 20+44  全面屏为 44+44
//#define   SP_NAVGATION_BAR_FRAME_H            (SP_STATUES_BAR_FRAME_H+44)
/////  tabbar 高度
//#define   SP_TAB_BAR_FRAME_H                  (SP_STATUES_BAR_FRAME_H==44?83:49)
//

#pragma mark - ******** Device dimensions   ********
#define IS_SIZE_3_5 ([[UIScreen mainScreen] currentMode].size.height == 480||[[UIScreen mainScreen] currentMode].size.height == 960) ? YES:NO

#define SCREEN_BOUNDS                                               [[UIScreen mainScreen] bounds]
#define SCREEN_SIZE                                                 [[UIScreen mainScreen] bounds].size
#define SCREEN_WIDTH                                                [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT                                               [[UIScreen mainScreen] bounds].size.height
#define SYSTEM_VERSION                                              [[[UIDevice currentDevice] systemVersion] floatValue]

//屏幕高度
#define kScreenHeight           [UIScreen mainScreen].bounds.size.height

//屏幕宽度
#define kScreenWidth            [UIScreen mainScreen].bounds.size.width

/**
 *  比例
 */
#define kScrenScale  (kScreenWidth/375.0)


#define iOS10 ([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0)

#define ZERO               0     // x轴 0

#define STATUESBAR_HEIGHT  [UIApplication sharedApplication].statusBarFrame.size.height
#define NAV_HEIGHT         (44 + STATUESBAR_HEIGHT)    // nav高度
#define TABBAR_HEIGHT      ((STATUESBAR_HEIGHT == 44)?83:49)

/// 判断是否是全面屏幕
//根据statusbar
#define SP_IS_FULL_SCREEN                   (STATUESBAR_HEIGHT==44?1:0)

#define SPACE_BOTTOM_OF_THE_SCREEN          (SP_IS_FULL_SCREEN?34:0)


#define BOTTOMVIEW_HEIGHT  50    // 底部view 高度
#define ANIMATETIME        0.5   // 动画时间
#define Iphone5Height      36
#define Iphone6Height      40
#define Iphone6pHeight     50


/**
 *  10号字体
 */
#define TenFontSize [UIFont systemFontOfSize:10]
/**
 *  11号字体
 */
#define ElevenFontSize [UIFont systemFontOfSize:11]
/**
 *  12号字体
 */
#define TwelveFontSize [UIFont systemFontOfSize:12]
/**
 *  13号字体
 */
#define ThirteenFontSize [UIFont systemFontOfSize:13]
/**
 *  14号字体
 */
#define FourteenFontSize [UIFont systemFontOfSize:14]
/**
 *  15号字体
 */
#define FifteenFontSize [UIFont systemFontOfSize:15]
/**
 *  16号字体
 */
#define SixteenFontSize [UIFont systemFontOfSize:16]
/**
 *  17号字体
 */
#define SeventeenFontSize [UIFont systemFontOfSize:17]
/**
 *  18号字体
 */
#define EighteenFontSize [UIFont systemFontOfSize:18]
/**
 *  20号字体
 */
#define TwentyFontSize [UIFont systemFontOfSize:20]


#endif /* Value_h */


