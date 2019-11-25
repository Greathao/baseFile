//
//  LHPushVC.m
//  BaseFile
//
//  Created by liuhao on 2019/11/25.
//  Copyright © 2019 liuhao. All rights reserved.
//

#import "LHPushVC.h"

@interface LHPushVC ()

@end

@implementation LHPushVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavTitle:@"我是子类哈哈哈哈哈哈哈"];
    [self setNavRightItemTitle:@"哈哈"];
    [self setNavRightItemTitleFont:ThirteenFontSize];
    [self setNavRightItemTitleColor:UIColor333];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"刷新" forState:UIControlStateNormal];
     
}
///手势是否开启
-(BOOL)isInteractivePopGestureRecognizer
{
    return NO;
}
 

-(void)rightTouchAction
{
    NSLog(@"我是右边");
}



@end
