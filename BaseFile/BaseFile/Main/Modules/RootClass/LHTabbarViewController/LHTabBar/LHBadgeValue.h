//
//  LHBadgeValue.h
//  LHProjectShell
//
//  Created by liuhao on 2018/12/10.
//  Copyright © 2018 liuhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import"UIView+LH.h"



typedef NS_ENUM(NSInteger, LHBadgeValueType) {
    LHBadgeValueTypePoint, //小点
    LHBadgeValueTypeNew, //new
    LHBadgeValueTypeNumber, //数字
};

NS_ASSUME_NONNULL_BEGIN

@interface LHBadgeValue : UIView
/** badgeL */
@property (nonatomic, strong) UILabel *badgeL;

/** type */
@property (nonatomic, assign) LHBadgeValueType type;

@end

NS_ASSUME_NONNULL_END
