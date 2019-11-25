//
//  UIImageView+toBig.h
//  ShareSpace
//
//  Created by 海狸先生 on 2017/11/7.
//  Copyright © 2017年 SK. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ToBigImageViewDelegate <NSObject>

@optional

- (void)PressBtn;

@end

@interface UIImageView (toBig)

@property (nonatomic ,weak)id<ToBigImageViewDelegate> toBigImageVdelegate;

/**
 使该 UIImageView 控件具有点击放大并将图片保存到相册的效果
 */
- (void)canToBigImageViewWithWindow;

@end
