//
//  UserDefaults.h
//  iCampsite
//
//  Created by 海狸先生 on 16/4/14.
//  Copyright © 2016年 海狸先生. All rights reserved.
//

#import <Foundation/Foundation.h>

// 保存用户数据
@interface UserDefaults : NSUserDefaults

+(id)readUserDefaultObjectValueForKey:(NSString*)aKey;

+(void)writeUserDefaultObjectValue:(NSObject*)aValue
                           withKey:(NSString*)aKey;

+ (void)clearUserDefaultWithKey:(NSString *)key;

/**
 *  写入文件夹
 */
+ (void)synchronize;

@end
