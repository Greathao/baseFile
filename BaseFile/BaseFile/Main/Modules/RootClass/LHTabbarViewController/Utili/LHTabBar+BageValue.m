//
//  LHTabBar+BageValue.m
//  LHProjectShell
//
//  Created by liuhao on 2018/12/11.
//  Copyright © 2018 liuhao. All rights reserved.
//

#import "LHTabBar+BageValue.h"

@implementation LHTabBar (BageValue)

- (void)showPointBadgeAtIndex:(NSInteger)index{
    LHTabBarItem *tabBarButton = [self getTabBarButtonAtIndex:index];
    tabBarButton.badgeValue.hidden = NO;
    tabBarButton.badgeValue.type = LHBadgeValueTypePoint;
}

- (void)showNewBadgeAtIndex:(NSInteger)index {
    LHTabBarItem *tabBarButton = [self getTabBarButtonAtIndex:index];
    tabBarButton.badgeValue.hidden = NO;
    tabBarButton.badgeValue.badgeL.text = @"new";
    tabBarButton.badgeValue.type = LHBadgeValueTypeNew;
}

- (void)showNumberBadgeValue:(NSString *)badgeValue AtIndex:(NSInteger)index {
    LHTabBarItem *tabBarButton = [self getTabBarButtonAtIndex:index];
    tabBarButton.badgeValue.hidden = NO;
    tabBarButton.badgeValue.badgeL.text = badgeValue;
    tabBarButton.badgeValue.type = LHBadgeValueTypeNumber;
}

- (void)hideBadgeAtIndex:(NSInteger)index {
    [self getTabBarButtonAtIndex:index].badgeValue.hidden = YES;
}
- (LHTabBarItem *)getTabBarButtonAtIndex:(NSInteger)index {
    NSArray *subViews =self.subviews;
    int i = 0;
    for (id view in subViews) {
        if ([view isKindOfClass:[LHTabBarItem class]]) {
            if (i==index) {
                LHTabBarItem *tabBarBtn = (LHTabBarItem *)view;
                return tabBarBtn;
            }
 
            i++;
        }
       
    }
 
    return nil;
}

 
@end
