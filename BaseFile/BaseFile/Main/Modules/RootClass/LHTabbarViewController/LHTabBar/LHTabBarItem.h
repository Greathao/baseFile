//
//  LHTabBarButton.h
//  LHProjectShell
//
//  Created by liuhao on 2018/12/10.
//  Copyright © 2018 liuhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHBadgeValue.h"

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger,LHItemType){
    LHItemTypeNormal,//默认 图片上 文字下
    LHItemTypeImage,//只有图片没有文字
};

@interface LHTabBarItem : UIView
/** UIImageView */
@property (nonatomic, strong) UIImageView *imageView;
/** Title */
@property (nonatomic, strong) UILabel *title;
/** itemType**/
@property (nonatomic,assign)  LHItemType  itemType;
/** badgeValue */
@property (nonatomic, strong) LHBadgeValue *badgeValue;
@end

NS_ASSUME_NONNULL_END
