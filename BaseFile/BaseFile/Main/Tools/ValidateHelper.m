

#import "ValidateHelper.h"
#import "CommonCrypto/CommonDigest.h"


NSString *const NotificationID = @"RemindUser";

@interface ValidateHelper ()


@end

@implementation ValidateHelper


+(UIImage *)withBase64Str:(NSString *)str{
    NSData *decodedImageData = [[NSData alloc]
                                initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    UIImage *decodedImage = [UIImage imageWithData:decodedImageData];
    return decodedImage;
}


#pragma mark - iPhone设备
+ (NSString *)deviceString{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return platform;
}

#pragma mark - 验证输入是否为数字
+ (BOOL)isValidateNumber:(NSString *)number{
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
    NSString *filtered = [[number componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [number isEqualToString:filtered];
    if(!basicTest)
    {
        return NO;
    }
    return YES;
}

#pragma mark - 验证手机号码格式
+ (BOOL)isValidateMobile:(NSString *)mobile
{
    //    NSString *phoneRegex = @"^(13[0-9]|15[0|1|2|3|5|6|7|8|9]|18[0-9]|17[0|6|7|8]|14[4|7])\\d{8}$";
//    NSString *phoneRegex = @"^(13[0-9]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9]|17[0|1|2|3|5|6|7|8|9]|14[0|1|2|3|5|6|7|8|9])\\d{8}$";
//    NSPredicate *tempPhone = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
//    return [tempPhone evaluateWithObject:mobile];
    
    
    NSArray * regexArray = @[@"^[1][0-9]{10}$",
                             
//                             ^(13[0-9]\d{8}$
                             @"^[1][0-9]{2}[-][0-9]{4}[-][0-9]{4}$",
                             @"^[+][8][6][1][0-9]{10}$",
                             @"^[8][6][1][0-9]{10}$"];
    for (NSString * regex in regexArray) {
        NSPredicate* pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        BOOL isMatch = [pred evaluateWithObject:mobile];
        if (isMatch) {
            return isMatch;
        }
    }
    return NO;
    
}

+ (BOOL)isValidateMobileWithRegular:(NSString*)regular withMobile:(NSString *)mobile;
{
    NSPredicate *checktest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regular];
    BOOL isValidate = NO;
    BOOL isCath = NO;
    @try {
        // 可能会出现崩溃的代码
        isValidate = [checktest evaluateWithObject:mobile];
    } @catch (NSException *exception) {
        // 捕获到的异常exception
        isCath = YES;
    } @finally {
        // 有没有异常都会走
        if (isCath) {
            return [self isValidateNumber:mobile];
        }else{
            return isValidate;
        }
    }
}

+(NSUInteger)textLength: (NSString *) text{
    
    NSUInteger asciiLength = 0;
    
    for (NSUInteger i = 0; i < text.length; i++) {
        
        
        unichar uc = [text characterAtIndex: i];
        
        asciiLength += isascii(uc) ? 1 : 2;
    }
    
    NSUInteger unicodeLength = asciiLength;
    
    return unicodeLength;
    
}
+ (BOOL)isValidateNikeName:(NSString*)nikeName;
{
    NSInteger len =[self textLength:nikeName];
    
    if (len >= 4 && len <= 15) {
        return YES;
    }
     return NO;
}



/**
 *  验证金钱格式
 *
 *  @param money 要验证的字符串
 *
 *  @return BOOL
 */
+ (BOOL)checkMoney:(NSString *)money{
    NSPredicate * predicate0 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^[0][0-9]+$"];
    //匹配两位小数、整数限定字符串为8位（不包括小数部分）
    NSPredicate * predicate1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^\\d{1,8}(\\.\\d{0,2})?$"];
    
    return ![predicate0 evaluateWithObject:money] && [predicate1 evaluateWithObject:money];
}

#pragma mark - 验证座机格式
+ (BOOL)checkNumber:(NSString *)number{
    
    //验证输入的固话中不带 "-"符号
    
//    NSString * strNum = @"^(0[0-9]{2,3})?([2-9][0-9]{6,7})+(-[0-9]{1,4})?$|(^(13[0-9]|15[0|3|6|7|8|9]|18[8|9])\\d{8}$)";
    
    //验证输入的固话中带 "-"符号
    
    NSString * strNum = @"^(0[0-9]{2,3}-)?([2-9][0-9]{6,7})+(-[0-9]{1,4})?$|(^(13[0-9]|15[0|3|6|7|8|9]|18[8|9])\\d{8}$)";
    
    NSPredicate *checktest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strNum];
    
    return [checktest evaluateWithObject:number];
}

#pragma mark - 验证邮箱格式
+ (BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *tempEmail = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [tempEmail evaluateWithObject:email];
}

#pragma mark - 验证密码格式
+ (BOOL)isValidatePassword:(NSString *)password
{
    // 最少6位的字母或数字 不能为纯数字
//    NSString *emailRegex = @"^(?![A-Z]*$)(?![a-z]*$)(?![0-9]*$)(?![^a-zA-Z0-9]*$)\\S+$";
    //6-20位数字和字母组成
//    NSString *emailRegex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$";
//    NSString *emailRegex = @"(?=.*[a-zA-Z])(?=.*[0-9])[0-9A-Za-z+-@_=*]{6,16}";
//    NSPredicate *tempPassword = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
//    return [tempPassword evaluateWithObject:password];
    
    // 大于等于 6  小于等于18
    if (password.length >= 6  && password.length <= 18) {
        return YES;
    }
    return NO;
    
}

#pragma mark - 验证double
+ (BOOL)isValidateDoubleStr:(NSString *)doubleStr
{
    NSString *emailRegex = @"^([0-9.]+)$";
    NSPredicate *tempPassword = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [tempPassword evaluateWithObject:doubleStr];
}

#pragma mark - 验证身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

+(id)isValueNull:(id)value{
    if ([value isKindOfClass:[NSNull class]] || value == nil || value == NULL) {
        return nil;
    }else{
        return value;
    }
}

#pragma mark - 验证数据是否无效 如果无效返回默认类型数据
+(NSString *)judgeisNSStringNull:(id)value TypeCode:(NSInteger)typeCode{
    NSString *string = [NSString stringWithFormat:@"%@",value];
    if (string == nil || string == NULL || [string isEqualToString:@"<null>"]|| [string isEqualToString:@"(null)"]) {
        if (typeCode == 1)
            return @"";
        else if (typeCode == 2)
            return @"0";
    }
    if ([string isKindOfClass:[NSNull class]]) {
        if (typeCode == 1)
            return @"";
        else if (typeCode == 2)
            return @"0";
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        if (typeCode == 1)
            return @"";
        else if (typeCode == 2)
            return @"0";
    }
    if (typeCode == 1)
        return string;
    else if (typeCode == 2)
        return [NSString stringWithFormat:@"%.1f",[value floatValue]];
    else
        return @"";
}

+(NSString *) dateFromDouble:(double)timeDouble
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    
    NSDate *tempEnd = [NSDate dateWithTimeIntervalSince1970:timeDouble];
    NSString *tempStr = [formatter stringFromDate:tempEnd];
    return tempStr;
}

