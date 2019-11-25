//
//  LHNavgationView.m
//  LHProjectShell
//
//  Created by liuhao on 2018/12/27.
//  Copyright © 2018 liuhao. All rights reserved.
//

#import "LHNavgationView.h"


@interface LHNavgationView ()
@property (nonatomic,strong) UILabel  *line;
@property (nonatomic,strong) UILabel  *titleLable;
@property (nonatomic,strong) UIView   * titleView;
@property (nonatomic,strong) UIImageView *backgroundImageView;
@property (nonatomic,strong) NSMutableArray *leftArray;
@property (nonatomic,strong) NSMutableArray *rightArray;
@property (nonatomic,strong) NSMutableDictionary *blockDic;
@end

@implementation LHNavgationView

+(instancetype)viewAddTo:(UIView*)view;{
    LHNavgationView * nav = [[LHNavgationView alloc]init];
    [view addSubview:nav];
    return nav;
};

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _backgroundColor = [UIColor whiteColor];
        _backgroundImageName = @"";
        _isHideButtomLine = NO;
        _buttomLineColor = [UIColor colorWithRed:0.97f green:0.97f blue:0.97f alpha:1.00f];
        _titleName = @"";
        [self creatSubViews];
    }
    return self;
}
-(void)creatSubViews{
    _blockDic = [NSMutableDictionary dictionary];
    
    
    
    self.frame = CGRectMake(0, 0, kScreenWidth, NAV_HEIGHT);
    
    self.backgroundImageView = [[UIImageView alloc]init];
    self.backgroundImageView.frame = self.bounds;
    self.backgroundImageView.hidden = YES;
    [self addSubview:self.backgroundImageView];
    
    self.backgroundColor = _backgroundColor;
    
    self.leftArray = [NSMutableArray array];
    
    _leftItems = [self.leftArray copy];
    self.rightArray = [NSMutableArray array];
    _rightItems = [self.rightArray copy];
    
    self.line = [[UILabel alloc]init];
    self.line.backgroundColor = _buttomLineColor;
    [self addSubview:self.line];
    self.titleView = [UIView new];
    [self addSubview:self.titleView];
    
    
    
    self.titleLable = [[UILabel alloc]init];
    self.titleLable.text = _titleName;
    self.titleLable.textAlignment  = NSTextAlignmentCenter;
    self.titleLable.font = [UIFont systemFontOfSize:18];
    [self.titleView addSubview:self.titleLable];
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    //left 的起始  righ的终点
    CGFloat spac =8;
    //statusBar的高度
    CGFloat status_h =  [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat button_w = 43;
    CGFloat subView_h = 43;
    //布局左item
    int i =0;
    for (UIView * view in self.leftArray) {
        ///布局
        view.frame = CGRectMake(spac+i*button_w, status_h, button_w, subView_h);
        i++;
    }
    //布局中间
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat title_w = screenWidth -spac*2-button_w*i;
    CGFloat title_x = spac+i*button_w;
    //    self.titleView .frame = CGRectMake(title_x, status_h, title_w, subView_h);
    //    self.titleLable.frame = self.titleView.bounds;
    //布局右
    int j = 0;
    //左侧按钮区域
    CGFloat left_w = button_w*i+spac;
    
    for (UIView * view in self.rightArray) {
        j++;
        CGFloat right_x = title_w-j*button_w+ left_w;
        //布局
        view.frame = CGRectMake(right_x, status_h, button_w, subView_h);
        
    }
    
    //更新title布局
    self.titleView .frame = CGRectMake(title_x, status_h, title_w-(i*button_w), subView_h);
    self.titleLable.frame = self.titleView.bounds;
    //线的布局
    self.line.frame = CGRectMake(0, status_h+subView_h, screenWidth, 1);
    
}

-(void)setBackgroundColor:(UIColor *)backgroundColor
{
    _backgroundColor = backgroundColor;
    self.backgroundImageView.hidden  = YES;
    self.backgroundColor = backgroundColor;
}
 
 -(void)setBackgroundImageName:(NSString *)backgroundImageName
 {
     [self.backgroundImageView setImage:[UIImage imageNamed:backgroundImageName]];
     self.backgroundImageView.hidden  = NO;
     _backgroundImageName = backgroundImageName;
 }

 -(void)setTitleName:(NSString *)titleName
{
    _titleName = titleName;
    self.titleLable.text = titleName;
}

-(void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    self.titleLable.textColor = titleColor;
}

-(void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    self.titleLable.font = titleFont;
}

-(void)setIsHideButtomLine:(BOOL)isHideButtomLine{
    _isHideButtomLine = isHideButtomLine;
    [self.line setHidden:isHideButtomLine];
    
}
-(void)setButtomLineColor:(UIColor *)buttomLineColor
{
    _buttomLineColor = buttomLineColor;
    self.line.backgroundColor = buttomLineColor;
}

-(void)addLeftCustomView:(UIView*)view selectBlock:(LHNavgationLeftActionBlock)leftActionBlock;
{
    [self addSubview:view];
    [self.leftArray addObject:view];
    _leftItems = [self.leftArray copy];
    [self addClickEventWithView:view isLeftAction:YES];
    [self.blockDic setObject:[leftActionBlock copy]   forKey:[NSString stringWithFormat:@"%p",view]];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

-(void)addRightCustomView:(UIView*)view selectBlock:(LHNavgationRightActionBlock)rightActionBlock;
{
    [self addSubview:view];
    [self.rightArray addObject:view];
    _rightItems = [self.rightArray copy];
    [self addClickEventWithView:view isLeftAction:NO];
    [self.blockDic setObject:rightActionBlock forKey:[NSString stringWithFormat:@"%p",view]];
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    
}

-(void) addClickEventWithView:(UIView*)view isLeftAction:(BOOL)isleft{
    if ([view isKindOfClass:[UIButton class]]) {
        UIButton * btn =  ((UIButton*)view);
        [btn addTarget:self action: isleft?@selector(LeftBtnClick:):@selector(RightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:isleft?@selector(LeftTapClick:):@selector(RightTapClick:)];
        [view addGestureRecognizer:tap];
    }
}

-(void)addTitleView:(UIView*)view;
{
    [self.titleView addSubview:view];
}

-(void)LeftBtnClick:(UIButton*)btn
{
    LHNavgationLeftActionBlock  leftActionBlock = [self.blockDic objectForKey:[NSString stringWithFormat:@"%p",btn]];
    if (leftActionBlock) {
        leftActionBlock(btn);
    }
    
}

-(void)RightBtnClick:(UIButton*)btn{
    LHNavgationRightActionBlock  rightActionBlock = [self.blockDic objectForKey:[NSString stringWithFormat:@"%p",btn]];
    if (rightActionBlock) {
        rightActionBlock(btn);
    }
}


-(void)LeftTapClick:(UITapGestureRecognizer*)tap
{
    
    LHNavgationLeftActionBlock   leftActionBlock = [self.blockDic objectForKey:[NSString stringWithFormat:@"%p",tap.view]];
    if (leftActionBlock) {
        leftActionBlock(tap.view);
    }
    
    
}
-(void)RightTapClick:(UITapGestureRecognizer*)tap
{
    LHNavgationRightActionBlock  rightActionBlock = [self.blockDic objectForKey:[NSString stringWithFormat:@"%p",tap.view]];
    if (rightActionBlock) {
        rightActionBlock(tap.view);
    }
    
}


@end
