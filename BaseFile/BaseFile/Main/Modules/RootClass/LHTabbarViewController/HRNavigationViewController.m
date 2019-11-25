//
//  HRNavigationViewController.m
//  HAIERWHM
//
//  Created by liuhao on 17/4/20.
//  Copyright © 2017年 HAIER. All rights reserved.
//

#import "HRNavigationViewController.h"
 
@interface HRNavigationViewController ()

@end

@implementation HRNavigationViewController
-(void)isHiddenTabbarVC:(BOOL)isHidden;{
//    LHTabBarViewController * tabar =(LHTabBarViewController*) self.tabBarController;
//
//    [tabar isHiddenTabbar:isHidden];

}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
  
    viewController.hidesBottomBarWhenPushed = YES;
   
    [super pushViewController:viewController animated:animated];
    if (self.childViewControllers.count==1) {
        viewController.hidesBottomBarWhenPushed = NO;

    }
}

//-(UIViewController *)popViewControllerAnimated:(BOOL)animated{
//
//    if (self.childViewControllers.count==2) {
//         [self isHiddenTabbarVC:NO];
//    }
//    return  [super popViewControllerAnimated:animated];
//
//}

//- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
//
//
////
////    if (self.childViewControllers.count==2) {
////        [self isHiddenTabbarVC:NO];
////    }
////    return [super popToViewController:viewController animated:animated];
//
//
//
//    if ([viewController isKindOfClass:[HRWashShieldHomeVC class]] || [viewController isKindOfClass:[HRPersonalViewController class]]) {
//        [self isHiddenTabbarVC:NO];
//    }
//    return [super popToViewController:viewController animated:animated];
//
//}


//-(NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated{
//
//    [self isHiddenTabbarVC:NO];
//
//    return [super popToRootViewControllerAnimated:animated];
//}
@end
