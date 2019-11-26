//
//  UIView+Extensions.h
//  iCampsite
//
//  Created by liuhao on 16/4/14.
//  Copyright © 2016年 liuhao. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIDevice (UIDevice_Extensions) 


/**
 *  拨打电话
 *
 *  @param phoneNum 电话号码
 *  @param view     self
 */
+ (void)callAction:(NSString*)phoneNum target:(UIView*)view;


/**
 * @interfaceOrientation 输入要强制转屏的方向
 */
+ (void)switchNewOrientation:(UIInterfaceOrientation)interfaceOrientation;

@end
