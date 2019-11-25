//
//  HLNetWorking.h
//  NetWork封装
//
//  Created by liuhao on 2018/5/2.
//  Copyright © 2018年 Beijing Mr Hi Network Technology Company Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

#import "HLNetWorkTool.h"


@interface HLNetWorking : NSObject

+ (void)processServiceRequestGet:(NSDictionary *)dictReqParameters
                      requestURL:(NSString *)requestURL
                    successBlock:(void (^)(id responseObject))successBlock
                    failureBlock:(void (^) (NSError *error))failureBlock;

+(void)processServiceRequestPost:(NSDictionary *)dictReqParameters
                      requestURL:(NSString *)requestURL
                    successBlock:(void (^)(id responseObject))successBlock
                    failureBlock:(void (^)(NSError *error))failureBlock;

+ (void)processServiceRequestImage:(NSDictionary *)dictReqParameters
                   requestImageKey:(NSString *)requestImageKey
                  requestImageData:(NSArray *)requestImageData
                        requestURL:(NSString *)requestURL
                     progressBlock:(void (^)(NSProgress *uploadProgress))progressBlock
                      successBlock:(void (^)(id responseObject))successBlock
                      failureBlock:(void (^)(NSError *error))failureBlock;

/**
 *  取消所有请求
 */
+ (void)cancelAllRequest;

/**
 *  根据url取消请求
 *
 *  @param url 请求url
 */
+ (void)cancelRequestWithURL:(NSString *)url;

@end
