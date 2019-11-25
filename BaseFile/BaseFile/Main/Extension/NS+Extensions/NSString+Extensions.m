//
//  UIView+Extensions.h
//  iCampsite
//
//  Created by 海狸先生 on 16/4/14.
//  Copyright © 2016年 海狸先生. All rights reserved.
//

#include <ifaddrs.h>
#include <arpa/inet.h>
#import "NSString+Extensions.h"
#import "NSDictionary+Extension.h"

@implementation NSString (NSString_Extensions)

///区号 0086转+86 负责显示并加*
+(NSString*)stringFormatAndXingAreaCode:(NSString*)areaCode{
    if (!areaCode || areaCode.length < 3) return areaCode;
    NSInteger xingLeng = (areaCode.length - 3)/2;
    NSString *xingStr = @"";
    for (int i = 0; i < xingLeng; i++) {
        xingStr = [xingStr stringByAppendingString:@"*"];
    }
    areaCode = [areaCode stringByReplacingCharactersInRange:NSMakeRange(areaCode.length - xingLeng - xingLeng/2, xingLeng) withString:xingStr];
    NSString *code = [areaCode substringWithRange:NSMakeRange(0, 2)];
    return [@"+"stringByAppendingString:[[areaCode componentsSeparatedByString:code] lastObject]];
}

///区号 0086转+86 负责显示
+(NSString*)stringFormatAreaCode:(NSString*)areaCode;{
    if (!areaCode || areaCode.length < 3) return areaCode;
    NSString *code = [areaCode substringWithRange:NSMakeRange(0, 2)];
    return [@"+"stringByAppendingString:[[areaCode componentsSeparatedByString:code] lastObject]];
 }

//utf-8数据转换为utf-8字符串
+ (NSString *)stringFromUTF8Data:(NSData *)data{
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    str = [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return str;
}

//格式化输出各种对象
+ (NSString *)stringFormatValue:(id)obj{
    NSString *str = @"";
    if(obj == nil || [obj isKindOfClass:[NSNull class]]) {
    }
    else if([obj isKindOfClass:[NSNumber class]]) {
        str = [(NSNumber *)obj stringValue];
    }
    else if([obj isKindOfClass:[NSString class]] && [(NSString *)obj length] && ![obj isEqualToString:@"null"]) {
        str = obj;
    }
    return str;
}

//判断字符串长度, 支持中英文 特殊字符混编
+ (int)stringLength:(NSString  *)str
{
    int len = 0;
    char* p = (char*) [str cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i = 0 ; i < [str lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++)
    {
        if (*p) {
            p++;
            len++;
        }
        else {
            p++;
        }
    }
    return len;
}

//手机号码字符过滤
+ (NSString *)mobilePhoneFilter:(NSString *)str
{
    if(str == nil || [str length] == 0)
        return nil;
    NSMutableString *phone = [NSMutableString stringWithCapacity:0];
    for(int i = 0; i < [str length]; i++)
    {
        char ch = [str characterAtIndex:i];
        if((ch >= '0' && ch <= '9') || ch == '-') {
            [phone appendFormat:@"%c", ch];
        }
    }
    return phone;
}

//时间显示
+ (NSString *)timeValue:(NSTimeInterval)interval
{
	NSTimeInterval _interval = [[NSDate date] timeIntervalSince1970];
    _interval-=interval;
	NSString *result = @"";
	int temp = 0;
	if(_interval <60) { //60秒以内
		result = @"刚刚";
	}
	else if((temp = _interval/60) <60) { //1小时以内
		result = [NSString stringWithFormat:@"%d分钟前", temp];
	}
	else if((temp = temp/60) <24 ) { //超过60分钟今天内的
		result = [NSString stringWithFormat:@"%d小时前", temp];
	}
    else if((temp = temp/24) <1){ //今天
		result = [NSString stringWithFormat:@"今天"];
	}
    else if((temp ) <2){ //昨天
		result = [NSString stringWithFormat:@"昨天"];
	}
    else if((temp) <30){ //一个月内的
		result = [NSString stringWithFormat:@"%d天前", temp];
	}
	else if((temp = temp/30) <12){ //等于或超过1个月（规定一个月为30天
		result = [NSString stringWithFormat:@"%d月前", temp];
	}
	else{ //比1年更久的时间
		
        temp = temp/12;
		result = [NSString stringWithFormat:@"%d年前", temp];
        
//        result = [NSString stringByStringFormat:@"yyyy-MM-dd HH:mm:ss" data:[NSDate dateWithTimeIntervalSince1970:interval] ];
        
	}
	
    return result;
}

//日期显示
+ (NSString *)dateValue:(NSTimeInterval)interval
{
    NSString *result=[NSString stringByFormatDate:@"yyyy-MM-dd HH:mm:ss" date:[NSDate dateWithTimeIntervalSince1970:interval]];

    NSString *year = [NSString stringWithFormat:@"%d年", (int)[NSString getFullYear:[NSDate date] ] ];
    
    return [result stringByReplacingOccurrencesOfString:year withString:@""];
}

+ (NSString *)stringByFormatDate:(NSString*)format date:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:format];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
    
}

