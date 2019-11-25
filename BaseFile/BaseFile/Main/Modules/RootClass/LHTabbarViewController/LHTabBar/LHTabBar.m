//
//  LHTabbar.m
//  LHProjectShell
//
//  Created by liuhao on 2018/12/7.
//  Copyright © 2018 liuhao. All rights reserved.
//

#import "LHTabBar.h"

#import "CALayer+LHTabBarAnimation.h"
@interface LHTabBar ()
@property (nonatomic,strong) NSMutableArray *itemsArrM;

@property (nonatomic,copy) LHCustomBtnAcionBlock customBtnClick;

@end
@implementation LHTabBar


-(void)layoutSubviews{
    [super layoutSubviews];
    NSMutableArray *tempArr = [NSMutableArray array];
    for (UIView *tabBarButton in self.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButton removeFromSuperview];
        }
        if ([tabBarButton isKindOfClass:[LHTabBarItem class]] || [tabBarButton isKindOfClass:[UIButton class]]) {
            [tempArr addObject:tabBarButton];
        }
    }
    
    //进行排序
    for (int i = 0; i < tempArr.count; i++) {
        UIView *view = tempArr[i];
        if ([view isKindOfClass:[UIButton class]]) {
            [tempArr insertObject:view atIndex:view.tag];
            [tempArr removeLastObject];
            break;
        }
    }
    
    CGFloat viewW = self.width / tempArr.count;
    CGFloat viewH = 49;
    CGFloat viewY = 0;
    for (int i = 0; i < tempArr.count; i++) {
        CGFloat viewX = i * viewW;
        UIView *view = tempArr[i];
        view.frame = CGRectMake(viewX, viewY, viewW, viewH);
        
    }
    
}
- (NSMutableArray *)itemsArrM{
    if (!_itemsArrM) {
        _itemsArrM = [NSMutableArray array];
    }
    return _itemsArrM;
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self tabBarBaseConfig];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame tabBarItemsModel:(NSArray<LHTabBarModel*>*)subItems delegate:(id<LHTabBarDelegate>)delegate;
{
    if (self = [super initWithFrame:frame]) {
        [self tabBarBaseConfig];
        self.myDelegate = delegate ;
        self.subItems = subItems;
    }
    return self;
}
/**
 * tabbar默认配置
 */
-(void)tabBarBaseConfig{
    
    [self  setBackgroundImage:[self createImageWithColor:[UIColor clearColor]]];
    [self  setShadowImage:[self createImageWithColor:[UIColor clearColor]]];
   
    self.backgroundColor = [UIColor whiteColor];
    //shadowColor阴影颜色
    self .layer.shadowColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1].CGColor;
    //shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self .layer.shadowOffset = CGSizeMake(0,-2);
    //阴影透明度，默认0
    self  .layer.shadowOpacity = 0.1;
    //阴影半径，默认3
    self .layer.shadowRadius = 4;
    
}
/**
 * 颜色转为image
 */
- (UIImage*) createImageWithColor: (UIColor*) color{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
/**
 * 根据数据源设置Item
 */
-(void)configItemUI{
    
    for (int i = 0; i < self.subItems.count; i++) {
        LHTabBarItem *tbBtn = [[LHTabBarItem alloc] init];
        LHTabBarModel * model = self.subItems[i];
        tbBtn.imageView.image = [UIImage imageNamed:model.itemImgNormal];
        tbBtn.title.text = model.itemName;
        tbBtn.title.font = [UIFont systemFontOfSize:12];
        tbBtn.title.textColor = defColor;
        tbBtn.itemType = model.itemName.length?LHItemTypeNormal:LHItemTypeImage;
        tbBtn.tag = i;
        [self addSubview:tbBtn];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [tbBtn addGestureRecognizer:tap];
        [self.itemsArrM addObject:tbBtn];
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    [self setUpSelectedIndex:selectedIndex];
}

#pragma mark - 设置选中的index进行操作
- (void)setUpSelectedIndex:(NSInteger)selectedIndex {
    for (int i = 0; i < self.itemsArrM.count; i++) {
        LHTabBarItem *tbBtn = self.itemsArrM[i];
        LHTabBarModel * model = self.subItems[i];
        if (i == selectedIndex) {
            if (!self.isDeselect) {
                tbBtn.title.textColor = self.titleNormalColor? self.titleNormalColor: selColor;
                tbBtn.imageView.image = [UIImage imageNamed:model.itemImgSelect];
                
            }
            if (self.animType ==LHTabBarAnimTypeJitter) {
                [tbBtn.imageView.layer add_lhTransform_scaleAnimationforKey:@""];
            }
        } else {
            tbBtn.title.textColor = self.titleSelectColor? self.titleSelectColor: defColor;
            tbBtn.imageView.image = [UIImage imageNamed:model.itemImgNormal];
            
        }
    }
}


-(void)setSubItems:(NSArray<LHTabBarModel *> *)subItems{
    _subItems = subItems;
    [self configItemUI];
}

-(void)setBgImg:(UIImage *)bgImg{
    _bgImg = bgImg;
    self.backgroundImage = bgImg;
}
-(void)setBgColor:(UIColor *)bgColor{
    _bgColor = bgColor;
    self.backgroundColor = bgColor;
}

-(void)setShadowColor:(UIColor *)shadowColor{
    _shadowColor = shadowColor;
    //shadowColor阴影颜色
    self .layer.shadowColor = shadowColor.CGColor;
}

-(void)setAnimType:(LHTabBarAnimType)animType{
    _animType = animType;
}
-(void)setIsClearTabBarTopLine:(BOOL)isClearTabBarTopLine{
    _isClearTabBarTopLine = isClearTabBarTopLine;
    if (isClearTabBarTopLine) {
        [self topLineIsClearColor:YES];
    }else{
        [self topLineIsClearColor:NO];
    }
    
}

-(void)setTabBarTopLineColor:(UIColor *)tabBarTopLineColor{
    _tabBarTopLineColor = tabBarTopLineColor;
    [self topLineIsClearColor:NO];;
}
-(void)setTitleNormalColor:(UIColor *)titleNormalColor{
    
    for (UIView *tabBarButton in self.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButton removeFromSuperview];
        }
        if ([tabBarButton isKindOfClass:[LHTabBarItem class]]) {
            LHTabBarItem * item = (LHTabBarItem*)tabBarButton;
            item.title.textColor =titleNormalColor;
        }
    }
    
}

#pragma mark - 顶部线条处理(清除颜色)
- (void)topLineIsClearColor:(BOOL)isClearColor {
    UIColor *color = [UIColor whiteColor];
    if (!isClearColor) {
        color = self.tabBarTopLineColor;
    }
    
    CGRect rect = CGRectMake(0, 0, self.width, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self setBackgroundImage:[UIImage new]];
    [self setShadowImage:img];
}

- (void)addCustomBtn:(UIButton *)btn AtIndex:(NSInteger)index BtnClickBlock:(LHCustomBtnAcionBlock)btnClickBlock {
    btn.tag = index;
    [btn addTarget:self action:@selector(customBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.customBtnClick  = btnClickBlock;
    [self addSubview:btn];
}
-(void)customBtnClick:(UIButton*)bt{
    if (self.customBtnClick) {
        self.customBtnClick(bt, bt.tag);
    }
}


- (void)tapClick:(UITapGestureRecognizer *)tap {
    [self setUpSelectedIndex:tap.view.tag];
    
    if ([self.myDelegate respondsToSelector:@selector(tabBar:didSelectIndex:)]) {
        [self.myDelegate tabBar:self didSelectIndex:tap.view.tag];
    }
}


@end;

