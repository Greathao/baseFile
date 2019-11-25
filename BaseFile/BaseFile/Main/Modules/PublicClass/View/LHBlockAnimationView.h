//
//  LHBlockAnimationView.h
//  LHProjectShell
//
//  Created by liuhao on 2019/5/10.
//  Copyright © 2019 liuhao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LHBlockAnimationView : UIView

@property (nonatomic,assign) CGFloat aBlockWide;

@property (nonatomic,assign) CGFloat aBlockHight;

@property (nonatomic,assign) CGFloat eachBlockSpec;

@property (nonatomic,assign) CGFloat animBlockNum;

@property (nonatomic,assign) CGFloat animDuration;

@property (nonatomic,assign) CGFloat animCenterY;

@property (nonatomic,assign) CGFloat animCenterX;

 
 
-(void)startAnimation;

-(void)stopAnimation;

@end

NS_ASSUME_NONNULL_END