+ (CGFloat)viewHeightNormal{
    return [self viewHeightWithIphone5:Iphone5Height iphone6:Iphone6Height iphone6p:Iphone6pHeight];
}
+ (CGFloat)viewHeightAndAddNum:(CGFloat)num{
    return [self viewHeightWithIphone5:Iphone5Height+num iphone6:Iphone6Height+num iphone6p:Iphone6pHeight+num];
}

+ (CGFloat)viewHeightWithIphone5:(CGFloat)iphone5 iphone6:(CGFloat)iphone6 iphone6p:(CGFloat)iphone6p{
    if (kScreenWidth < 375.0) {
        return iphone5;
    }else if (kScreenWidth == 375.0){
        return iphone6;
    }
    return iphone6p;
}

#pragma mark - label
+(NSAttributedString *)LabelColorCombinationsWithValues1:(NSString *)values1 Values2:(NSString *)values2 Values3:(NSString *)values3{
    NSMutableAttributedString *tempStr ;
    NSRange range1,range2,range3;
    if (![values3 isEqualToString:@""]) {
        range1.location = 0;
        range1.length = values1.length;
        range2.location = values1.length;
        range2.length = values2.length;
        range3.location = values2.length+values1.length;
        range3.length = values3.length;
        
        tempStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@%@",values1,values2,values3]];
        [tempStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRGB:0xababab] range:NSMakeRange(range1.location,range1.length)];
        [tempStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRGB:0xff5050] range:NSMakeRange(range2.location,range2.length)];
        [tempStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRGB:0xababab] range:NSMakeRange(range3.location,range3.length)];
        [tempStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12] range:NSMakeRange(range1.location,range1.length)];
        [tempStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13] range:NSMakeRange(range2.location,range2.length)];
        [tempStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12] range:NSMakeRange(range3.location,range3.length)];
    }else{
        range1.location = 0;
        range1.length = values1.length;
        range2.location = values1.length;
        range2.length = values2.length;
        range3.location = values2.length;
        range3.length = values3.length;
        
        tempStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",values1,values2]];
        [tempStr addAttribute:NSForegroundColorAttributeName value:UIColor333 range:NSMakeRange(range1.location,range1.length)];
        [tempStr addAttribute:NSForegroundColorAttributeName value:UIColor999 range:NSMakeRange(range2.location,range2.length)];
        [tempStr addAttribute:NSFontAttributeName value:SixteenFontSize range:NSMakeRange(range1.location,range1.length)];
        [tempStr addAttribute:NSFontAttributeName value:FourteenFontSize  range:NSMakeRange(range2.location,range2.length)];
        //[UIFont boldSystemFontOfSize:14]
    }
    
    return tempStr;
}

