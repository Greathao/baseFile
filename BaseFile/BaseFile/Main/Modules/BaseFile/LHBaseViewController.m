//
//  LHBaseViewController.m
//  LHProjectShell
//
//  Created by liuhao on 2018/12/7.
//  Copyright © 2018 liuhao. All rights reserved.
//

#import "LHBaseViewController.h"

@interface LHBaseViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic,strong) LHBlockAnimationView *startFullView;
@property (nonatomic,strong) LHNetWorkErrorView *errorView;

@end

@implementation LHBaseViewController

///侧滑区域
static CGFloat const touch_Width = 44.0f;


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setPan];
    [self configNavgationBar];
    [self addLeftItem];
    [self addRightItem];
    
}

-(void)configNavgationBar
{
    LHNavgationView*  nav = [[LHNavgationView alloc]init];
    nav.backgroundColor = [UIColor colorWithRGB:0xecc22c];
    nav.isHideButtomLine = YES;
    nav.buttomLineColor = [UIColor colorWithRGB:0xecc22c];
    nav.titleColor = [UIColor blackColor];
    [self.view addSubview:nav];
    //赋值给外步只读属性供子类修改
    [self setValue:nav forKey:NSStringFromSelector(@selector(lh_nav))];
}

-(void)addLeftItem
{
    UIButton * leftButtonItem = [UIButton buttonWithType:UIButtonTypeCustom];
    WeakSelf
    [self.lh_nav addLeftCustomView:leftButtonItem selectBlock:^(UIView * _Nonnull view) {
        [weakSelf leftTouchAction];
    }];
}

-(void)addRightItem
{
    UIButton * rightButtonItem = [UIButton buttonWithType:UIButtonTypeCustom];
    WeakSelf
    [self.lh_nav addRightCustomView:rightButtonItem selectBlock:^(UIView * _Nonnull view) {
        [weakSelf rightTouchAction];
    }];
}


/// 设置导航栏title
/// @param title text
-(void)setNavTitle:(NSString*)title;
{
    self.lh_nav.titleName = title;
}

/// 设置导航栏颜色
/// @param color 颜色
-(void)setNavBackgroundColor:(UIColor*)color;
{
    self.lh_nav.backgroundColor = color;
}

/// 设置导航栏标题字体大小
/// @param font 字体
-(void)setNavTitleFont:(UIFont*)font;
{
    self.lh_nav.titleFont = font;
}

/// 设置左侧按钮标题
/// @param title text
-(void)setNavLeftItemTitle:(NSString*)title;
{
    if (!self.lh_nav.leftItems.count) {
        return;
    }
    UIButton * btnItem =(UIButton*)self.lh_nav.leftItems[0];
    [btnItem setTitle:title forState:UIControlStateNormal];
}

/// 设置右边导航标题
/// @param title  text
-(void)setNavRightItemTitle:(NSString*)title;
{
    if (!self.lh_nav.rightItems.count) {
        return;
    }
    UIButton * btnItem =(UIButton*)self.lh_nav.rightItems[0];
    [btnItem setTitle:title forState:UIControlStateNormal];
}

/// 设置左边标题颜色
/// @param color 颜色
-(void)setNavLeftItemTitleColor:(UIColor*)color;
{
    if (!self.lh_nav.leftItems.count) {
        return;
    }
    UIButton * btnItem =(UIButton*)self.lh_nav.leftItems[0];
    [btnItem setTitleColor:color forState:UIControlStateNormal];
    
}

/// 设置右边标题颜色
/// @param color 颜色
-(void)setNavRightItemTitleColor:(UIColor*)color;
{
    if (!self.lh_nav.rightItems.count) {
        return;
    }
    UIButton * btnItem =(UIButton*)self.lh_nav.rightItems[0];
    [btnItem setTitleColor:color forState:UIControlStateNormal];
}


