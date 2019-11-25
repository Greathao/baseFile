//
//  UITextView+FontSize.m
//  FontSizeModify
//
//  Created by lilekai on 2017/5/11.
//  Copyright © 2017年 dyw. All rights reserved.
//

#import "UITextView+FontSize.h"
#import <objc/runtime.h>

@implementation UITextView (FontSize)

+ (void)load {
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
}

- (id)myInitWithCoder:(NSCoder*)aDecode {
    [self myInitWithCoder:aDecode];
    if (self) {
        CGFloat fontSize = self.font.pointSize;
        self.font = [UIFont systemFontOfSize:fontSize];
    }
    return self;
}

@end
