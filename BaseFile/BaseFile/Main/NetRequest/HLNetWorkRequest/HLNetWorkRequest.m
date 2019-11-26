//
//  HLNetWorkRequest.m
//  NetWork封装
//
//  Created by liuhao on 2018/5/2.
//  Copyright © 2018年 liuhao All rights reserved.
//

#import "HLNetWorkRequest.h"

@implementation HLNetWorkRequest
///默认缓存时间
static  NSTimeInterval _cacheTime = kTimeCache;
static  NSTimeInterval  _reqtime = 30;
#pragma mark ------------- 类属性时间setget
+(NSTimeInterval)cacheTime{
    return _cacheTime;
}

+(void)setCacheTime:(NSTimeInterval)time{
    if (time!=_cacheTime) _cacheTime = time;
}

#pragma mark ------------- 类属性reqtime setget

+(NSTimeInterval)reqtime{
    return _reqtime;
}

+(void)setReqtime:(NSTimeInterval)reqtime
{
    if (reqtime!=_reqtime) _reqtime = reqtime;
}


#pragma ---
#pragma mark ------------- 返回参数data字段转模型 及 code解析配置
///返回数据转模型
+(void)dataFormatConversion:(id)responseObject
                 ModalClass:(Class)modlclass
               SuccessBlock:(HLNetWorkSuccessBlock)successBlock
               failureBlock:(HLNetWorkfailureBlock)failureBlock{
    //    /// 这种情况抛网络异常
    //    if ([responseObject[OUTPUT_PARAM_RETCODE] isEqualToString:ANOTHER_TIMEOUT_RELOAD_CODE]){
    //        failureBlock(HLNetworkErrorTypeError,@"超时请重新加载");
    //        return;
    //    }
    //    ///这种情况去去跳转登录
    //    if ([responseObject[OUTPUT_PARAM_RETCODE] isEqualToString:ANOTHER_DEVICE_LOGIN_CODE]){
    //#warning  这种情况去去跳转登录
    //        [HLNetWorkTool goToLogin];
    //        return;
    //    }
    ///如果没有传模型 不需要格式化 返回接口格式
    if (!modlclass) {
        id jsonData = responseObject[OUTPUT_PARAM_DATA];
        successBlock(jsonData);
        
        [self judgeDataformat:jsonData SuccessBlock:successBlock failureBlock:failureBlock];
        return;
    }
    
    /// 进行数据格式化转modl 并且判断是否为空
    NSDictionary * dic = [HLNetWorkTool formatJSONToDataModal:responseObject
                                                   modalClass:modlclass];
    [self judgeDataformat:dic SuccessBlock:successBlock failureBlock:failureBlock];
    
    
}
///判断data格式
+(void)judgeDataformat:(id)data  SuccessBlock:(HLNetWorkSuccessBlock)successBlock
          failureBlock:(HLNetWorkfailureBlock)failureBlock{
    
    if ([data isKindOfClass:[NSArray class]]){
        NSArray * arr = data;
        if (arr.count>0){
            successBlock(arr);
        }else{
            failureBlock(HLNetworkErrorTypeNULL,@"数据为空");
        }
    }else if ([data isKindOfClass:[NSDictionary class]]){
        NSDictionary * dic = data;
        if (dic.count>0){
            successBlock(dic);
        }else{
            failureBlock(HLNetworkErrorTypeNULL,@"数据为空");
        }
    }else {
        successBlock(data);
    }
    
}

#pragma ---
#pragma mark -------------根据不同缓存策略配置缓存名字
///根据不同缓存策略 配置 缓存的名字
+(NSString*)getfileName:(NSString*)url
             addParamet:(NSDictionary*)addPara
           nitialParamt:(NSDictionary*)para
                  Cache:(HLCacheType)cacheType{
    
    NSString * fileName = nil;
    
    switch (cacheType){
        case HLCacheTypeUser:
        {
            NSMutableDictionary * dicMut = [addPara mutableCopy];
            ///保留tokenID其他删除
            for (NSString * key in addPara.allKeys) {
                if (![key isEqualToString:KEY_TOKEN_ID]) {
                    [dicMut removeObjectForKey:key];
                }
                
            }
            
            fileName= [HLNetWorkTool fileName:url
                                       params:dicMut];
            return fileName;
        }
        case HLCacheTypeGeneral:
        case HLCacheTypeFirstCancalThenReq:
        {
            fileName=[ HLNetWorkTool fileName:url
                                       params:para];
            return fileName;
        }
        case HLCacheTypeNULL:
        {
            return fileName;
        }
    }
}

