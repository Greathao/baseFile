//
//  UIView+Extensions.h
//  iCampsite
//
//  Created by 海狸先生 on 16/4/14.
//  Copyright © 2016年 海狸先生. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIImage_Extensions)

//由颜色值获取图片
+ (UIImage *) imageWithColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius;

//由颜色值半径大小获取圆形图片
+ (UIImage *) circularImageWithColor:(UIColor *)color size:(CGSize)size;

//从左上角截取图片
- (UIImage *) clipImageWithSize:(CGSize)size;

//无缓存方式加载图片
+ (UIImage*) imageNamedNC:(NSString *)str;

// Resize an image
- (UIImage*)transformWidth:(CGFloat)width height:(CGFloat)height;

/*!
 *  缩放图像到指定大小
 *
 *  @param image     图片
 *  @param scaleSize 尺寸大小
 *
 *  @return 图像
 */
+ (UIImage*)scaleImage:(UIImage*)image
               toScale:(float)scaleSize;

/*!
 *  将图片转为自定义大小
 *
 *  @param image 图片
 *  @param size  尺寸
 *
 *  @return 图片
 */
+ (UIImage*)resizeImage:(UIImage*)image
                 toSize:(CGSize)size;

/*!
 *  将UIView转换为图片
 *
 *  @param view UIView对象
 *
 *  @return 图片
 */
+ (UIImage*)convertToImage:(UIView*)view;

/*!
 *  将图片压缩
 *
 *  @param image 图片
 *  @param size  尺寸
 *
 *  @return 图片
 */
+ (UIImage*)compressedImage:(UIImage*)image scaleSize:(CGSize)size;

/**
 *  返回拉伸图片
 */
+ (UIImage *)resizedImage:(NSString *)name;

/**
 *  用颜色返回一张图片
 */
+ (UIImage *)createImageWithColor:(UIColor*) color;
/**
 *  带边框的图片
 *
 *  @param name        图片名字
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 */
+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 *  带边框的图片
 *
 *  @param image        图片
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 */
+ (instancetype)circleImageWithImage:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 *  使用图像名创建图像视图
 *
 *  @param imageName 图像名称
 *
 *  @return UIImageView
 */
+ (instancetype)imageViewWithImageName:(NSString *)imageName;

/**
 *  修改图片的颜色
 *
 *  @param color 图像新颜色
 *
 *  @return UIImage
 */
- (UIImage *)imageWithColor:(UIColor *)color;

- (UIImage *)grayImage:(UIImage *)sourceImage;

////////////////////////
+ (UIImage *)simpleImage:(UIImage *)originImg;

+ (UIImage *)makeArrowImageWithSize:(CGSize)imageSize
                              image:(UIImage *)image
                           isSender:(BOOL)isSender;

+ (UIImage *)gxz_imageWithColor:(UIColor *)color;

+ (UIImage *)addImage2:(UIImage *)firstImg
               toImage:(UIImage *)secondImg;

+ (UIImage *)addImage:(UIImage *)firstImg
              toImage:(UIImage *)secondImg;

// 旋转图片
+ (UIImage *)fixOrientation:(UIImage *)aImage;

@end
