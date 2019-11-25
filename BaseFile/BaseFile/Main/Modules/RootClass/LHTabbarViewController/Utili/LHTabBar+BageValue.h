//
//  LHTabBar+BageValue.h
//  LHProjectShell
//
//  Created by liuhao on 2018/12/11.
//  Copyright © 2018 liuhao. All rights reserved.
//

#import "LHTabBar.h"


NS_ASSUME_NONNULL_BEGIN

@interface LHTabBar (BageValue)
/**
 显示圆点badgevalue   
 @param index 显示的下标
 */
- (void)showPointBadgeAtIndex:(NSInteger)index;

/**
 显示newBadgeValue
 @param index 下标
 */
- (void)showNewBadgeAtIndex:(NSInteger)index;

/**
 显示带数值的下标
 @param badgeValue 数值
 @param index 下标
 */
- (void)showNumberBadgeValue:(NSString *)badgeValue AtIndex:(NSInteger)index;

/**
 隐藏下标的badgeValue
 
 @param index 下标
 */
- (void)hideBadgeAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