#pragma ---
#pragma mark ------------- get请求
+(void)getServersUrl:(NSString*)url
           Parameter:(NSDictionary*)para
          ModalClass:(Class)modal
               Cache:(HLCacheType)cacheType
        SuccessBlock:(HLNetWorkSuccessBlock)successBlock
        failureBlock:(HLNetWorkfailureBlock)failureBlock{
    
    [self serversRequsetAsCacheAsCifgUrl:url
                               Parameter:para
                              ModalClass:modal
                                   Cache:cacheType
                                  isPost:NO
                            SuccessBlock:successBlock
                            failureBlock:failureBlock];
}

#pragma ---
#pragma mark ------------- post请求
+(void)postServersUrl:(NSString*)url
            Parameter:(NSDictionary*)para
           ModalClass:(Class)modal
                Cache:(HLCacheType)cacheType
         SuccessBlock:(HLNetWorkSuccessBlock)successBlock
         failureBlock:(HLNetWorkfailureBlock) failureBlock{
    [self serversRequsetAsCacheAsCifgUrl:url
                               Parameter:para
                              ModalClass:modal
                                   Cache:cacheType
                                  isPost:YES
                            SuccessBlock:successBlock
                            failureBlock:failureBlock];
}

///数据请求参数 及缓存策略  配置
+(void)serversRequsetAsCacheAsCifgUrl:(NSString*)url
                            Parameter:(NSDictionary*)para
                           ModalClass:(Class)modal
                                Cache:(HLCacheType)cacheType
                               isPost:(BOOL)isPost
                         SuccessBlock:(HLNetWorkSuccessBlock)successBlock
                         failureBlock:(HLNetWorkfailureBlock) failureBlock{
    NSDictionary *dic = [HLNetWorkTool additionalRequestUrl:url Parameters:para];
    
    //设置请求时长 默认 30s
    [HLNetWorkTool shareSessionManager].requestSerializer.timeoutInterval =self.reqtime;
    
    
    
    //不同缓存策略 设置不同缓存key
    NSString *fileName = [self getfileName:url
                                addParamet:dic
                              nitialParamt:para
                                     Cache:cacheType];
    
    //需要缓存策略的时候
    if (fileName) {
        //如果缓存已经到期或者没有缓存
        if (![HLRequsetCache isCache:fileName] || [HLRequsetCache isExpire:fileName:self.cacheTime]){
            [self processServiceRequestDistinguish:dic
                                        requestURL:url
                                        ModalClass:modal
                                          fileName:fileName
                                            isPost:isPost
                                           isCache:YES
                                      successBlock:successBlock
                                      failureBlock:failureBlock];
            
        }else{
            //格式化及code 拦截判断
            NSDictionary * dict = [[NSDictionary alloc] initWithContentsOfFile:[HLRequsetCache greatCache:fileName]];
            [self dataFormatConversion:dict
                            ModalClass:modal
                          SuccessBlock:successBlock
                          failureBlock:failureBlock];
            //此缓存策略 先返回缓存策略 再去请求接口返回最新数据
            if (HLCacheTypeFirstCancalThenReq == cacheType) {
                
                [self processServiceRequestDistinguish:dic
                                            requestURL:url
                                            ModalClass:modal
                                              fileName:fileName
                                                isPost:isPost
                                               isCache:YES
                                          successBlock:successBlock
                                          failureBlock:failureBlock];
            }
            
            
        }
    }else{
        
        [self processServiceRequestDistinguish:dic
                                    requestURL:url
                                    ModalClass:modal
                                      fileName:fileName
                                        isPost:isPost
                                       isCache:NO
                                  successBlock:successBlock
                                  failureBlock:failureBlock];
        
        
    }
    ///赋初值
    self.cacheTime = kTimeCache;
    
    self.reqtime = 30;
}