//3次MD5加密
+ (NSString *)myThreedMD5:(NSString *)str
{
    NSString *str1 = [ValidateHelper md5:str];
    NSString *str2 = [ValidateHelper md5:str1];
    NSString *str3 = [ValidateHelper md5:str2];
    
    return str3;
}

+(NSString *)md5:(NSString *) inPutText
{
    const char *cStr = [inPutText UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    // update MD5 有问题 请更改此处
    //    CC_MD5(cStr, strlen(cStr), result);
    
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}


#pragma mark - 判断图片地址 有无http打头字符
+(BOOL) isHttpHead:(NSString *)urlStr{
    NSRange range = [urlStr rangeOfString:@"http"];
    if (range.length > 1)
        return YES;
    else
        return NO;
}

#pragma mark -- 打印 组装http链接
+(void)httpgetUrlWithDic:(NSMutableDictionary *)tempDic httpUrlHead:(NSString *)httpUrlHead{
#ifdef DEBUG
    NSMutableString *tempStr = [NSMutableString stringWithCapacity:0];
    [tempStr appendFormat:httpUrlHead,nil];
    NSEnumerator * enumeratorKey = [tempDic keyEnumerator];
    for (NSObject *object in enumeratorKey) {
        NSString *tempkey = [NSString stringWithFormat:@"%@",object];
        NSString *tempValue = [NSString stringWithFormat:@"%@",[tempDic objectForKey:tempkey]];
        NSString *tempString = [NSString stringWithFormat:@"%@=%@&",tempkey,tempValue];
        [tempStr appendFormat:tempString,nil];
    }
//    KLog(@"http 请求链接 ＝ %@",tempStr);
#endif
}


#pragma mark - NSString转换为NSData
+(NSData *)stringToData:(NSString *)str
{
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    return data;
}

#pragma mark - NSData转换为NSString
+(NSString *)dataToString:(NSData *)data
{
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return str;
}

////NSData转换为char
//+(char *)dataToChar:(NSData *)data
//{
//    char *myChar = [data bytes];
//    return myChar;
//}

#pragma mark - char转换为NSData
+(NSData *)charToData:(Byte *)byte
{
//    byte = malloc(sizeof(Byte)*16);
    NSData *data = [NSData dataWithBytes:byte length:16];
    return data;
}

#pragma mark - 由 NSDate 转换为 NSString:
+(NSString *)dateToString:(NSDate *)theDate FormatterStr:(NSString *)formatterStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatterStr];
    NSString *dateStr = [dateFormatter stringFromDate:theDate];
    dateFormatter = nil;
    return dateStr;
}

#pragma mark - 由 NSString 转换为 NSDate:
+(NSDate *)stringToDate:(NSString *)dateStr FormatterStr:(NSString *)formatterStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    @"yyyy-MM-dd HH:mm:ss"
    [dateFormatter setDateFormat:formatterStr];
    NSDate *theDate = [dateFormatter dateFromString:dateStr];
    dateFormatter = nil;
    return theDate;
}

