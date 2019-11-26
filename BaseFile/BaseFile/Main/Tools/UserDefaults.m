//
//  UserDefaults.m
//  iCampsite
//
//  Created by liuhao on 16/4/14.
//  Copyright © 2016年 liuhao. All rights reserved.
//

#import "UserDefaults.h"

@implementation UserDefaults

+(id)readUserDefaultObjectValueForKey:(NSString*)aKey {
    if (aKey) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSData *data = [defaults objectForKey:aKey];
        if(!data) return nil; //增加当data为空时，终端输出警告
        return [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }else {
        return nil;
    }
}

+(void)writeUserDefaultObjectValue:(NSObject*)aValue
                           withKey:(NSString*)aKey {
    if (!aValue || !aKey){
        return;
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSObject *objc = aValue ; // set value
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:objc];
    [defaults setObject:data forKey:aKey];
    [defaults synchronize];
}
+ (void)clearUserDefaultWithKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}
// 命令直接同步到文件里，来避免数据的丢失
+ (void)synchronize{
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