///请求区分
+(void)processServiceRequestDistinguish:(NSDictionary *)dic
                             requestURL:(NSString*)url
                             ModalClass:(Class)modal
                               fileName:(NSString *)fileName
                                 isPost:(BOOL)isPost
                                isCache:(BOOL)isCache
                           successBlock:(HLNetWorkSuccessBlock)successBlock
                           failureBlock:(HLNetWorkfailureBlock)failureBlock{
    if (isPost) {
        // POST
        [self processServiceRequestPost:dic
                             requestURL:url
                             ModalClass:modal
                               fileName:fileName
                                isCache:isCache
                           successBlock:successBlock
                           failureBlock:failureBlock];
    }else{
        // get
        [self processServiceRequestGet:dic
                            requestURL:url
                            ModalClass:modal
                              fileName:fileName
                               isCache:isCache
                          successBlock:successBlock
                          failureBlock:failureBlock];
    }
}

// get请求
+(void)processServiceRequestGet:(NSDictionary *)dic
                     requestURL:(NSString*)url
                     ModalClass:(Class)modal
                       fileName:(NSString *)fileName
                        isCache:(BOOL)isCache
                   successBlock:(HLNetWorkSuccessBlock)successBlock
                   failureBlock:(HLNetWorkfailureBlock)failureBlock{
    
    [HLNetWorking processServiceRequestGet:dic
                                requestURL:url
                              successBlock:^(id responseObject){
        // 格式化及code 拦截判断
        [self dataFormatConversion:responseObject
                        ModalClass:modal
                      SuccessBlock:successBlock
                      failureBlock:failureBlock];
        if (isCache) {
            //存入缓存
            [HLRequsetCache goCacheData:responseObject
                               fileName:fileName];
        }
        
    } failureBlock:^(NSError *error) {
        failureBlock(HLNetworkErrorTypeError,error.localizedDescription);
    }];
    
}

// post请求
+(void)processServiceRequestPost:(NSDictionary *)dic
                      requestURL:(NSString*)url
                      ModalClass:(Class)modal
                        fileName:(NSString *)fileName
                         isCache:(BOOL)isCache
                    successBlock:(HLNetWorkSuccessBlock)successBlock
                    failureBlock:(HLNetWorkfailureBlock)failureBlock{
    
    [HLNetWorking processServiceRequestPost:dic
                                 requestURL:url
                               successBlock:^(id responseObject){
        //格式化及code 拦截判断
        [self dataFormatConversion:responseObject
                        ModalClass:modal
                      SuccessBlock:successBlock
                      failureBlock:failureBlock];
        if (isCache) {
            //存入缓存
            [HLRequsetCache goCacheData:responseObject
                               fileName:fileName];
        }
        
    } failureBlock:^(NSError *error){
        failureBlock(HLNetworkErrorTypeError,error.localizedDescription);
    }];
    
}

+(void)imageServers:(NSDictionary *)dicReqParameters
    requestImageKey:(NSString *)requestImageKey
   requestImageData:(NSArray *)requestImageData
         requestURL:(NSString *)requestURL
      progressBlock:(HLUploadProgressBlock)progressBlock
       successBlock:(HLNetWorkSuccessBlock)successBlock
       failureBlock:(HLNetWorkfailureBlock)failureBlock;
{
    NSDictionary * dic = [HLNetWorkTool additionalRequestUrl:requestURL Parameters:dicReqParameters];
    [HLNetWorking processServiceRequestImage:dic requestImageKey:requestImageKey requestImageData:requestImageData requestURL:requestURL progressBlock:^(NSProgress *uploadProgress) {
        progressBlock(uploadProgress.totalUnitCount, uploadProgress.completedUnitCount);
    } successBlock:^(id responseObject) {
        [self dataFormatConversion:responseObject
                        ModalClass:nil
                      SuccessBlock:successBlock
                      failureBlock:failureBlock];
    } failureBlock:^(NSError *error) {
        failureBlock(HLNetworkErrorTypeError,error.localizedDescription);
    }];
}






@end
