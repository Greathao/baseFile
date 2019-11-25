
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "sys/utsname.h"
#define NUMBERS @"0123456789\n"
/*!
 *  正则验证
 */
@interface ValidateHelper : NSObject

/**
 *  判断设备
 *
 *  @return <#return value description#>
 */
+ (NSString *)deviceString;

#pragma mark - 验证输入是否为数字
/**
 *  验证输入是否为数字
 *
 *  @param number 要验证的字符串
 *
 *  @return BOOL
 */
+ (BOOL)isValidateNumber:(NSString *)number;

#pragma mark - 验证手机号码格式
/**
 *  验证手机号码格式
 *
 *  @param mobile 要验证的字符串
 *
 *  @return BOOL
 */
+ (BOOL)isValidateMobile:(NSString *)mobile;


#pragma mark - 验证手机号码格式
/**
 *  验证手机号码格式
 *
 *  @param mobile 根据后台正则验证手机号
 *
 *  @return BOOL
 */
+ (BOOL)isValidateMobileWithRegular:(NSString*)regular withMobile:(NSString *)mobile;




#pragma mark - 验证昵称  4- 15位
/**
 *  验证验证昵称
 *
 *  @param nikeName 根据后台正则验证手机号
 *
 *  @return BOOL
 */
+ (BOOL)isValidateNikeName:(NSString*)nikeName;

/**
 *  验证金钱格式
 *
 *  @param money 要验证的字符串
 *
 *  @return BOOL
 */
+ (BOOL)checkMoney:(NSString *)money;

/**
 *  验证座机号码格式
 *
 *  @param number 要验证的字符串
 *
 *  @return BOOL
 */
+ (BOOL)checkNumber:(NSString *)number;

#pragma mark - 验证邮箱格式
/**
 *  验证邮箱格式
 *
 *  @param email 要验证的字符串
 *
 *  @return BOOL
 */
+ (BOOL)isValidateEmail:(NSString *)email;

#pragma mark - 验证密码格式
/**
 *  验证密码格式
 *
 *  @param password 要验证的字符串
 *
 *  @return BOOL
 */
+ (BOOL)isValidatePassword:(NSString *)password;

#pragma mark - 验证double
/**
 *  验证double
 *
 *  @param doubleStr 要验证的字符串
 *
 *  @return BOOL
 */
+ (BOOL)isValidateDoubleStr:(NSString *)doubleStr;

#pragma mark - 验证身份证
/**
 *  验证身份证
 *
 *  @param identityCard 要验证的字符串
 *
 *  @return BOOL
 */
+ (BOOL) validateIdentityCard:(NSString *)identityCard;

#pragma mark - 转换时间戳
/**
 *  转换时间戳
 *
 *  @param timeDouble 时间
 *
 *  @return 时间戳
 */
+(NSString *) dateFromDouble:(double)timeDouble;

/**
 *获取不同屏幕的view高度
 */
+ (CGFloat)viewHeightNormal;
+ (CGFloat)viewHeightAndAddNum:(CGFloat)num;
+ (CGFloat)viewHeightWithIphone5:(CGFloat)iphone5 iphone6:(CGFloat)iphone6 iphone6p:(CGFloat)iphone6p;

#pragma mark - 排除无效数据
+(id)isValueNull:(id)value;

+(NSString *)judgeisNSStringNull:(id)value TypeCode:(NSInteger)typeCode;

#pragma mark - label
+(NSAttributedString *)LabelColorCombinationsWithValues1:(NSString *)values1 Values2:(NSString *)values2 Values3:(NSString *)values3;


#pragma mark - imageBase64解码

+(UIImage *)withBase64Str:(NSString*)str;

/**
 *  MD5 一次
 *
 *  @param inPutText 要加密的字符串
 *
 *  @return 加密后的字符串
 */
+(NSString *)md5: (NSString *) inPutText;
#pragma mark -3次MD5加密
/**
 *  MD5 3次
 *
 *  @param str 要加密的字符串
 *
 *  @return 加密后的字符串
 */
+ (NSString *)myThreedMD5:(NSString *)str;

#pragma mark - 判断图片地址 有无http打头字符
+(BOOL)isHttpHead:(NSString *)urlStr;

#pragma mark -- 打印 组装http链接
+(void)httpgetUrlWithDic:(NSMutableDictionary *)tempDic httpUrlHead:(NSString *)httpUrlHead;

//NSString转换为NSData
+(NSData *)stringToData:(NSString *)str;

//NSData转换为NSString
+(NSString *)dataToString:(NSData *)data;

//NSData转换为char
//+(char *)dataToChar:(NSData *)data;

//char转换为NSData
+(NSData *)charToData:(Byte *)byte;

//由 NSDate 转换为 NSString:
+(NSString *)dateToString:(NSDate *)theDate FormatterStr:(NSString *)formatterStr;

//由 NSString 转换为 NSDate:
+(NSDate *)stringToDate:(NSString *)dateStr FormatterStr:(NSString *)formatterStr;

//时间戳 转 时间格式字符串
+(NSString *)doubleConvertDate:(double)timeDouble FormatterStr:(NSString *)formatterStr;

//6位随机数验证码
+ (int)randomCode;

//计算字符串固定宽度的高
+ (CGSize)sizeOfText:(NSString *)text theFont:(UIFont*)font theWidth:(float)width;

//计算字符串宽高
+ (CGSize)sizeOfText:(NSString *)text theFont:(UIFont*)font;

+ (void)hideTabBar:(UITabBarController *) tabbarcontroller;
+ (void)showTabBar:(UITabBarController *) tabbarcontroller;

//////////////   获取沙盒路径  ///////////////////////
// 获取沙盒Document的文件目录
+ (NSString *)getDocumentDirectory;

// 获取沙盒Library的文件目录
+ (NSString *)getLibraryDirectory;

// 获取沙盒Library/Caches的文件目录
+ (NSString *)getCachesDirectory;

// 获取沙盒Preference的文件目录
+ (NSString *)getPreferencePanesDirectory;

// 获取沙盒tmp的文件目录
+ (NSString *)getTmpDirectory;

// 根据路径返回目录或文件的大小
+ (double)sizeWithFilePath:(NSString *)path;

// 得到指定目录下的所有文件
+ (NSArray *)getAllFileNames:(NSString *)dirPath;

// 删除指定目录或文件
+ (BOOL)clearCachesWithFilePath:(NSString *)path;

// 清空指定目录下文件
+ (BOOL)clearCachesFromDirectoryPath:(NSString *)dirPath;


/**
 相隔多少天没有打开应用就通过本地通知提示用户重新打开应用
 
 @param day 相隔的天数
 @param message 提示的内容
 @param alertTitle 提示的标题【iOS8.2以上】
 */
+ (void)RemindUserWithNotficationAfterAFewDays:(NSInteger)day
                              AndRemindMessage:(NSString *)message
                                AndRemindTitle:(NSString *)alertTitle;


/**
 根据APPID异步检查至苹果商店更新,
 如果本地版本号比商店应用版本号小就弹出更新窗口，只有更新按钮
 @param AppID APPID
 */
+ (void)CheckTheUpdateWithAppID:(NSString *)AppID;

/**
 用户使用两周后再打开应用提示去评价，根据APPID跳转应用市场
 
 @param AppID AppID
 */
+ (void)GotoEvaluateWithAppID:(NSString *)AppID;

/*!
 @brief 判断是否是第一次启动
 */
+ (BOOL)isFirstBuldVesion;

 @end
