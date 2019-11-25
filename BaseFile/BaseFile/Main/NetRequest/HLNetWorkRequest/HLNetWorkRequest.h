//
//  HLNetWorkRequest.h
//  NetWork封装
//
//  Created by liuhao on 2018/5/2.
//  Copyright © 2018年 Beijing Mr Hi Network Technology Company Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "HLNetWorking.h"
#import "HLRequsetCache.h"
#import "HLNetWorkTool.h"
///默认缓存时间
#define  kTimeCache  60*60*24

typedef NS_ENUM(NSInteger,HLCacheType){
    ///不缓存
    HLCacheTypeNULL,
    
    ///根据用户缓存 根据用户习惯缓存必须登录 缓存key和tokeid有关 (在默认缓存时间内返回缓存 超过了请求最新数据)
    HLCacheTypeUser ,
    
    ///通用缓存 (在默认缓存时间内返回缓存 超过了请求最新数据)
    HLCacheTypeGeneral,
    
    ///有缓存先返回缓存再去请求接口请求成功展示替换缓存展示数据 ，存入最新缓存 请求失败展示缓存数据。
    HLCacheTypeFirstCancalThenReq,

};

typedef NS_ENUM(NSInteger,HLNetworkErrorType){
    ///网络错误
    HLNetworkErrorTypeError,
    ///数据为空
    HLNetworkErrorTypeNULL,
};

/**
 *  成功
 */
typedef void(^HLNetWorkSuccessBlock)(id responseObject);

/**
 *  失败
 */
typedef void(^HLNetWorkfailureBlock)(HLNetworkErrorType type, NSString *  error);

/**
 *  进度
 *
 *  @param bytesRead              已下载或者上传进度的大小
 *  @param totalBytes             总下载或者上传进度的大小
 */
typedef void(^HLUploadProgressBlock)(int64_t bytesRead,
                                     int64_t totalBytes);

@interface HLNetWorkRequest : NSObject

/**
 *  此属性只有需要缓存策略的时候有用
 *  设置缓存时间 默认缓存一天时间
 */
@property(class,nonatomic,assign) NSTimeInterval cacheTime;

 
/**
 *  网络请求时长
 *  不set此属性 默认是 30s
 *
 */
@property(class,nonatomic,assign) NSTimeInterval reqtime;



 ///get
+(void)getServersUrl:(NSString*)url
           Parameter:(NSDictionary*)para
          ModalClass:(Class)modal
               Cache:(HLCacheType)cacheType
        SuccessBlock:(HLNetWorkSuccessBlock)successBlock
        failureBlock:(HLNetWorkfailureBlock)failureBlock;

///post
+(void)postServersUrl:(NSString*)url
            Parameter:(NSDictionary*)para
           ModalClass:(Class)modal
                Cache:(HLCacheType)cacheType
         SuccessBlock:(HLNetWorkSuccessBlock)successBlock
         failureBlock:(HLNetWorkfailureBlock) failureBlock;


+(void)imageServers:(NSDictionary *)dicReqParameters
    requestImageKey:(NSString *)requestImageKey
   requestImageData:(NSArray *)requestImageData
         requestURL:(NSString *)requestURL
      progressBlock:(HLUploadProgressBlock)progressBlock
       successBlock:(HLNetWorkSuccessBlock)successBlock
       failureBlock:(HLNetWorkfailureBlock)failureBlock;
 

 


@end
