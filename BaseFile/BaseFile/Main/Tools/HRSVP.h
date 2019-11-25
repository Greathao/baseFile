

#import <Foundation/Foundation.h>
#import "SVProgressHUD.h"

#define HRSVPURLLoading         HRSVPLoading(@"请稍后...",NO)
#define HRSVPInfo(msg)          [HRSVP showSVPWithType:HRSVPTypeInfo Msg:msg duration:0.5 allowEdit:NO];
#define HRSVPError(msg)         [HRSVP showSVPWithType:HRSVPTypeError Msg:msg duration:0.5 allowEdit:NO];
#define HRSVPSuccess(msg)       [HRSVP showSVPWithType:HRSVPTypeSuccess Msg:msg duration:0.5 allowEdit:NO];
#define HRSVPLoading(msg,allow) [HRSVP showSVPWithType:HRSVPTypeLoadingInterface Msg:msg duration:0 allowEdit:allow];

#define HRSVPDataError  HRSVPError(@"网络错误，请稍后重试");


#define HRSVPCenterMsg(msg) [HRSVP showSVPWithType:HRSVPTypeCenterMsg Msg:msg duration:0.2 allowEdit:YES];
#define HRSVPBottomMsg(msg) [HRSVP showSVPWithType:HRSVPTypeBottomMsg Msg:msg duration:0.2 allowEdit:YES];

typedef enum {
    
    //默认无状态
    HRSVPTypeNone=0,
    
    //无图片普通提示，显示在屏幕正中间
    HRSVPTypeCenterMsg,
    
    //无图片普通提示，显示在屏幕下方，tabbar之上
    HRSVPTypeBottomMsg,
    
    //Info
    HRSVPTypeInfo,
    
    //Progress,可以互
    HRSVPTypeLoadingInterface,
    
    //error
    HRSVPTypeError,
    
    //success
    HRSVPTypeSuccess
    
}HRSVPType;

@interface HRSVP : NSObject


/**
 *  展示提示框
 *
 *  @param type          类型
 *  @param msg           文字
 *  @param duration      时间（当type=CoreSVPTypeLoadingInterface时无效）
 *  @param allowEdit     否允许编辑
 */
+(void)showSVPWithType:(HRSVPType)type Msg:(NSString *)msg duration:(CGFloat)duration allowEdit:(BOOL)allowEdit;

/*
 *  进度
 */
+(void)showProgess:(CGFloat)progress Msg:(NSString *)msg maskType:(SVProgressHUDMaskType)maskType;

/**
 *  隐藏提示框
 */
+(void)dismiss;

@end
