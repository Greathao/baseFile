//
//  HLRequsetCache.m
//  WashCallManger
//
//  Created by liuhao on 2018/4/19.
//  Copyright © 2018年 北京海狸先生网络科技有限公司. All rights reserved.
//

#import "HLRequsetCache.h"
#import "HLMD5.h"

@implementation HLRequsetCache

///判断是否有缓存及缓存是否到期
+(void)JudgeisCacheTime:(NSTimeInterval)seconds
               fileName:(NSString*)fileName
CacheNULLOrOverdueBlock:(void (^)(void))CancheNULL
         haveCacheBlock:(void (^) (id Cache))haveCacheBlock;
{
    if (seconds<3) {
        CancheNULL();
        return;
    }
    NSString *path = [CachePath stringByAppendingPathComponent:[HLMD5 md5:fileName]];
    NSData * data = [[NSData alloc] initWithContentsOfFile:path];
    if (data.length&&![self isExpire:fileName :seconds]) {
        haveCacheBlock(data);
    }else{
        CancheNULL();
    }
}

///获取缓存
+(NSString*)greatCache:(NSString*)fileName;{
    NSString *path = [CachePath stringByAppendingPathComponent:[HLMD5 md5:fileName]];
//    NSData * data = [[NSData alloc] initWithContentsOfFile:path];
    return path;
}
///是否有缓存
+(BOOL)isCache:(NSString*)fileName;{
    NSString *path = [CachePath stringByAppendingPathComponent:[HLMD5 md5:fileName]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:path];
    NSLog(@"这个文件已经存在：%@",result?@"是的":@"不存在");
    return result;
};

+(void)goCacheData:(id)data fileName:(NSString*)fileName;
{
    if (!data) {
        return;
    }
    NSString *path = [CachePath stringByAppendingPathComponent:[HLMD5 md5:fileName]];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [data writeToFile:path atomically:YES];
    });
}
    
+(void)clearCache;{
     NSFileManager *fm = [NSFileManager defaultManager];
     NSDirectoryEnumerator *fileEnumerator = [fm enumeratorAtPath:CachePath];
    for (NSString *fileName in fileEnumerator) {
        NSString *filePath = [CachePath stringByAppendingPathComponent:fileName];
        [fm removeItemAtPath:filePath error:nil];
        
    }
    
}
+ (BOOL)isExpire:(NSString *)fileName :(NSTimeInterval)time;
{

    
    NSString *path = [CachePath stringByAppendingPathComponent:[HLMD5 md5:fileName]];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSDictionary *attributesDict = [fm attributesOfItemAtPath:path error:nil];
    NSDate *fileModificationDate = attributesDict[NSFileModificationDate];
    NSTimeInterval fileModificationTimestamp = [fileModificationDate timeIntervalSince1970];
    //现在的时间戳
    NSTimeInterval nowTimestamp = [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970];
    
    NSLog(@"缓存时间:%fs:::: %@",time,(nowTimestamp-fileModificationTimestamp)>time?@"时间过期":@"时间没过期");
    return ((nowTimestamp-fileModificationTimestamp)>time);
    
}

+ (NSUInteger)getAFNSize
{
    NSUInteger size = 0;
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSDirectoryEnumerator *fileEnumerator = [fm enumeratorAtPath:CachePath];
    for (NSString *fileName in fileEnumerator) {
        NSString *filePath = [CachePath stringByAppendingPathComponent:fileName];
        NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        size += [attrs fileSize];
    }
    return size;
}

+ (NSUInteger)getSize
{
    //获取AFN的缓存大小
    NSUInteger afnSize = [self getAFNSize];
    return afnSize;
}


@end
