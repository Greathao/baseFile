//
//  LHGSMainVC.m
//  BaseFile
//
//  Created by liuhao on 2019/11/22.
//  Copyright © 2019 liuhao. All rights reserved.
//

#import "LHGSMainVC.h"
#import "LHPushVC.h"
@interface LHGSMainVC ()

@end

@implementation LHGSMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"我是首页啊"];
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 150, kScreenWidth, 20)];
    [btn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:btn];
    
    [self setNavRightItemTitle:@"网络"];
  
}

-(void)rightTouchAction
{
    [self reqData];
}
-(void)push
{
    LHPushVC * push = [[LHPushVC alloc]init];
    [self.navigationController pushViewController:push animated:YES];
}



///模拟网络请求
-(void)reqData
{
    [self startLoading];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self  stopLoading];
    
        [self showErrorViewRefreshCallbackBlock:^{
            [self reqData];
        }];
        
    });
    
}

@end
