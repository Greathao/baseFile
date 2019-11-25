//
//  LHTabBarButton.m
//  LHProjectShell
//
//  Created by liuhao on 2018/12/10.
//  Copyright © 2018 liuhao. All rights reserved.
//

#import "LHTabBarItem.h"

@implementation LHTabBarItem

- (instancetype)initWithFrame:(CGRect)frame{
     self= [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] init];
 
        [self addSubview:self.imageView];
        
        self.title = [[UILabel alloc] init];
        self.title.textAlignment = NSTextAlignmentCenter;
        self.title.font = [UIFont systemFontOfSize:10.f];
        [self addSubview:self.title];
        
        self.badgeValue = [[LHBadgeValue alloc] init];
        self.badgeValue.hidden = YES;
        [self addSubview:self.badgeValue];
    }
    return self;
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
  
    CGSize imageSize = self.itemType ==LHItemTypeImage?  CGSizeMake(44, 44) : CGSizeMake(28, 28);
    
    CGFloat  imageY =  self.itemType ==LHItemTypeImage? self.height * 0.5 - imageSize.height * 0.5:5;
    CGFloat iamgeX = self.width * 0.5 - imageSize.width * 0.5;
    self.imageView.frame = CGRectMake(iamgeX, imageY, imageSize.width, imageSize.height);
    
    CGFloat titleX = 4;
    CGFloat titleH = 14.f;
    CGFloat titleW = self.width - 8;
    CGFloat titleY = self.height - 14.f;
    self.title.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    CGFloat badgeX = CGRectGetMaxX(self.imageView.frame) - 6;
    CGFloat badgeY = CGRectGetMinY(self.imageView.frame) - 2;
    CGFloat badgeH = 16;
    CGFloat badgeW = 24;
    self.badgeValue.frame = CGRectMake(badgeX, badgeY, badgeW, badgeH);
}

@end
