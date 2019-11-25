//
//  UIButton+FontSize.m
//  FontSizeModify
//
//  Created by lilekai on 2017/5/11.
//  Copyright © 2017年 dyw. All rights reserved.
//

#import "UIButton+FontSize.h"
#import <objc/runtime.h>

@implementation UIButton (FontSize)

+ (void)load {
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
    
}

- (id)myInitWithCoder:(NSCoder*)aDecode {
    [self myInitWithCoder:aDecode];
    if (self) {
        CGFloat fontSize = self.titleLabel.font.pointSize;
        self.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    }
    return self;
}

@end
