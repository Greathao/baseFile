//
//  LHNetWorkErrorView.m
//  BaseFile
//
//  Created by liuhao on 2019/11/22.
//  Copyright © 2019 liuhao. All rights reserved.
//

#import "LHNetWorkErrorView.h"

@implementation LHNetWorkErrorView
 
- (IBAction)refreshCallBack:(id)sender {
    if (self.refreshBlock) {
        self.refreshBlock();
    }
}

@end
