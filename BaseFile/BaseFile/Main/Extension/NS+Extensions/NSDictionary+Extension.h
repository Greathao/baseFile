//
//  UIView+Extensions.h
//  iCampsite
//
//  Created by 海狸先生 on 16/4/14.
//  Copyright © 2016年 海狸先生. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Extension)

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonStr;

- (NSString*)jsonString;

//安全的获取 Dictionary值 避免网络数据键值为null 造成的crash
- (id)safeObjectForKey:(NSString*)key;

@end
