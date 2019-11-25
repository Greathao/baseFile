//
//  UIView+Extensions.h
//  iCampsite
//
//  Created by 海狸先生 on 16/4/14.
//  Copyright © 2016年 海狸先生. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (NSDate_Extension)

/**
 *	@brief	获取NSDate的年份部分
 *
 *	@param 	date 	日期对象
 *
 *	@return	年份
 */
+ (NSInteger)getFullYear:(NSDate *)date
{
    return [[NSString stringWithFormat:@"%@", date] substringWithRange:NSMakeRange(0, 4)].intValue;
}

/**
 *	@brief	获取NSDate的月份部分
 *
 *	@param 	date 	日期对象
 *
 *	@return	月份
 */
+ (NSInteger)getMonth:(NSDate *)date
{
    return [[NSString stringWithFormat:@"%@", date] substringWithRange:NSMakeRange(5, 2)].intValue;
}

/**
 *	@brief	获取NSDate的日期部分
 *
 *	@param 	date 	日期对象
 *
 *	@return	日期
 */
+ (NSInteger)getDay:(NSDate *)date
{
    return [[NSString stringWithFormat:@"%@", date] substringWithRange:NSMakeRange(8, 2)].intValue;
}

/**
 *	@brief	获取NSDate的小时部分
 *
 *	@param 	date 	日期对象
 *
 *	@return	小时
 */
+ (NSInteger)getHour:(NSDate *)date
{
    return [[NSString stringWithFormat:@"%@", date] substringWithRange:NSMakeRange(11, 2)].intValue;
}

/**
 *	@brief	获取NSDate的分钟部分
 *
 *	@param 	date 	日期对象
 *
 *	@return	分钟
 */
+ (NSInteger)getMinute:(NSDate *)date
{
    return [[NSString stringWithFormat:@"%@", date] substringWithRange:NSMakeRange(14, 2)].intValue;
}

/**
 *	@brief	获取NSDate的秒部分
 *
 *	@param 	date 	日期对象
 *
 *	@return	秒
 */
+ (NSInteger)getSecond:(NSDate *)date
{
    return [[NSString stringWithFormat:@"%@", date] substringWithRange:NSMakeRange(17, 2)].intValue;
}

/**
 *	@brief	根据字符串格式转换字符串为日期
 *
 *	@param 	format 	日期格式字符串
 *	@param 	dateString 	日期字符串
 *
 *	@return	日期对象
 */
+ (NSDate *)dateByStringFormat:(NSString *)format dateString:(NSString *)dateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    
    return [formatter dateFromString:dateString];
}

/**
 *	@brief	根据字符串格式转换字符串为日期
 *
 *	@param 	format 	日期格式字符串
 *	@param 	dateString 	日期字符串
 *	@param 	locale 	本地化参数
 *
 *	@return	日期对象
 */
+ (NSDate *)dateByStringFormat:(NSString *)format dateString:(NSString *)dateString locale:(NSLocale *)locale
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    formatter.locale = locale;
    
    return [formatter dateFromString:dateString];
}

/**
 *	@brief	根据字符串格式转换日期为字符串
 *
 *	@param 	format 	日期格式字符串
 *	@param 	date 	日期对象
 *
 *	@return	日期字符串
 */
+ (NSString *)stringByStringFormat:(NSString *)format date:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    
    return [formatter stringFromDate:date];
}

/**
 *	@brief	根据年月日返回日期
 *
 *	@param 	year 	年份
 *	@param 	month 	月份
 *	@param 	date 	日期
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
                second:(NSInteger)second
{
    NSDateComponents *comonents = [[NSDateComponents alloc] init];
    comonents.year = year;
    comonents.month = month;
    comonents.day = day;
    comonents.hour = hour;
    comonents.minute = minute;
    comonents.second = second;
    
    return [comonents date];
}

+ (NSDate*)lastDay:(NSDate*)date{
    return [NSDate dateWithTimeInterval:-24*60*60 sinceDate:date];//前一天
}

+ (NSDate*)nextDay:(NSDate*)date{
   return [NSDate dateWithTimeInterval:24*60*60 sinceDate:date];//后一天
}

//前后n月
+ (NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month

{
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    [comps setMonth:month];
    
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:  NSCalendarIdentifierGregorian];
    
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];
    
    return mDate;
    
}

+(NSString*)getChineseCalendarWithDate:(NSDate *)date{
    
    NSArray *chineseYears = [NSArray arrayWithObjects:
                             @"甲子", @"乙丑", @"丙寅", @"丁卯",  @"戊辰",  @"己巳",  @"庚午",  @"辛未",  @"壬申",  @"癸酉",
                             @"甲戌",   @"乙亥",  @"丙子",  @"丁丑", @"戊寅",   @"己卯",  @"庚辰",  @"辛己",  @"壬午",  @"癸未",
                             @"甲申",   @"乙酉",  @"丙戌",  @"丁亥",  @"戊子",  @"己丑",  @"庚寅",  @"辛卯",  @"壬辰",  @"癸巳",
                             @"甲午",   @"乙未",  @"丙申",  @"丁酉",  @"戊戌",  @"己亥",  @"庚子",  @"辛丑",  @"壬寅",  @"癸丑",
                             @"甲辰",   @"乙巳",  @"丙午",  @"丁未",  @"戊申",  @"己酉",  @"庚戌",  @"辛亥",  @"壬子",  @"癸丑",
                             @"甲寅",   @"乙卯",  @"丙辰",  @"丁巳",  @"戊午",  @"己未",  @"庚申",  @"辛酉",  @"壬戌",  @"癸亥", nil];
    
    NSArray *chineseMonths=[NSArray arrayWithObjects:
                            @"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",
                            @"九月", @"十月", @"冬月", @"腊月", nil];
    
    
    NSArray *chineseDays=[NSArray arrayWithObjects:
                          @"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",
                          @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",
                          @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十",  nil];
    
    
    NSCalendar *localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:date];
    
    NSLog(@"日期的数量  %ld_%ld_%ld  %@",(long)localeComp.year,(long)localeComp.month,(long)localeComp.day, localeComp.date);
    
    NSString *y_str = [chineseYears objectAtIndex:localeComp.year-1];
    NSString *m_str = [chineseMonths objectAtIndex:localeComp.month-1];
    NSString *d_str = [chineseDays objectAtIndex:localeComp.day-1];
    
    NSString *chineseCal_str =[NSString stringWithFormat: @"%@年%@%@",y_str,m_str,d_str];
    
    return chineseCal_str;  
}

// 时间比较
+ (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay {
    
    if (anotherDay == nil) {
        return -1;
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *oneDayStr            = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr        = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA                  = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB                  = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result      = [dateA compare:dateB];
    
    // dateA大
    if (result == NSOrderedDescending) {
        
        return 1;
        
    }else if (result == NSOrderedAscending){
        
        return -1;
    }
    
    return 0;
    
}

//时间差
+(NSTimeInterval)timeCutdifferenceOneDay:(NSString*)oneDay withAnotherDay:(NSString*)anotherDay;
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd-HH:MM:ss"];//@"yyyy-MM-dd-HHMMss"
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[oneDay doubleValue]];
    NSString *dateString = [formatter stringFromDate:date];
    NSLog(@"开始时间: %@", dateString);
    
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:[anotherDay doubleValue]];
    NSString *dateString2 = [formatter stringFromDate:date2];
    NSLog(@"结束时间: %@", dateString2);
    
    NSTimeInterval seconds = [date2 timeIntervalSinceDate:date];
    NSLog(@"两个时间相隔：%f", seconds);
    return seconds;
 
};




@end