#pragma mark - 时间戳 转 时间格式字符串
+(NSString *)doubleConvertDate:(double)timeDouble FormatterStr:(NSString *)formatterStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:formatterStr];
    
    NSDate *tempEnd = [NSDate dateWithTimeIntervalSince1970:timeDouble];
    NSString *tempStr = [formatter stringFromDate:tempEnd];
    formatter = nil;
    return tempStr;
}

#pragma mark - 6位随机数验证码
//由于警告 此处强转double型
+ (int)randomCode
{
    srand((double)time(0));
    int i=rand()%900000+100000;
    return i;
}


//计算字符串固定宽度的高
+ (CGSize)sizeOfText:(NSString *)text theFont:(UIFont*)font theWidth:(float)width{
    CGSize textSize = {width,20000.0f};
    CGSize size;
    
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
    
    size =[text boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    
    return size;
}



//计算字符串宽高
+ (CGSize)sizeOfText:(NSString *)text theFont:(UIFont*)font{
    return [ValidateHelper sizeOfText:text theFont:font theWidth:20000.0f];
}

+(NSString *)aryToString:(NSMutableArray *)ary{
    NSString *b = @"";
    if(ary.count != 0){
        NSMutableString *string = [[NSMutableString alloc]init];
        for (int i = 0; i<ary.count; i++) {
            [string appendFormat:@"%@,",[ary objectAtIndex:i]];
        }
        b = [string substringToIndex:string.length-1];
    }
    return b;
}

+ (void) hideTabBar:(UITabBarController *) tabbarcontroller
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    float fHeight = screenRect.size.height;
    if(UIDeviceOrientationIsLandscape((UIDeviceOrientation)[UIApplication sharedApplication].statusBarOrientation) )
    {
        fHeight = screenRect.size.width;
    }
    
    for(UIView *view in tabbarcontroller.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            [view setFrame:CGRectMake(view.frame.origin.x, fHeight, view.frame.size.width, view.frame.size.height)];
        }
        else
        {
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, fHeight)];
            view.backgroundColor = [UIColor blackColor];
        }
    }
    [UIView commitAnimations];
}

+ (void) showTabBar:(UITabBarController *) tabbarcontroller
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    float fHeight = screenRect.size.height - tabbarcontroller.tabBar.frame.size.height;
    
    if(UIDeviceOrientationIsLandscape((UIDeviceOrientation)[UIApplication sharedApplication].statusBarOrientation) )
    {
        fHeight = screenRect.size.width - tabbarcontroller.tabBar.frame.size.height;
    }
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.1];
    for(UIView *view in tabbarcontroller.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            [view setFrame:CGRectMake(view.frame.origin.x, fHeight, view.frame.size.width, view.frame.size.height)];
        }
        else
        {
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, fHeight)];
        }
    }
    [UIView commitAnimations];
}

// // ///////////////////////////////////


#pragma mark - 获取沙盒Document的文件目录
+ (NSString *)getDocumentDirectory{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

#pragma mark - 获取沙盒Library的文件目录
+ (NSString *)getLibraryDirectory{
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
}

#pragma mark - 获取沙盒Library/Caches的文件目录
+ (NSString *)getCachesDirectory{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

#pragma mark - 获取沙盒Preference的文件目录
+ (NSString *)getPreferencePanesDirectory{
    return [NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES) lastObject];
}

#pragma mark - 获取沙盒tmp的文件目录
+ (NSString *)getTmpDirectory{
    return NSTemporaryDirectory();
}


#pragma mark - 根据路径返回目录或文件的大小
+ (double)sizeWithFilePath:(NSString *)path{
    // 1.获得文件夹管理者
    NSFileManager *manger = [NSFileManager defaultManager];
    
    // 2.检测路径的合理性
    BOOL dir = NO;
    BOOL exits = [manger fileExistsAtPath:path isDirectory:&dir];
    if (!exits) return 0;
    
    // 3.判断是否为文件夹
    if (dir) { // 文件夹, 遍历文件夹里面的所有文件
        // 这个方法能获得这个文件夹下面的所有子路径(直接\间接子路径)
        NSArray *subpaths = [manger subpathsAtPath:path];
        int totalSize = 0;
        for (NSString *subpath in subpaths) {
            NSString *fullsubpath = [path stringByAppendingPathComponent:subpath];
            
            BOOL dir = NO;
            [manger fileExistsAtPath:fullsubpath isDirectory:&dir];
            if (!dir) { // 子路径是个文件
                NSDictionary *attrs = [manger attributesOfItemAtPath:fullsubpath error:nil];
                totalSize += [attrs[NSFileSize] intValue];
            }
        }
        return totalSize / (1024 * 1024.0);
    } else { // 文件
        NSDictionary *attrs = [manger attributesOfItemAtPath:path error:nil];
        return [attrs[NSFileSize] intValue] / (1024.0 * 1024.0);
    }
}

#pragma mark - 得到指定目录下的所有文件
+ (NSArray *)getAllFileNames:(NSString *)dirPath{
    NSArray *files = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:dirPath error:nil];
    return files;
}

