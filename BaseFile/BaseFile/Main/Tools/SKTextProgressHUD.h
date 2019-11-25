//
//  SKTextProgressHUD.h
//  ShareSpace
//
//  Created by 海狸先生 on 2018/3/20.
//  Copyright © 2018年 SK. All rights reserved.
//


typedef enum{
    /**
     * 屏幕上部
     */
    SKTextTypeUp,
    
    /**
     * 屏幕中间
     */
    SKTextTypeCenter,
    
    /**
     * 屏幕下部
     */
    SKTextTypeBottom
}SKTextType;

#import <UIKit/UIKit.h>

@interface SKTextProgressHUD : UIView

+ (void)showTextWithMsg:(NSString *)msg
               textType:(SKTextType)textType
               duration:(CGFloat)duration;

@end