/// 设置左按钮图片
/// @param image normal图片
/// @param highImage 高亮图片
-(void)setNavLeftItemImage:(NSString*)image  highImage:(NSString *)highImage;
{
    if (!self.lh_nav.leftItems.count) {
        return;
    }
    UIButton * btnItem =(UIButton*)self.lh_nav.leftItems[0];
    [btnItem setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btnItem setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
}

/// 设置右按钮图片
/// @param image normal图片
/// @param highImage 高亮图片
-(void)setNavRightItemImage:(NSString*)image  highImage:(NSString *)highImage;
{
    if (!self.lh_nav.rightItems.count) {
        return;
    }
    UIButton * btnItem =(UIButton*)self.lh_nav.rightItems[0];
    [btnItem setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btnItem setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
}


/// 向左追加一个按钮
/// @param view view
/// @param clickBack 回调
-(void)setNavAddLeftItemView:(UIView *)view clickCallback:(void(^)(UIView *view))clickBack;
{
    [self.lh_nav addLeftCustomView:view selectBlock:clickBack];
}

/// 向又追加一个按钮
/// @param view view
/// @param clickBack 回调
-(void)setNavAddRightItemView:(UIView *)view clickCallback:(void(^)(UIView *view))clickBack;
{
    [self.lh_nav addRightCustomView:view selectBlock:clickBack];
}

/// 最左边按钮触发事件
-(void)leftTouchAction;
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

/// 最右边按钮触发事件
-(void)rightTouchAction;{};


-(void)startLoading;
{
    if (_errorView) {
        [_errorView removeFromSuperview];
        _errorView = nil;
    }
    _startFullView = [[LHBlockAnimationView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_startFullView];
    [_startFullView startAnimation];
}

-(void)stopLoading;
{
    if (_startFullView) {
        [_startFullView stopAnimation];
        [_startFullView removeFromSuperview];
        _startFullView = nil;
    }
}

-(void)showErrorViewRefreshCallbackBlock:(void (^)(void))callbackBlock;
{
    
    [self dismissErrorView];
    
    _errorView = [LHNetWorkErrorView viewFromXib];
    [self.view addSubview:_errorView];
    
    WeakSelf
    _errorView.refreshBlock = ^{
        [weakSelf dismissErrorView];
    };
}

-(void)dismissErrorView;
{
    if (_errorView) {
        [_errorView  removeFromSuperview];
        _errorView = nil;
    }
}

/**
 *  添加手势
 */
-(void)setPan{
    
    id target = self.navigationController.interactivePopGestureRecognizer.delegate;
    // handleNavigationTransition:为系统私有API,即系统自带侧滑手势的回调方法，我们在自己的手势上直接用它的回调方法
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    panGesture.delegate = self; // 设置手势代理，拦截手势触发
    [self.view addGestureRecognizer:panGesture];
    // 一定要禁止系统自带的滑动手势
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
}

// 什么时候调用，每次触发手势之前都会询问下代理方法，是否触发
// 作用：拦截手势触发
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 当当前控制器是根控制器时，不可以侧滑返回，所以不能使其触发手势
    if(self.navigationController.childViewControllers.count == 1)
    {
        return NO;
    }
    
    return [self popGestureRecognizer:gestureRecognizer];
}

-(BOOL)popGestureRecognizer:(UIGestureRecognizer*)gestureRecognizer
{
    if (![self isInteractivePopGestureRecognizer]) return NO;
    
    UIPanGestureRecognizer *panGesture = (UIPanGestureRecognizer *)gestureRecognizer;
    // 侧滑手势触发位置
    CGPoint location = [panGesture locationInView:self.view];
    CGPoint offSet = [panGesture translationInView:panGesture.view];
    //触发宽度，
    CGFloat maxLocationX = touch_Width;
    //当是全屏返回手势时，使用整个宽度
    BOOL ret = (0 < offSet.x && location.x <= maxLocationX);
    return ret;
}


- (BOOL)isInteractivePopGestureRecognizer{
    
    return YES;
}

- (void)handleNavigationTransition:(UIPanGestureRecognizer *)sender{
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    //当syPanGesture响应失败时，才响应scrollView的拖动手势
    [otherGestureRecognizer requireGestureRecognizerToFail:gestureRecognizer];
    return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    //当拖动的是slider时，该事件不让syPanGesture手势响应
    if ([touch.view isKindOfClass:[UISlider class]]) {
        return NO;
    }
    return YES;
}


@end
