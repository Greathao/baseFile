//
//  UIView+RectCorner.h
//  AttorneyOL
//
//  Created by 海狸先生 on 2017/9/4.
//  Copyright © 2017年 SK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (RectCorner)

/**
 *  圆角半径 默认 5
 */
@property(nonatomic,assign)CGFloat rectCornerRadii;

/**
 *  圆角方位
 */
@property(nonatomic,assign)UIRectCorner rectCorner;

@end
