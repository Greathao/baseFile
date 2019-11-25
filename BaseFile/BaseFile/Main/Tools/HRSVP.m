

#import "HRSVP.h"
#import "SKTextProgressHUD.h"

#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

static HRSVPType SVPtype = HRSVPTypeNone;

@implementation HRSVP

/**
 *  展示提示框
 *
 *  @param type          类型
 *  @param msg           文字
 *  @param duration      时间（当type=CoreSVPTypeLoadingInterface时无效）
 *  @param allowEdit     否允许编辑
 *  @param beginBlock    提示开始时的回调
 *  @param completeBlock 提示结束时的回调
 */
+(void)showSVPWithType:(HRSVPType)type Msg:(NSString *)msg duration:(CGFloat)duration allowEdit:(BOOL)allowEdit{
    
    if(HRSVPTypeLoadingInterface != type && HRSVPTypeLoadingInterface == SVPtype){
        SVPtype = type;
        [self showSVPWithType:type Msg:msg duration:duration allowEdit:allowEdit];
        return;
    }
    
    //记录状态
    SVPtype = type;
    
    //无状态直接返回
    if (HRSVPTypeNone == type) return;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        //基本配置
        [self hudSetting];
        if(HRSVPTypeBottomMsg == type) {
            
        [SVProgressHUD setOffsetFromCenter:UIOffsetMake(0, [UIScreen mainScreen].applicationFrame.size.height * .5f-49.0f)];
        }
        
        //设置时间
        [SVProgressHUD setMinimumDismissTimeInterval:duration];
        
//        [SVProgressHUD set];
        
        //错误图片
//        [SVProgressHUD setErrorImage:[UIImage imageNamed:@"error"]];

        //成功图片
//        [SVProgressHUD setSuccessImage:[UIImage imageNamed:@"success"]];
//
//        //警告图片
//        [SVProgressHUD setInfoImage:[UIImage imageNamed:@"SVP.bundle/yellow"]];
        
        SVProgressHUDMaskType maskType= allowEdit?SVProgressHUDMaskTypeNone:SVProgressHUDMaskTypeClear;
        [SVProgressHUD setDefaultMaskType:maskType];
   
        switch (type) {
                
            case HRSVPTypeCenterMsg:
                [self dismiss];
                [SKTextProgressHUD showTextWithMsg:msg textType:SKTextTypeCenter duration:duration];
                break;
            case HRSVPTypeBottomMsg:
                [self dismiss];
                [SKTextProgressHUD showTextWithMsg:msg textType:SKTextTypeBottom duration:duration];
                break;
            case HRSVPTypeInfo:
                [SVProgressHUD showInfoWithStatus:msg];
                break;
                
            case HRSVPTypeLoadingInterface:
                [SVProgressHUD showWithStatus:msg];
                break;
                
            case HRSVPTypeError:
                [SVProgressHUD showErrorWithStatus:msg];
                break;
                
            case HRSVPTypeSuccess:
                [SVProgressHUD showSuccessWithStatus:msg];
                break;
                
            default:
                break;
        }
        
    });
}

/*
 *  进度
 */
+(void)showProgess:(CGFloat)progress Msg:(NSString *)msg maskType:(SVProgressHUDMaskType)maskType{
    
    if (progress<=0) progress = 0;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        //基本配置
        [self hudSetting];
        
//        [SVProgressHUD showProgress:progress];
        [SVProgressHUD showProgress:progress status:msg];
        
        if(progress>=1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismiss];
            });
        }
    });
}


/*
 *  基本配置
 */
+(void)hudSetting{
    
//    [SVProgressHUD setBackgroundLayerColor:[UIColor redColor]];
    
    //文字颜色
//    [SVProgressHUD setForegroundColor:rgba(241, 241, 241, 1)];
//
    // 背景为不可点击
    [SVProgressHUD setDefaultMaskType:(SVProgressHUDMaskTypeClear)];
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    //设置背景色
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
    //字体大小
    [SVProgressHUD setFont:[UIFont systemFontOfSize:16.0f]];
    
    //设置线宽
    [SVProgressHUD setRingThickness:2.f];
    
    //边角
    [SVProgressHUD setCornerRadius:4.0f];
    
}


/**
 *  隐藏提示框
 */
+(void)dismiss{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

@end
