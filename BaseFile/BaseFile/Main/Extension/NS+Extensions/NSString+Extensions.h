//
//  UIView+Extensions.h
//  iCampsite
//
//  Created by liuhao on 16/4/14.
//  Copyright © 2016年 liuhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NSString_Extensions)

///区号 0086转+86 负责显示并加*
+(NSString*)stringFormatAndXingAreaCode:(NSString*)areaCode;

///区号 0086转+86 负责显示
+(NSString*)stringFormatAreaCode:(NSString*)areaCode;

//utf-8数据转换为utf-8字符串
+ (NSString *)stringFromUTF8Data:(NSData *)data;

//计算字符串高度
+(CGFloat)stringCalculateHightStr:(NSString*)str Font:(UIFont*)font ControlsWidth:(CGFloat)width;


//计算中英文混排的字符串长度
+ (int)stringLength:(NSString  *)str;

//手机号码字符过滤
+ (NSString *)mobilePhoneFilter:(NSString *)str;

/**
 根据时间戳返回日期描述字符串
 /// 格式如下
 ///     -   刚刚(一分钟内)
 ///     -   X分钟前(一小时内)
 ///     -   X小时前(当天)
 ///     -   昨天 HH:mm(昨天)
 ///     -   MM-dd HH:mm(一年内)
 ///     -   yyyy-MM-dd HH:mm(更早期)
 @param interval 时间戳
 @return 字符串
 */
+(NSString *)timeValue:(NSTimeInterval)interval;

/**
 根据时间戳返回日期描述字符串
 /// 格式如下
 ///     -   刚刚(一分钟内)
 ///     -   X分钟前(一小时内)
 ///     -   X小时前(当天)
 ///     -   昨天 HH:mm(昨天)
 ///     -   MM-dd HH:mm(一年内)
 ///     -   yyyy-MM-dd HH:mm(更早期)
 @param string 时间
 @return 字符串
 */
+(NSString*)stringToNSDate:(NSString*)string;

//日期显示
+ (NSString *)dateValue:(NSTimeInterval)interval;

//根据播放时间长度格式化为小时分钟表示
+ (NSString *)videoPlayTimeValue:(double)time;

//
+ (NSString *)stringByFormatDate:(NSString*)format date:(NSDate *)date;

/**
 * 判断字段是否包含空格
 */
- (BOOL)validateContainsSpace;

/**
 *  根据生日返回年龄
 */
- (NSString *)ageFromBirthday;

/**
 *  根据身份证返回岁数
 */
- (NSString *)ageFromIDCard;

/**
 *  根据身份证返回生日
 */
- (NSString*)birthdayFromIDCard;

/**
 *  根据身份证返回性别
 */
- (NSString*)sexFromIDCard;

+(BOOL)isNULL:(id)string;

- (NSMutableAttributedString *)stringWithName:(NSString *)name allValue:(id)allVal selValue:(id)selVal selRange:(NSRange)selRan;

/**
 *  将阿拉伯数字转换为中文数字
 */
+(NSString *)translationArabicNum:(NSInteger)arabicNum;

/////////////////
- (NSString *)originName;
+ (NSString *)currentName;
- (NSString *)firstStringSeparatedByString:(NSString *)separeted;

@end
