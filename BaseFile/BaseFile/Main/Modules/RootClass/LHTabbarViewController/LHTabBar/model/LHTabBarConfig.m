//
//  LHTabbarConfig.m
//  LHProjectShell
//
//  Created by liuhao on 2018/12/7.
//  Copyright © 2018 liuhao. All rights reserved.
//

#import "LHTabBarConfig.h"

@implementation LHTabBarModel

-(LHTabBarModel*)initWithDictionary:(NSDictionary*)dict;
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"%s",__func__);
    NSLog(@"%@=%@",key,value);
}

@end


@implementation LHTabBarConfig
+(NSArray<LHTabBarModel*>*)obtainConfigWithPlistName:(NSString*)plistName;
{
    NSMutableArray  * tabArray = (NSMutableArray<LHTabBarModel*>*)[NSMutableArray array];
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    NSMutableArray *tabBarAry = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    [tabBarAry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LHTabBarModel * model = [[LHTabBarModel alloc]initWithDictionary:obj];
        [tabArray addObject:model];
    }];
    return [tabArray copy];
};
@end
 






