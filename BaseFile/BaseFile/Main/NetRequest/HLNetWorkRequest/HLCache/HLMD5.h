//
//  HLMD5.h
//  NetWork封装
//
//  Created by liuhao on 2018/5/2.
//  Copyright © 2018年 liuhao All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLMD5 : NSObject
/**
 *  md5加密
 *
 *  @param inPutText 需要加密的字符串
 *
 *  @return 加密好的字符串
 */
+ (NSString *)md5:(NSString *)inPutText;
@end
