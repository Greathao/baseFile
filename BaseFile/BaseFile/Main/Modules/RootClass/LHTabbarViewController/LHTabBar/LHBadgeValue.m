//
//  LHBadgeValue.m
//  LHProjectShell
//
//  Created by liuhao on 2018/12/10.
//  Copyright © 2018 liuhao. All rights reserved.
//

#import "LHBadgeValue.h"

@implementation LHBadgeValue

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.badgeL = [[UILabel alloc] initWithFrame:self.bounds];
        self.badgeL.textColor = [UIColor whiteColor];
        self.badgeL.font = [UIFont systemFontOfSize:11.f];
        self.badgeL.textAlignment = NSTextAlignmentCenter;
        self.badgeL.layer.cornerRadius = 8.f;
        self.badgeL.layer.masksToBounds = YES;
        self.badgeL.backgroundColor = [UIColor redColor];
        [self addSubview:self.badgeL];
    }
    return self;
}
- (void)setType:(LHBadgeValueType)type {
    _type = type;
    if (type == LHBadgeValueTypePoint) {
        self.badgeL.size = CGSizeMake(10, 10);
        self.badgeL.layer.cornerRadius = 5.f;
        self.badgeL.x = 0;
        self.badgeL.y = self.height * 0.5 - self.badgeL.size.height * 0.5;
    } else if (type == LHBadgeValueTypeNew) {
        self.badgeL.size = CGSizeMake(self.width, self.height);
    } else if (type == LHBadgeValueTypeNumber) {
        CGSize size = CGSizeZero;
        CGFloat radius = 8.f;
        if (self.badgeL.text.length <= 1) {
            size = CGSizeMake(self.height, self.height);
            radius = self.height * 0.5;
        } else if (self.badgeL.text.length > 1) {
            size = self.bounds.size;
            radius = 8.f;
        }
        self.badgeL.size = size;
        self.badgeL.layer.cornerRadius = radius;
    }
 
}

- (CGSize)sizeWithAttribute:(NSString *)text {
    return [text sizeWithAttributes:@{NSFontAttributeName:self.badgeL.font}];
}



@end
