//
//  CommonFunc.h
//  base64加密
//
//  Created by liuhao on 16/4/26.
//  Copyright © 2016年 刘浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DesFunc : NSObject

/**
 *  des解密  默认加密key:   
 *  @param cipherText des加密串
 *  @return 解密
 */
+(NSString*) decryptUseDES:(NSString*)cipherText;
/**
 *  des解密  key自定义
 *  @param cipherText 加密串
 *  @param key        key
 *  @return 解密串
 */
+(NSString*) decryptUseDES:(NSString*)cipherText key:(NSString*)key;

/**
 *  des加密 默认加密key:    
 *  @param clearText  需要加密的串
 *  @return 加密后的串
 */
+(NSString *) encryptUseDES:(NSString *)clearText;
/**
 *  des解密  key自定义
 *  @param clearText 需要加密的串
 *  @param key        key
 *  @return 加密后的串
 */
+(NSString *) encryptUseDES:(NSString *)clearText key:(NSString *)key;


/**
 *  md5加密
 *
 *  @param inPutText
 *
 *  @return
 */
+(NSString *) md5: (NSString *) inPutText;

/**
 *  传进签名集合return MD5后的串
 *
 *  @param dic 需要签名的集合
 *
 *  @return MD5签名后
 */
+(NSString *)SignAPi:(NSDictionary *)dic;

@end
