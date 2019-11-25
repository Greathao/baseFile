//
//  HLRequsetCache.h
//  WashCallManger
//
//  Created by liuhao on 2018/4/19.
//  Copyright © 2018年 北京海狸先生网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLRequsetCache : NSObject

///**
// 缓存的有效期  单位是s
// */
//#define Cache_Expire_Time (3600*24)

/**
 *  沙盒Cache路径
 */
#define CachePath ([NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject])
 
///判断是否有缓存及缓存是否到期
+(void)JudgeisCacheTime:(NSTimeInterval)seconds fileName:(NSString*)fileName   CacheNULLOrOverdueBlock:(void (^)(void))CancheNULL
haveCacheBlock:(void (^) (id Cache))haveCacheBlock;


///获取缓存路径  根据 自己存的格式化转换格式化  
+(NSString*)greatCache:(NSString*)fileName;

///存入缓存
+(void)goCacheData:(id)data fileName:(NSString*)fileName;

///判断缓存文件是否过期
+ (BOOL)isExpire:(NSString *)fileName :(NSTimeInterval)time;

///是否有缓存
+(BOOL)isCache:(NSString*)fileName;
 
/// 清空缓存
+(void)clearCache;

/**
 *  获取缓存的大小
 *
 *  @return 缓存的大小  单位是B
 */
+ (NSUInteger)getSize;

@end