#pragma mark - 删除指定目录或文件
+ (BOOL)clearCachesWithFilePath:(NSString *)path{
    NSFileManager *mgr = [NSFileManager defaultManager];
    return [mgr removeItemAtPath:path error:nil];
}

#pragma mark - 清空指定目录下文件
+ (BOOL)clearCachesFromDirectoryPath:(NSString *)dirPath{
    
    //获得全部文件数组
    NSArray *fileAry =  [ValidateHelper getAllFileNames:dirPath];
    //遍历数组
    BOOL flag = NO;
    for (NSString *fileName in fileAry) {
        NSString *filePath = [dirPath stringByAppendingPathComponent:fileName];
        flag = [ValidateHelper clearCachesWithFilePath:filePath];
        
        if (!flag)
            break;
    }
    
    return flag;
}


#pragma mark-----相隔多少天没有打开应用就通过本地通知提示用户重新打开应用
/**
 相隔多少天没有打开应用就通过本地通知提示用户重新打开应用
 
 @param day 相隔的天数
 @param message 提示的内容
 @param alertTitle 提示的标题
 */
+ (void)RemindUserWithNotficationAfterAFewDays:(NSInteger)day
                              AndRemindMessage:(NSString *)message
                                AndRemindTitle:(NSString *)alertTitle
{
    [self CancelOldNotifactions];//先取消掉之前的通知
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    // 注册本地通知
    UILocalNotification *localnotifit = [[UILocalNotification alloc] init];
    
    if (localnotifit) {
        // 获取通知时间
        NSDate *now = [NSDate date];
        localnotifit.timeZone = [NSTimeZone defaultTimeZone];
        
        // XXX秒后开始通知  天换算为秒    day * 24 * 3600
        localnotifit.fireDate = [now dateByAddingTimeInterval:day * 24 * 3600];
        // 重复类型  0 表示不重复
        localnotifit.repeatInterval = 0;
        // 提醒内容
        localnotifit.alertBody = message;
        
        // 通知栏里的通知标题
        if (@available(iOS 8.2, *)) {
            localnotifit.alertTitle = alertTitle;
        } 
        
        // 默认的通知声音（只有在真机上才会听到）
        localnotifit.soundName = UILocalNotificationDefaultSoundName;
        
        // 通知userInfo中的内容
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:NotificationID forKey:NSStringFromClass([UILocalNotification class])];
        localnotifit.userInfo = dic;
        
        // 将通知添加到系统中
        [[UIApplication sharedApplication] scheduleLocalNotification:localnotifit];
    }
#pragma clang diagnostic pop
}


+ (void)CancelOldNotifactions
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    for (UILocalNotification *notification in [[UIApplication sharedApplication] scheduledLocalNotifications]) {
        NSDictionary *notiDic = notification.userInfo;
        if ([[notiDic objectForKey:NSStringFromClass([UILocalNotification class])] isEqualToString:NotificationID]) {
            [[UIApplication sharedApplication] cancelLocalNotification:notification];
            return;
        }
    }
#pragma clang diagnostic pop
}

#pragma mark-----异步检查应用更新
/**
 *  异步检查应用更新
 */
