//
//  UIView+Extensions.h
//  iCampsite
//
//  Created by liuhao on 16/4/14.
//  Copyright © 2016年 liuhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (AutoHeight)

- (float)autoHeight;

- (float)autoHeightWithLineSpace:(float)space;

- (void)autoHeight:(int)maxLines;

- (void)autoWidth;

//顶端对齐
-(void)alignTop;

// 两端对齐
- (void)changeAlignmentRightandLeft;

//设置字体行高,注 使用此方法前需先初始文本内容，文本字体
- (void)lineSpacing:(float)space;

@end 
