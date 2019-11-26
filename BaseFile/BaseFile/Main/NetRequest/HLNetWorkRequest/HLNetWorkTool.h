//
//  HLNetWorkTool.h
//  NetWork封装
//
//  Created by liuhao on 2018/5/3.
//  Copyright © 2018年 liuhao All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "DesFunc.h"
#import <YYModel.h>
 

#pragma mark - ********     Webservice intput parameter  ********


#define KEY_TOKEN_ID                                               @"tokenId"
#define KEY_SIGN_ID                                                @"sign"
#define KEY_SSID_ID                                                @"ssid"

#define ANOTHER_DEVICE_LOGIN_CODE                                  @"10017"  //Token失效
#define ANOTHER_TIMEOUT_RELOAD_CODE                                @"10050"  // 超时请重新加载。。加密后返回多的字段


#pragma mark - ********     Webservice output parameter   ********

extern NSString * const OUTPUT_PARAM_RETCODE;
extern NSString * const OUTPUT_PARAM_RETINFO;
extern NSString * const OUTPUT_PARAM_DATA;

@interface HLNetWorkTool : NSObject

///单例请求管理
+ (AFHTTPSessionManager*)shareSessionManager;

///追加参数 加密及token
+(NSDictionary*)additionalRequestUrl:(NSString*)url Parameters:(NSDictionary*)actualParam;;

/// 数据转模型
+(id)formatJSONToDataModal:(id) JSONResponseObject modalClass:(Class)resultCls;

///缓存fileName
+ (NSString *)fileName:(NSString *)url params:(NSDictionary *)params;
 

@end