+ (void)CheckTheUpdateWithAppID:(NSString *)AppID
{
    
    NSString * url = [[NSString alloc] initWithFormat:@"http://itunes.apple.com/lookup?id=%@",AppID];//替换为自己App的ID
    // 获取本地版本号
    NSString * currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    // 网络请求获取最新版本
    
    [HLNetWorkRequest getServersUrl:url Parameter:@{} ModalClass:nil Cache:HLCacheTypeNULL SuccessBlock:^(id responseObject) {
        NSArray * results = responseObject[@"results"];
        if (results && results.count > 0){
            NSDictionary * dic = results.firstObject;
            NSString * lineVersion = dic[@"version"];//版本号
            NSString * releaseNotes = dic[@"releaseNotes"];//更新说明
            //NSString * trackViewUrl = dic[@"trackViewUrl"];//链接
            //把版本号转换成数值
            NSArray * array1 = [currentVersion componentsSeparatedByString:@"."];
            NSInteger currentVersionInt = 0;
            if (array1.count == 3)//默认版本号1.0.0类型
            {
                currentVersionInt = [array1[0] integerValue]*100 + [array1[1] integerValue]*10 + [array1[2] integerValue];
            }
            NSArray * array2 = [lineVersion componentsSeparatedByString:@"."];
            NSInteger lineVersionInt = 0;
            if (array2.count == 3)
            {
                lineVersionInt = [array2[0] integerValue]*100 + [array2[1] integerValue]*10 + [array2[2] integerValue];
            }
            if (lineVersionInt > currentVersionInt)//线上版本大于本地版本
            {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
                        if (buttonIndex) {
                            //前去APPStroe下载
                            NSString *str = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@",AppID];
                            if([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)])
                            {
                                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:^(BOOL success) {
                                    
                                }];
                            }else
                            {
                                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
                            }
                            
//                            [NSThread sleepForTimeInterval:0.5];//否则跳转过程中会看到应用黑掉。。
//                            exit(0);//退出应用
                        }
                    } title:@"有新版本更新" message:releaseNotes cancelButtonName:@"取消" otherButtonTitles:@"前往更新", nil];
                });

//
//                UIAlertController * alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"发现新版本%@",lineVersion] message:releaseNotes preferredStyle:UIAlertControllerStyleAlert];
//                UIAlertAction * ok = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
//                UIAlertAction * update = [UIAlertAction actionWithTitle:@"去更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                    //跳转到App Store
//                    NSString *urlStr = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/id%@?mt=8",AppID];
//                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
//                }];
//                [alert addAction:ok];
//                [alert addAction:update];
//                [self presentViewController:alert animated:YES completion:nil];
            }
        }
        
    } failureBlock:^(HLNetworkErrorType type, NSString *error) {
        
    }];
    
//    NSString *Verson = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
//    NSString *NewVersion = [Verson stringByReplacingOccurrencesOfString:@"." withString:@""];
//    
//    //   1151115099    414478124(微信)   908613321
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:AppID,@"id", nil];
//    
//    [SKHttpRequest requestWithUrl:@"https://itunes.apple.com/cn/lookup" params:dic useCache:NO httpMedthod:SKPOSTRequest progressBlock:^(int64_t bytesRead, int64_t totalBytes) {
//        
//    } successBlock:^(id response) {
//        NSLog(@"苹果服务器返回的的版本更新信息---------%@",response[@"results"][0][@"releaseNotes"]);
//        //dict[@"results"][0][@"description"]应用简介
//        //dict[@"results"][0][@"releaseNotes"]应用功能说明
//        if([response[@"resultCount"] integerValue])//如果获取成功
//        {
//            //保存最新版本号
//            NSUserDefaults *Defult = [NSUserDefaults standardUserDefaults];
//            [Defult setValue:response[@"results"][0][@"version"] forKey:@"APPSTOREVERSION"];
//            [Defult synchronize];
//            
//            NSString *AppleVerson = [response[@"results"][0][@"version"] stringByReplacingOccurrencesOfString:@"." withString:@""];
//            if([NewVersion integerValue] < [AppleVerson integerValue])//应对苹果审核
//            {
//                dispatch_async(dispatch_get_main_queue(), ^{
//
//                    [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
//                        if (buttonIndex) {
//                            //前去APPStroe下载
//                            NSString *str = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@",AppID];
//                            if([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)])
//                            {
//                                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:^(BOOL success) {
//
//                                }];
//                            }else
//                            {
//                                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
//                            }
//
//                            [NSThread sleepForTimeInterval:0.5];//否则跳转过程中会看到应用黑掉。。
//                            exit(0);//退出应用
//                        }
//                    } title:@"有新版本更新" message:response[@"results"][0][@"releaseNotes"] cancelButtonName:@"取消" otherButtonTitles:@"前往更新", nil];
//                });
//            }
//        }
//    } failBlock:^(NSError *error, BOOL isNetworking) {
//        
//    }];
}


