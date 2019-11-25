//
//  LHBlockAnimationView.m
//  LHProjectShell
//
//  Created by liuhao on 2019/5/10.
//  Copyright © 2019 liuhao. All rights reserved.
//

#import "LHBlockAnimationView.h"

typedef NS_ENUM(NSInteger, ABlockDirection){
    ABlockDirection_UP = 1<<2,
    ABlockDirection_Down,
    ABlockDirection_Left,
    ABlockDirection_Right,
};

@interface LHBlockAnimationView ();
@property (nonatomic,strong) NSMutableArray *animCenterBlocks;
@property (nonatomic,assign) NSInteger  animCBlocksIndex;
@property (nonatomic,assign) BOOL isGoLeft;//默认是向右 到头变Yes
@property (nonatomic,strong) UILabel * moveTempBlockVw ;
@property (nonatomic,assign) BOOL isStopAnima; //是否停止动画
 @property (nonatomic,assign) ABlockDirection ablockDir;//当前动画状态

@end

@implementation LHBlockAnimationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
 
        [self animaBaseConfig];
        [self animaUI];
     }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self animaBaseConfig];
        [self animaUI];
    }
    return self;
}

-(void)animaBaseConfig
{
    
    _aBlockWide = 50.0f;
    _aBlockHight =50.0f;
    _eachBlockSpec = 5;
    _animBlockNum = 6;
    _animCenterY = self.frame.size.height/2;
    _animCenterX = self.frame.size.width/2;
    _animDuration = 1;
    
    _animCenterBlocks = [NSMutableArray arrayWithCapacity:_animBlockNum];
    _animCBlocksIndex = 0;
   
}


-(void)layoutSubviews
{
    [super layoutSubviews];

    
    CGFloat animLeft =_animCenterX- (_animBlockNum*_aBlockWide+ (_animBlockNum-1) * _eachBlockSpec)/2;
 
    int i = 0;
    for (UILabel * centerBlockVw in self.animCenterBlocks) {
        centerBlockVw.frame = CGRectMake((_aBlockWide+_eachBlockSpec)*i+animLeft, _animCenterY-_aBlockHight/2, _aBlockWide, _aBlockHight);
      
        i ++;
    }
    [self viewWithTag:1010101] .frame = CGRectMake(animLeft, CGRectGetMinY(((UILabel*)_animCenterBlocks[0]).frame)-_eachBlockSpec-_aBlockHight , _aBlockWide, _aBlockHight);
 
 }

-(void)animaUI
{
    for (int i = 0; i<_animBlockNum; i++)
    {
        UILabel * centerBlockVw = [[UILabel alloc]init];
        centerBlockVw.text = @(i).stringValue;
        centerBlockVw.backgroundColor = [UIColor orangeColor];
        [self addSubview:centerBlockVw];
        [_animCenterBlocks addObject:centerBlockVw];
      
    }
  
    UILabel * aBlock = [[UILabel alloc]init];
    aBlock.text = @"mv";
    aBlock.tag = 1010101;
    aBlock.backgroundColor = [UIColor orangeColor];
    [self  addSubview:aBlock];
    
    self.moveTempBlockVw = aBlock;
 
}

-(void)addAnimationView:(UILabel*)view toDire:(ABlockDirection)dir isStop:(BOOL)isStop
{
    [UIView animateWithDuration:_animDuration animations:^{
        switch (dir)
        {
            case ABlockDirection_UP:
                
                view.center = CGPointMake(view.center.x,view.center.y-self.aBlockHight-self.eachBlockSpec);
                break;
            case ABlockDirection_Down:
                
                view.center = CGPointMake(view.center.x,view.center.y+self.aBlockHight+self.eachBlockSpec);
                break;
            case ABlockDirection_Left:
                view.center = CGPointMake(view.center.x-self.aBlockWide-self.eachBlockSpec,view.center.y);
                break;
            case ABlockDirection_Right:
                view.center = CGPointMake(view.center.x+self.aBlockWide+self.eachBlockSpec,view.center.y);
                break;
        }
    } completion:^(BOOL finished) {
        //开始 往下走结束后
        if (dir== ABlockDirection_Down||dir==ABlockDirection_UP) {
            if (isStop==NO) {
                //将原先数组第一个向右移动
                [self addAnimationView: view toDire:self.isGoLeft?ABlockDirection_Left:ABlockDirection_Right isStop:NO];
                 self.moveTempBlockVw = view;
                
            }else{
                //获取原先的数组第一个
                //move块 和 数组下标第一个 移动后 将数组第一个换成移动的
                [self.animCenterBlocks replaceObjectAtIndex:self.animCBlocksIndex withObject:view];
            }
            
        }else if (dir==ABlockDirection_Right||dir==ABlockDirection_Left) {
            
            if (self.isStopAnima) {
                return ;
            }
 
            if (dir==ABlockDirection_Right)
            {
                self.animCBlocksIndex++;
                
            }else{
                self.animCBlocksIndex--;
                
            }
            //当移动的等于集合最后一个的位置时候  下次向左
            if (self.moveTempBlockVw.centerX == ((UILabel*)[self.animCenterBlocks lastObject]).centerX) {  self.isGoLeft = YES;}
            if (self.moveTempBlockVw.centerX ==((UILabel*)[self.animCenterBlocks firstObject]).centerX) {  self.isGoLeft = NO; }
            
            if (self.isStopAnima) {
                return;
            }
            
            [self startAnimation];
            
            NSLog(@"p--------%ld",(long)self.animCBlocksIndex);
        }
    }];
}

-(void)stopAnimation;
{
     self.isStopAnima = YES;
}

-(void)startAnimation;
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //取数组任意一个 判断 横滚后该往上还是往下
        UILabel * centerlb =self.animCenterBlocks[0] ;
        
        if (self.moveTempBlockVw.centerY<centerlb.centerY)
        {
            [self addAnimationView:self.moveTempBlockVw toDire:   ABlockDirection_Down isStop:YES];
            [self addAnimationView:self.animCenterBlocks[self.animCBlocksIndex] toDire:ABlockDirection_Down isStop:NO];
        }else
        {
            [self addAnimationView:self.moveTempBlockVw toDire: ABlockDirection_UP isStop:YES];
            [self addAnimationView:self.animCenterBlocks[self.animCBlocksIndex] toDire:ABlockDirection_UP isStop:NO];
        }
    });
 
}


-(void)setABlockWide:(CGFloat)aBlockWide
{
    _aBlockWide = aBlockWide;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

-(void)setABlockHight:(CGFloat)aBlockHight
{
    _aBlockHight = aBlockHight;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

-(void)setAnimCenterX:(CGFloat)animCenterX
{
    _animCenterX = animCenterX;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
-(void)setAnimCenterY:(CGFloat)animCenterY
{
    _animCenterY = animCenterY;
    [self setNeedsLayout];
    [self layoutIfNeeded];;
 
}
-(void)setAnimBlockNum:(CGFloat)animBlockNum{
    _animBlockNum = animBlockNum;
   
    [_animCenterBlocks enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
        
    }];
      [_animCenterBlocks removeAllObjects];
      [self.moveTempBlockVw removeFromSuperview];
   
      [self animaUI];
}

-(void)setAnimDuration:(CGFloat)animDuration{
    _animDuration = animDuration;
}



@end
