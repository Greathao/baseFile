//
//  LHTabBarViewController.m
//  JokeProject
//
//  Created by liuhao on 16/12/17.
//  Copyright © 2016年 liuhao. All rights reserved.
//

#import "LHNTabBarViewController.h"
#import "HRNavigationViewController.h"

#import "TopVC.h"
//切换tab通知
NSString * const ONCEAGAIN_TABBARSELECT_NOTIFICATION = @"TABBARSELECT_NOTIFICATION";

@interface LHNTabBarViewController ()<LHTabBarDelegate>
@property (nonatomic,strong) NSArray   * itemsModels;
/**
 * 选中的vc
 */
@property (nonatomic,strong) UIViewController *CurrentVC;

@property(nonatomic,assign)NSInteger touchIndex;//点击的下标

@end
@implementation LHNTabBarViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //不带navroot VC 不需要隐藏
    if (self.isNoNavRootVC) {
        
        return;
    }
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //不带navroot VC 不需要隐藏
    if (self.isNoNavRootVC) {
        return;
    }
    if ( self.navigationController.childViewControllers.count > 1 ) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}
-(void)viewDidLoad{
    [super viewDidLoad];
  
}

-(void)setupLeftNavigationItem:(UINavigationController*)nav{
    UIButton* backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn addTarget:self
                action:@selector(backAction)
      forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"cion_xinxi_fanhui"]
             forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"cion_geren_btn_back"]
             forState:UIControlStateHighlighted];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -65, 0, 0);//设置偏移量
    UIBarButtonItem* leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    nav.viewControllers[0].navigationItem.leftBarButtonItem = leftBarItem;
}

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:NO];
}


-(instancetype)initWithConfigPlistName:(NSString*)name;{
    if(self = [super init]){
        self.itemsModels = [LHTabBarConfig obtainConfigWithPlistName:name];
        [self tabbarConfig];
        [self createViewControllersWithModel];
    }
    return self;
}

/**
 * tabbar样式配置
 */
-(void)tabbarConfig{
    
    self.lh_tabbar = [[LHTabBar alloc]initWithFrame:self.tabBar.frame tabBarItemsModel:  self.itemsModels delegate:self];
    self.lh_tabbar.selectedIndex = 0;
    
    
    //替换系统tabbar
    [self setValue:self.lh_tabbar forKeyPath:@"tabBar"];
    
    [self addObserver:self forKeyPath:@"selectedIndex" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSInteger selectedIndex = [change[@"new"] integerValue];
    self.lh_tabbar.selectedIndex = selectedIndex;
}

/**
 * 根据数据源配置
 */
-(void)createViewControllersWithModel{
    
    for (LHTabBarModel * obj in  self.itemsModels) {
        id myObj  = [[NSClassFromString(obj.className) alloc] init];
        if (myObj) {
            UIViewController * Vc = myObj;
            HRNavigationViewController * nav = [[HRNavigationViewController alloc]initWithRootViewController:Vc];
            [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_bg021.png"]forBarMetrics:UIBarMetricsDefault];
            [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18.0]}];
            [nav.navigationBar setBarStyle:UIBarStyleBlack];
            [self addChildViewController:nav];
        }
        
    }
    
}
 
- (void)tabBar:(LHTabBar *)tabBar didSelectIndex:(NSInteger)selectIndex;{
    self.selectedIndex = selectIndex;
    
    if (self.touchIndex==selectIndex) {
        NSLog(@"一样%@",self.viewControllers[selectIndex]);
        //当tabBar被点击时发出一个通知
        [[NSNotificationCenter defaultCenter] postNotificationName:ONCEAGAIN_TABBARSELECT_NOTIFICATION object:[TopVC shared].top  userInfo:nil];
     }
    
    
    self.touchIndex = selectIndex;
   
}
-(void)setIsNoNavRootVC:(BOOL)isNoNavRootVC{
    _isNoNavRootVC = isNoNavRootVC;
    //默认带nav  默认return
    if (!isNoNavRootVC) {
        return;
    }
    
    //删除子控制器
    int i = 0;
    for (UINavigationController * nav in self.viewControllers) {
        [nav removeFromParentViewController];
        i++;
    }
    //添加新的控制器不带nav
    for (LHTabBarModel * obj in  self.itemsModels) {
        id myObj  = [[NSClassFromString(obj.className) alloc] init];
        if (myObj) {
            UIViewController * Vc = myObj;
            [self addChildViewController:Vc];
        }
    }
}


-(void)setIsOpenLeftButton:(BOOL)isOpenLeftButton{
    _isOpenLeftButton = isOpenLeftButton;
    //此属性有用的情况为 isNoNavRootVC属性为假的时候用（也就是默认是tabbar管理的带nav的vc）
    if (isOpenLeftButton&&!self.isNoNavRootVC) {
        for (UINavigationController*nav in self.viewControllers ) {
            [self setupLeftNavigationItem:nav];
        }
    }
}



/**
 * 主动切换当前vc
 */
-(void)setSelectedIndex:(NSUInteger)selectedIndex;{
    [self setSelectedViewController: self.viewControllers[selectedIndex]];
}
/**
 * 隐藏显示tabbar
 */
-(void)isHiddenTabbar:(BOOL)ishidden;{
    if (ishidden==YES) {
        self.lh_tabbar.hidden = YES;
    }else{
        self.lh_tabbar.hidden = NO;
    }
}

 

-(void)dealloc{
    
    NSLog(@"%@__dealloc",self);
}

@end
