//
//  NSDate+Chinese.m
//  ShareSpace
//
//  Created by liuhao on 2017/10/11.
//  Copyright © 2017年 SK. All rights reserved.
//

#import "NSDate+Chinese.h"

@implementation NSDate (Chinese)

+(NSString *)getChineseTimeWithTimestamp:(NSTimeInterval)time{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:confromTimesp];
    return [self GetChineseTime:dateString];
}

+(NSString *)GetChineseTime:(NSString *)Timer{
    
    //返回的字符串
    NSString *ChineseStr;
    //获取当前时间
    NSString *CurrentTimer = [self GetTime];
    //当前时间数组
    NSArray *CurrentTimeArr = [CurrentTimer componentsSeparatedByString:@" "];
    //当前年月日
    NSString *CurrentTimeFirstStr = CurrentTimeArr.firstObject;
    //当前时分秒
    NSString *CurrentTimeLastStr = CurrentTimeArr.lastObject;
    //拆分当前年月日
    NSArray *CurrentTimeFirstArr = [CurrentTimeFirstStr componentsSeparatedByString:@"-"];
    //拆分当前时分秒
    NSArray *CurrentTimeLastArr = [CurrentTimeLastStr componentsSeparatedByString:@":"];
    //当前年
    NSString *CurrentYear = CurrentTimeFirstArr.firstObject;
    //当前月
    NSString *CurrentMonth = CurrentTimeFirstArr[1];
    //当前日
    NSString *CurrentDay = CurrentTimeFirstArr.lastObject;
    //当前时
    NSString *CurrentTime = CurrentTimeLastArr.firstObject;
    //当前分
    NSString *CurrentBranch = CurrentTimeLastArr[1];
    //当前秒
    NSString *CurrentSecond = CurrentTimeLastArr.lastObject;
    //时间数组
    NSArray *TimeArr = [Timer componentsSeparatedByString:@" "];
    //年月日
    NSString *TimeFirstStr = TimeArr.firstObject;
    //时分秒
    NSString *TimeLastStr = TimeArr.lastObject;
    //拆分年月日
    NSArray *TimeFirstArr = [TimeFirstStr componentsSeparatedByString:@"-"];
    //拆分时分秒
    NSArray *TimeLastArr = [TimeLastStr componentsSeparatedByString:@":"];
    //年
    NSString *Year = TimeFirstArr.firstObject;
    //月
    NSString *Month = TimeFirstArr[1];
    //日
    NSString *Day = TimeFirstArr.lastObject;
    //时
    NSString *Time = TimeLastArr.firstObject;
    //分
    NSString *Branch = TimeLastArr[1];
    //秒
    NSString *Second = TimeLastArr.lastObject;
    
    if ([CurrentYear integerValue] < [Year integerValue]) {
        return @"时间错误";
    }else if ([CurrentYear integerValue] > [Year integerValue]){
        return [NSString stringWithFormat:@"%ld年前",[CurrentYear integerValue] - [Year integerValue]];
    }else{
        if ([CurrentMonth integerValue] < [Month integerValue]) {
            return @"时间错误";
        }else if ([CurrentMonth integerValue] > [Month integerValue]){
            return [NSString stringWithFormat:@"%ld个月前",[CurrentMonth integerValue] - [Month integerValue]];
        }else{
            if ([CurrentDay integerValue] < [Day integerValue]) {
                return @"时间错误";
            }else if ([CurrentDay integerValue] > [Day integerValue]){
                if ([CurrentDay integerValue] - [Day integerValue] >= 7) {
                    return [NSString stringWithFormat:@"一周前"];
                }
                return [NSString stringWithFormat:@"%ld天前",[CurrentDay integerValue] - [Day integerValue]];
            }else{
                if ([CurrentTime integerValue] < [Time integerValue]) {
                    return @"时间错误";
                }else if ([CurrentTime integerValue] > [Time integerValue]){
                    return [NSString stringWithFormat:@"%ld小时前",[CurrentTime integerValue] - [Time integerValue]];
                }else{
                    if ([CurrentBranch integerValue] < [Branch integerValue]) {
                        return @"时间错误";
                    }else if ([CurrentBranch integerValue] > [Branch integerValue]){
                        return [NSString stringWithFormat:@"%ld分钟前",[CurrentBranch integerValue] - [Branch integerValue]];
                    }else{
                        if ([CurrentSecond integerValue] < [Second integerValue]) {
                            return @"时间错误";
                        }else{
                            return @"刚刚";
                        }
                    }
                }
            }
        }
    }
    
    return ChineseStr;
}

//获取当前时间
+(NSString *)GetTime{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return dateString;
}

+ (NSString*)weekDayStr:(NSString *)format{
    
    
    NSString *weekDayStr = nil;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    if (format.length >= 10) {
        NSArray *array = [[format substringToIndex:10] componentsSeparatedByString:@"-"];
        NSInteger year = [[array objectAtIndex:0] integerValue];
        NSInteger month = [[array objectAtIndex:1] integerValue];
        NSInteger day = [[array objectAtIndex:2] integerValue];
        [comps setYear:year];
        [comps setMonth:month];
        [comps setDay:day];
    }
    
    /*
     NSString *str = format;
     if (str.length >= 10) {
     NSString *nowString = [str substringToIndex:10];
     NSArray *array = [nowString componentsSeparatedByString:@"-"];
     if (array.count == 0) {
     array = [nowString componentsSeparatedByString:@"/"];
     }
     if (array.count >= 3) {
     NSInteger year = [[array objectAtIndex:0] integerValue];
     NSInteger month = [[array objectAtIndex:1] integerValue];
     NSInteger day = [[array objectAtIndex:2] integerValue];
     [comps setYear:year];
     [comps setMonth:month];
     [comps setDay:day];
     }
     }
     */
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *_date = [gregorian dateFromComponents:comps];
    NSDateComponents *weekdayComponents = [gregorian components:NSCalendarUnitWeekday fromDate:_date];
    NSInteger week = [weekdayComponents weekday];
    week ++;
    switch (week) {
        case 1:
            weekDayStr = @"星期日";
            break;
        case 2:
            weekDayStr = @"星期一";
            break;
        case 3:
            weekDayStr = @"星期二";
            break;
        case 4:
            weekDayStr = @"星期三";
            break;
        case 5:
            weekDayStr = @"星期四";
            break;
        case 6:
            weekDayStr = @"星期五";
            break;
        case 7:
            weekDayStr = @"星期六";
            break;
        default:
            weekDayStr = @"";
            break;
    }
    return weekDayStr;
    
}

@end
