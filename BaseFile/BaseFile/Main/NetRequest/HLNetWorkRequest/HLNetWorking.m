//
//  HLNetWorking.m
//  NetWork封装
//
//  Created by liuhao on 2018/5/2.
//  Copyright © 2018年 Beijing Mr Hi Network Technology Company Limited. All rights reserved.
//

#import "HLNetWorking.h"

static NSMutableArray *requestTasks;

@implementation HLNetWorking
///get请求
+ (void)processServiceRequestGet:(NSDictionary *)dictReqParameters
                      requestURL:(NSString *)requestURL
                    successBlock:(void (^)(id responseObject))successBlock
                    failureBlock:(void (^) (NSError *error))failureBlock{
    
    AFHTTPSessionManager * manager = [HLNetWorkTool shareSessionManager];
    
    NSURLSessionDataTask *session;
    
    session = [manager GET:requestURL parameters:dictReqParameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"\n\n<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< \n\n GET URL : %@ \n\n<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n\n result : %@ \n\n <<<<<<<<<<<<<<<<<<<<<<\n" ,[self logTheRequsetUrl:requestURL params:dictReqParameters], responseObject);
        successBlock(responseObject);
        [[self allTasks] removeObject:task];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"\n\n<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< \n\n GET URL : %@ \n\n<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n\n result : %@ \n\n <<<<<<<<<<<<<<<<<<<<<<\n" ,[self logTheRequsetUrl:requestURL params:dictReqParameters], [error localizedDescription]);
        failureBlock(error);
        [[self allTasks] removeObject:task];
    }];
    
    if (session) {
        [[self allTasks] addObject:session];
    }
 
}

+(void)processServiceRequestPost:(NSDictionary *)dictReqParameters
                      requestURL:(NSString *)requestURL
                    successBlock:(void (^)(id responseObject))successBlock
                    failureBlock:(void (^)(NSError *error))failureBlock{
    
    AFHTTPSessionManager * manager =[HLNetWorkTool shareSessionManager];
    
    NSURLSessionDataTask *session;
    
    session = [manager POST:requestURL parameters:dictReqParameters progress:^(NSProgress * _Nonnull downloadProgress) {
   
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock ? successBlock(responseObject) : nil;
        
        NSLog(@"\n\n<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< \n\n GET URL : %@ \n\n<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n\n result : %@ \n\n <<<<<<<<<<<<<<<<<<<<<<\n" ,[self logTheRequsetUrl:requestURL params:dictReqParameters], responseObject);
        successBlock(responseObject);
        [[self allTasks] removeObject:task];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"\n\n<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< \n\n GET URL : %@ \n\n<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n\n result : %@ \n\n <<<<<<<<<<<<<<<<<<<<<<\n" ,[self logTheRequsetUrl:requestURL params:dictReqParameters], [error localizedDescription]);
        [[self allTasks] removeObject:task];
    }];
    
    if (session) {
        [[self allTasks] addObject:session];
    }
 
 }
+ (void)processServiceRequestImage:(NSDictionary *)dictReqParameters
                   requestImageKey:(NSString *)requestImageKey
                  requestImageData:(NSArray *)requestImageData
                        requestURL:(NSString *)requestURL
                     progressBlock:(void (^)(NSProgress *uploadProgress))progressBlock
                      successBlock:(void (^)(id responseObject))successBlock
                      failureBlock:(void (^)(NSError *error))failureBlock{
    AFHTTPSessionManager * manager = [HLNetWorkTool shareSessionManager];
    NSURLSessionDataTask *session;
    session = [manager POST:requestURL parameters:dictReqParameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for ( int i = 0; i < requestImageData.count; i++) {
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat=@"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
            UIImage *image = requestImageData[i];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.28);
            [formData appendPartWithFileData:imageData name:requestImageKey fileName:fileName mimeType:@"image/jpeg"];
            NSLog(@"Actual image size %ld \n uploaded image size %ld", (unsigned long)[ UIImageJPEGRepresentation(image, 1) length], (unsigned long)[imageData length]);
            NSLog(@"上传前图片%@，压缩后图片大小%@", [self transformedValue:[ UIImageJPEGRepresentation(image, 1) length]],[self transformedValue: [imageData length]]);
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progressBlock(uploadProgress);
    }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"AF Net succ block for \n URL: %@ \n Parameters: %@", requestURL, dictReqParameters);
        NSLog(@"Response Dictionary [%@]",responseObject);
        [[self allTasks] removeObject:task];
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"AF Net fail block - error[%@]",[error localizedDescription]);
        failureBlock(error);
        [[self allTasks] removeObject:task];
    }];
    
    if (session) {
        [[self allTasks] addObject:session];
    }
 
}
 
+ (id)transformedValue:(double)value
{
    double convertedValue = value;
    int multiplyFactor = 0;
     NSArray *tokens = [NSArray arrayWithObjects:@"bytes",@"KB",@"MB",@"GB",@"TB",@"PB", @"EB", @"ZB", @"YB",nil];
     while (convertedValue > 1024) {
        convertedValue /= 1024;
        multiplyFactor++;
    }
    
    return [NSString stringWithFormat:@"%4.2f %@",convertedValue, [tokens objectAtIndex:multiplyFactor]];
}


/**
 *  取消所有请求
 */
+ (void)cancelAllRequest{
    @synchronized(self) {
        [[self allTasks] enumerateObjectsUsingBlock:^(NSURLSessionDataTask * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task isKindOfClass:[NSURLSessionDataTask class]]) {
                [task cancel];
            }
        }];
        [[self allTasks] removeAllObjects];
    };
}

/**
 *  根据url取消请求
 *
 *  @param url 请求url
 */
+ (void)cancelRequestWithURL:(NSString *)url{
    @synchronized(self) {
        [[self allTasks] enumerateObjectsUsingBlock:^(NSURLSessionDataTask * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task isKindOfClass:[NSURLSessionDataTask class]]
                && [task.currentRequest.URL.absoluteString hasSuffix:url]) {
                [task cancel];
                [[self allTasks] removeObject:task];
                return;
            }
        }];
    };
}

#pragma 任务管理
+ (NSMutableArray *)allTasks {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (requestTasks == nil) {
            requestTasks = [[NSMutableArray alloc] init];
        }
    });
    return requestTasks;
}

/**
 * 打印请求接口
 */
+ (NSString *)logTheRequsetUrl:(NSString *)url
                  params:(NSDictionary *)params{
    NSString *getUrl = [NSString stringWithFormat:@"%@?", url];
    for (NSString *key in [params allKeys]) {
        getUrl = [getUrl stringByAppendingFormat:@"%@=%@&", key, [params objectForKey:key]];
    }
    return [getUrl substringToIndex:getUrl.length - 1];
}
 

@end
