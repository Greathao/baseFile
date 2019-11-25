//
//  HLNetWorkTool.m
//  NetWork封装
//
//  Created by liuhao on 2018/5/3.
//  Copyright © 2018年 Beijing Mr Hi Network Technology Company Limited. All rights reserved.
//

#import "HLNetWorkTool.h"

NSString * const OUTPUT_PARAM_RETCODE  = @"code";
NSString * const OUTPUT_PARAM_RETINFO  = @"retInfo";
NSString * const OUTPUT_PARAM_DATA     = @"data";

@implementation HLNetWorkTool

+ (AFHTTPSessionManager*)shareSessionManager;{
    static AFHTTPSessionManager * manager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate,^{
        AFSecurityPolicy * policy = [[AFSecurityPolicy alloc]init];
        [policy setAllowInvalidCertificates:NO];
        manager = [[AFHTTPSessionManager alloc]init];
        [manager setSecurityPolicy:policy];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json", @"application/xml",@"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*"]];
        manager.requestSerializer.timeoutInterval = 30;
     });
    return manager;
}
 
+(NSDictionary*)additionalRequestUrl:(NSString*)url Parameters:(NSDictionary*)actualParam;{
     return (NSDictionary *)actualParam;
}

+(id)formatJSONToDataModal:(id) JSONResponseObject modalClass:(Class)resultCls{
    NSMutableDictionary * dataModalDict = [JSONResponseObject mutableCopy];
    //获取data数据
    id modalPartOfJson = JSONResponseObject[OUTPUT_PARAM_DATA];
    
    if ([modalPartOfJson isKindOfClass:[NSArray class]]) {
        if (((NSArray*)modalPartOfJson).count>0) {
            NSArray * modlarr = [NSArray yy_modelArrayWithClass:resultCls json:modalPartOfJson];
            dataModalDict[OUTPUT_PARAM_DATA] = modlarr;
        }else{
            dataModalDict[OUTPUT_PARAM_DATA] = @[];
        }
        
    }else if ([modalPartOfJson isKindOfClass:[NSDictionary class]]){
        if (((NSDictionary*)modalPartOfJson).count>0) {
            dataModalDict[OUTPUT_PARAM_DATA] = [resultCls yy_modelWithDictionary:modalPartOfJson];
        }else{
            dataModalDict[OUTPUT_PARAM_DATA] = @{};
        }
        
    }
    return dataModalDict;
}
+ (NSString *)fileName:(NSString *)url params:(NSDictionary *)params
{
    NSMutableString *mStr = [NSMutableString stringWithString:url];
    if (params != nil) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:params
                                                       options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [mStr appendString:str];
     }
    return mStr;
}

@end