#pragma mark-----用户使用两周后再打开应用提示去评价，根据APPID跳转应用市场
/**
 用户使用两周后再打开应用提示去评价，根据APPID跳转应用市场
 
 @param AppID AppID
 */
+ (void)GotoEvaluateWithAppID:(NSString *)AppID
{
    
    NSUserDefaults *Defult = [NSUserDefaults standardUserDefaults];
    NSDate* date = [NSDate date];
    double tick = [date timeIntervalSince1970];
    NSInteger _t = [[NSString stringWithFormat:@"%.0f",tick] integerValue];
    //此版本用户第一次使用的开始时间
    NSInteger _Oldt = [[Defult objectForKey:@"FirstBuldTime"] integerValue];
    NSInteger Day = (_t - _Oldt)/(24 * 60 * 60); //已经使用此版本的天数
    
    //使用大于2周并且未弹出去评价窗口或者弹出被拒绝评价则继续弹出
    if((( Day >= 14))&&(![[UserDefaults readUserDefaultObjectValueForKey:@"ISShowToAppStore"] integerValue]))
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"致开发者的一封信" message:@"亲爱的用户，经过一段时间的使用，我们真诚的希望您对我们的应用提出宝贵的意见或者建议，有了您的支持才能更好的为您服务，提供更加优质的，更加适合您的应用，感谢您的支持！" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *refuseAction = [UIAlertAction actionWithTitle:@"😭残忍拒绝" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            [UserDefaults writeUserDefaultObjectValue:[NSString stringWithFormat:@"%ld",(long)_t] withKey:@"FirstBuldTime"]; //两周后继续弹出
        }];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"😝好评赞赏" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            
            NSString *str = [NSString stringWithFormat:
                             @"https://itunes.apple.com/cn/app/id%@?mt=8",
                             AppID];
            
            
            if([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)])
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:^(BOOL success) {
                    
                }];
            }else
            {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
                if([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)])
                {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:^(BOOL success) {
                        
                    }];
                    
                }else
                {

                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
#pragma clang diagnostic pop
                }
            }
            
            [UserDefaults writeUserDefaultObjectValue:@"1" withKey:@"ISShowToAppStore"]; //标记已经显示过了
            
            [UserDefaults synchronize];
            
        }];
        
        UIAlertAction *showAction = [UIAlertAction actionWithTitle:@"😓我要吐槽" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            
            
            NSString *str = [NSString stringWithFormat:
                             @"https://itunes.apple.com/cn/app/id%@?mt=8",
                             AppID];
            
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            if([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)])
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:^(BOOL success) {
                    
                }];
            }else
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
#pragma clang diagnostic pop
            }
            
            [UserDefaults writeUserDefaultObjectValue:[NSString stringWithFormat:@"%ld",(long)_t] withKey:@"FirstBuldTime"]; //两周后继续弹出
            [UserDefaults synchronize];
            
        }];
        [alert addAction:okAction];
        [alert addAction:showAction];
        [alert addAction:refuseAction];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    }
    
}

#pragma mark-----判断是否是第一次启动
/*!
 @brief 判断是否是第一次启动
 */
+ (BOOL)isFirstBuldVesion
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * systemVesion = [[NSBundle mainBundle]objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey];
    BOOL isFirstV = [systemVesion isEqualToString:[defaults objectForKey:@"Vesion"]];
    
    //不论是不是当前版本 都存入新值
    [defaults setObject:systemVesion forKey:@"Vesion"];
    [defaults synchronize];
    
    //比较存入的版本号是否相同 如果相同则进入tabBar页面否则进入滚动视图
    if (isFirstV) {
        return NO;//不是第一次启动
    }
    
    ////必须写在return之后，存储第一次启动的时间
    NSDate* date = [NSDate date];
    double tick = [date timeIntervalSince1970];
    NSString* _t = [NSString stringWithFormat:@"%.0f",tick];
    [defaults setObject:_t forKey:@"FirstBuldTime"]; //记录新版本第一次启动的时间
    [defaults synchronize];
    
    [defaults setObject:@"0" forKey:@"ISShowToAppStore"];
    [defaults synchronize];
    return YES;
}

@end






