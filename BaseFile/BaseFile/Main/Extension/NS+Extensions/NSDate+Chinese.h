//
//  NSDate+Chinese.h
//  ShareSpace
//
//  Created by liuhao on 2017/10/11.
//  Copyright © 2017年 SK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Chinese)

// 时间戳转时间
+(NSString *)getChineseTimeWithTimestamp:(NSTimeInterval)time;

//将时间字符串2017-01-01 12:12:12 格式转换成微信时间格式
+(NSString *)GetChineseTime:(NSString *)Time;

//获取当前时间
+(NSString *)GetTime;

@end
