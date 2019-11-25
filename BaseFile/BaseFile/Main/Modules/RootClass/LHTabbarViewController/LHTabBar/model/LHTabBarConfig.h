//
//  LHTabbarConfig.h
//  LHProjectShell
//
//  Created by liuhao on 2018/12/7.
//  Copyright © 2018 liuhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN
 

@interface LHTabBarModel : NSObject
//类名
@property (nonatomic,copy) NSString *className;
//item名
@property (nonatomic,copy) NSString *itemName; //没有名字就显示图片
//正常的item图片
@property (nonatomic,copy) NSString *itemImgNormal;
//点击的item图片
@property (nonatomic,copy) NSString *itemImgSelect;

///根据字典转模型
-(LHTabBarModel*)initWithDictionary:(NSDictionary*)dict;





@end


@interface   LHTabBarConfig:NSObject
+(NSArray<LHTabBarModel*>*)obtainConfigWithPlistName:(NSString*)plistName;
@end



NS_ASSUME_NONNULL_END