+ (long)getFullYear:(NSDate*)date{
    NSDate *currentDate = [NSDate date];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay fromDate:currentDate];
    return [components year];
}

//根据播放时间长度格式化为小时分钟表示
+ (NSString *)videoPlayTimeValue:(double)time
{
    NSString *result = nil;
    int hour = 0, min = 0, sec = 0;
    if(time > 60*60) {
        hour = time / (60 * 60);
		time -= hour * (60 * 60);
	}
	if(time > 60) {
        min = time / 60;
		time -= min * 60;
	}
	sec = time;
	
    if(hour > 0)
        result = [NSString stringWithFormat:@"%0.2d:%0.2d:%0.2d", hour, min, sec];
    else
        result = [NSString stringWithFormat:@"%0.2d:%0.2d", min, sec];
    
    return result;
}

+(NSString*)stringToNSDate:(NSString*)string{
    NSString* timeStr = string;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    
    NSDate* date = [formatter dateFromString:timeStr];
    NSString *result = @"";
    result = [NSString timeValue:[date timeIntervalSince1970]];
    return result;
}

- (BOOL)validateContainsSpace {
    return [self rangeOfString:@" "].location == NSNotFound;
}

- (NSString *)ageFromBirthday {
    if (self.length != 10 ||
        [self characterAtIndex:4] != '.' ||
        [self characterAtIndex:7] != '.') {
        return @"";
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    NSString *today = [formatter stringFromDate:[NSDate date]];
    
    NSString *selfYear = [self substringToIndex:4];
    NSString *nowYear = [today substringToIndex:4];
    NSInteger age = nowYear.integerValue - selfYear.integerValue;
    
    NSString *selfDate = [self substringFromIndex:5];
    NSString *nowDate = [today substringFromIndex:5];
    if ([nowDate compare:selfDate] < 0) {
        age = age - 1;
    }
    
    if (age < 0) {
        return @"";
    }
    
    return [NSString stringWithFormat:@"%zd", age];
}

- (NSString *)ageFromIDCard {
    NSString *birthday = [self birthdayFromIDCard];
    
    return [birthday ageFromBirthday];
}

- (NSString*)birthdayFromIDCard {
    NSString *result = @"未知";
    if (self.length == 15) {
        NSMutableString *birthString = [[self substringWithRange:NSMakeRange(6, 6)] mutableCopy];
        [birthString insertString:@"19" atIndex:0];
        [birthString insertString:@"." atIndex:4];
        [birthString insertString:@"." atIndex:7];
        result = birthString;
    } else if (self.length == 18) {
        NSMutableString *birthString = [[self substringWithRange:NSMakeRange(6, 8)] mutableCopy];
        [birthString insertString:@"." atIndex:4];
        [birthString insertString:@"." atIndex:7];
        result = birthString;
    }
    
    return result;
}

- (NSString*)sexFromIDCard {
    NSString *sexString = @"";
    
    if (self.length == 15) {
        sexString =  [[self substringWithRange:NSMakeRange(14, 1)] mutableCopy];
    } else if (self.length == 18) {
        sexString = [[self substringWithRange:NSMakeRange(16, 1)] mutableCopy];
    }
    
    int x = sexString.intValue;
    if (x < 0 || sexString.length == 0) {
        return @"";
    }
    if (x % 2 == 0) {
        return @"女";
    } else {
        return @"男";
    }
    return sexString;
}

+ (BOOL)isNULL:(id)string{
    
    if (string == nil) {
        return YES;
    }
    if (string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

- (NSMutableAttributedString *)stringWithName:(NSString *)name allValue:(id)allVal selValue:(id)selVal selRange:(NSRange)selRan{
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:self];
    [attStr addAttribute:name value:allVal range:NSMakeRange(0, attStr.length)];
    [attStr addAttribute:name value:selVal range:selRan];
    return attStr;
}

/**
 *  将阿拉伯数字转换为中文数字
 */
+(NSString *)translationArabicNum:(NSInteger)arabicNum
{
    NSString *arabicNumStr = [NSString stringWithFormat:@"%ld",(long)arabicNum];
    NSArray *arabicNumeralsArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    NSArray *chineseNumeralsArray = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"零"];
    NSArray *digits = @[@"个",@"十",@"百",@"千",@"万",@"十",@"百",@"千",@"亿",@"十",@"百",@"千",@"兆"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:chineseNumeralsArray forKeys:arabicNumeralsArray];
    
    if (arabicNum < 20 && arabicNum > 9) {
        if (arabicNum == 10) {
            return @"十";
        }else{
            NSString *subStr1 = [arabicNumStr substringWithRange:NSMakeRange(1, 1)];
            NSString *a1 = [dictionary objectForKey:subStr1];
            NSString *chinese1 = [NSString stringWithFormat:@"十%@",a1];
            return chinese1;
        }
    }else{
        NSMutableArray *sums = [NSMutableArray array];
        for (int i = 0; i < arabicNumStr.length; i ++)
        {
            NSString *substr = [arabicNumStr substringWithRange:NSMakeRange(i, 1)];
            NSString *a = [dictionary objectForKey:substr];
            NSString *b = digits[arabicNumStr.length -i-1];
            NSString *sum = [a stringByAppendingString:b];
            if ([a isEqualToString:chineseNumeralsArray[9]])
            {
                if([b isEqualToString:digits[4]] || [b isEqualToString:digits[8]])
                {
                    sum = b;
                    if ([[sums lastObject] isEqualToString:chineseNumeralsArray[9]])
                    {
                        [sums removeLastObject];
                    }
                }else
                {
                    sum = chineseNumeralsArray[9];
                }
                
                if ([[sums lastObject] isEqualToString:sum])
                {
                    continue;
                }
            }
            [sums addObject:sum];
        }
        NSString *sumStr = [sums  componentsJoinedByString:@""];
        NSString *chinese = [sumStr substringToIndex:sumStr.length-1];
        return chinese;
    }
}

//////////////////////////////////
- (NSString *)originName
{
    NSArray *list = [self componentsSeparatedByString:@"_"];
    NSMutableString *orgName = [NSMutableString string];
    NSUInteger count = list.count;
    if (list.count > 1) {
        for (int i = 1; i < count; i ++) {
            [orgName appendString:list[i]];
            if (i < count-1) {
                [orgName appendString:@"_"];
            }
        }
    } else {  // 防越狱的情况下，本地改名字
        orgName = list[0];
    }
    return orgName;
}

+ (NSString *)currentName
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYYMMddHHMMss"];
    NSString *currentDate = [dateFormatter stringFromDate:[NSDate date]];
    return currentDate;
}

- (NSString *)firstStringSeparatedByString:(NSString *)separeted
{
    NSArray *list = [self componentsSeparatedByString:separeted];
    return [list firstObject];
}



+(CGFloat)stringCalculateHightStr:(NSString*)str Font:(UIFont*)font ControlsWidth:(CGFloat)width;
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    NSDictionary * attributes = @{
                                  NSFontAttributeName:font,
                                  NSParagraphStyleAttributeName: paragraphStyle
                                  };
    CGSize textRect = CGSizeMake(width, MAXFLOAT);
    CGFloat textHeight = [str boundingRectWithSize:textRect
                                           options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                        attributes:attributes
                                           context:nil].size.height;
    return textHeight;
    
}

@end
