//
//  LHNetWorkErrorView.h
//  BaseFile
//
//  Created by liuhao on 2019/11/22.
//  Copyright © 2019 liuhao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^RefreshBlock)(void);

@interface LHNetWorkErrorView : UIView
@property (nonatomic,copy) RefreshBlock  refreshBlock;

@end

NS_ASSUME_NONNULL_END
