//
//  UIView+Extensions.h
//  iCampsite
//
//  Created by 海狸先生 on 16/4/14.
//  Copyright © 2016年 海狸先生. All rights reserved.
//

#import "NSDictionary+Extension.h"

@implementation NSDictionary (Extension)

- (id)safeObjectForKey:(NSString*)key{
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:[NSNull class]]) {
        obj = nil;
    }
    return obj;
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonStr{
    id responseObject = nil;
    NSError *serializationError = nil;
    if (jsonStr && ![jsonStr isEqualToString:@" "]) {
        NSData *data;
        // Workaround for a bug in NSJSONSerialization when Unicode character escape codes are used instead of the actual character
        // See http://stackoverflow.com/a/12843465/157142
        
        // 增加在},]符号之前多了一个逗号的非标准json字符数据的处理
        jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@",}" withString:@"}"];
        jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@",]" withString:@"]"];
        // 增加结束
        // 增加换行制表符过滤
        jsonStr = [jsonStr stringByReplacingOccurrencesOfString : @"\r" withString : @"" ];
        
        jsonStr = [jsonStr stringByReplacingOccurrencesOfString : @"\n" withString : @"" ];
        
        jsonStr = [jsonStr stringByReplacingOccurrencesOfString : @"\t" withString : @"" ];
        
        data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        
        if (data) {
            if ([data length] > 0) {
                responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&serializationError];
            } else {
                return nil;
            }
        }
    }
    return responseObject;
}

- (NSString*)jsonString{
    NSData* infoJsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    NSString* json = [[NSString alloc] initWithData:infoJsonData encoding:NSUTF8StringEncoding];
    return json;
}

@end
