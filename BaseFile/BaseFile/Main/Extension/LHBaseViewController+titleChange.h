//
//  UIViewController+titleChange.h
//  LHProjectShell
//
//  Created by liuhao on 2018/12/27.
//  Copyright © 2018 liuhao. All rights reserved.
//

#import "LHBaseViewController.h"
#import <objc/runtime.h>
NS_ASSUME_NONNULL_BEGIN

@interface LHBaseViewController (titleChange)
 @property (nonatomic,strong) NSString *title;
@end

NS_ASSUME_NONNULL_END
