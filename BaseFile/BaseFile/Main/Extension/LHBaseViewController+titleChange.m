//
//  UIViewController+titleChange.m
//  LHProjectShell
//
//  Created by liuhao on 2018/12/27.
//  Copyright © 2018 liuhao. All rights reserved.
//

#import "LHBaseViewController+titleChange.h"

@implementation LHBaseViewController (titleChange)

-(void)setTitle:(NSString *)title{
    self.lh_nav.titleName = title;
}



@end
