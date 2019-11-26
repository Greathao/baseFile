//
//  UIView+Extensions.h
//  iCampsite
//
//  Created by liuhao on 16/4/14.
//  Copyright © 2016年 liuhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (NSDate_Extension)

/**
 *	@brief	获取NSDate的年份部分
 *
 *	@param 	date 	日期对象
 *
 *	@return	年份
 */
+ (NSInteger)getFullYear:(NSDate *)date;

/**
 *	@brief	获取NSDate的月份部分
 *
 *	@param 	date 	日期对象
 *
 *	@return	月份
 */
+ (NSInteger)getMonth:(NSDate *)date;

/**
 *	@brief	获取NSDate的日期部分
 *
 *	@param 	date 	日期对象
 *
 *	@return	日期
 */
+ (NSInteger)getDay:(NSDate *)date;

/**
 *	@brief	获取NSDate的小时部分
 *
 *	@param 	date 	日期对象
 *
 *	@return	小时
 */
+ (NSInteger)getHour:(NSDate *)date;

/**
 *	@brief	获取NSDate的分钟部分
 *
 *	@param 	date 	日期对象
 *
 *	@return	分钟
 */
+ (NSInteger)getMinute:(NSDate *)date;

/**
 *	@brief	获取NSDate的秒部分
 *
 *	@param 	date 	日期对象
 *
 *	@return	秒
 */
+ (NSInteger)getSecond:(NSDate *)date;

/**
 *	@brief	根据字符串格式转换字符串为日期
 *
 *	@param 	format 	日期格式字符串
 *	@param 	dateString 	日期字符串
 *
 *	@return	日期对象
 */
+ (NSDate *)dateByStringFormat:(NSString *)format dateString:(NSString *)dateString;

/**
 *	@brief	根据字符串格式转换字符串为日期
 *
 *	@param 	format 	日期格式字符串
 *	@param 	dateString 	日期字符串
 *	@param 	locale 	本地化参数
 *
 *	@return	日期对象
 */
+ (NSDate *)dateByStringFormat:(NSString *)format dateString:(NSString *)dateString locale:(NSLocale *)locale;

/**
 *	@brief	根据字符串格式转换日期为字符串
 *
 *	@param 	format 	日期格式字符串
 *	@param 	date 	日期对象
 *
 *	@return	日期字符串
 */
+ (NSString *)stringByStringFormat:(NSString *)format date:(NSDate *)date;

/**
 *	@brief	根据年月日返回日期
 *
 *	@param 	year 	年份
 *	@param 	month 	月份
 *	@param 	day 	日期
 *	@param 	hour 	小时
 *	@param 	minute 	分钟
 *	@param 	second 	秒
 *
 *	@return	日期对象
 */
+ (NSDate *)dateByYear:(NSInteger)year
                 month:(NSInteger)month
                   day:(NSInteger)day
                  hour:(NSInteger)hour
                minute:(NSInteger)minute
                second:(NSInteger)second;

+ (NSDate*)lastDay:(NSDate*)date;

+ (NSDate*)nextDay:(NSDate*)date;

+ (NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month;

/**
 *  根据日期返回农历
 *
 *  @param date 日期
 *
 *  @return 农历日期
 */
+ (NSString*)getChineseCalendarWithDate:(NSDate *)date;

/**
 *  比较两个日期的大小
 *
 *  @param oneDay     一个日期
 *  @param anotherDay 另一个日期
 *
 *  @return 1 第一个日期大 -1 第二个日期大 0 相等
 */
+ (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;

/**
 *  获取两个时间截的差距
 *
 *  @param oneDay     一个日期
 *  @param anotherDay 另一个日期
 *
 *  @return 差 秒
 */


+(NSTimeInterval)timeCutdifferenceOneDay:(NSString*)oneDay withAnotherDay:(NSString*)anotherDay;




@end
