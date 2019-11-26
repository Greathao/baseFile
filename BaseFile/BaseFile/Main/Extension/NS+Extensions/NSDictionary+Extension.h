//
//  UIView+Extensions.h
//  iCampsite
//
//  Created by liuhao on 16/4/14.
//  Copyright © 2016年 liuhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Extension)

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonStr;

- (NSString*)jsonString;

//安全的获取 Dictionary值 避免网络数据键值为null 造成的crash
- (id)safeObjectForKey:(NSString*)key;

@end
