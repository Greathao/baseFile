//
//  SKTextProgressHUD.m
//  ShareSpace
//
//  Created by 海狸先生 on 2018/3/20.
//  Copyright © 2018年 SK. All rights reserved.
//

#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#import "SKTextProgressHUD.h"

@interface SKTextProgressHUD ()

@property (nonatomic, assign) CGFloat duration;

@end

@implementation SKTextProgressHUD

+ (void)showTextWithMsg:(NSString *)msg
               textType:(SKTextType)textType
               duration:(CGFloat)duration{
    [[[self alloc] initWithText:msg textType:textType duration:duration] show];
    
}

- (instancetype)initWithText:(NSString *)msg
                    textType:(SKTextType)textType
                    duration:(CGFloat)duration
{
    self = [super init];
    if (self) {
        
        self.alpha = 0.0f;
        _duration = duration;
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        CGSize textSize = [ValidateHelper sizeOfText:msg theFont:SixteenFontSize theWidth:kScreenWidth - 40];
        
        CGFloat self_X = 0.0f;
        CGFloat self_Y = 0.0f;
        CGFloat self_W = textSize.width + 20;
        CGFloat self_H = textSize.height + 16;
        
        self.frame = CGRectMake(self_X, self_Y, self_W, self_H);
        switch (textType) {
            case SKTextTypeUp:
                self.center = CGPointMake(kScreenWidth/2, kScreenHeight/6);
                break;
            case SKTextTypeCenter:
                self.center = window.center;
                break;
            case SKTextTypeBottom:
                self.center = CGPointMake(kScreenWidth/2, kScreenHeight/6*4);
                break;
            default:
                break;
        }
        self.backgroundColor = UIColor666;
        [self setCornerRadius:4];
        [self initViewAndText:msg];
        [window addSubview:self];
    }
    return self;
}

- (void)initViewAndText:(NSString *)text{
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, CGRectGetWidth(self.frame) - 20, CGRectGetHeight(self.frame)-16)];
    lable.textColor = UIColorWhite;
    lable.numberOfLines = 0;
    lable.text = text;
    lable.font = SixteenFontSize;
    [self addSubview:lable];
}

- (void)show{
    [UIView animateWithDuration:_duration animations:^{
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismiss];
        });
    }];
    
}

- (void)dismiss{
    [UIView animateWithDuration:_duration animations:^{
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
    
}

@end
