//
//  UIView+Extensions.h
//  iCampsite
//
//  Created by 海狸先生 on 16/4/14.
//  Copyright © 2016年 海狸先生. All rights reserved.
//

#import "UIDevice-Extensions.h"

@implementation UIDevice (UIDevice_Extensions)

+ (void)callAction:(NSString*)phoneNum target:(UIView*)view{
    NSArray *phoneNumList = [phoneNum componentsSeparatedByString:@"/"];
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",[phoneNumList firstObject]]];
    UIWebView *phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
    [view addSubview:phoneCallWebView];
    [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
}

+ (void)switchNewOrientation:(UIInterfaceOrientation)interfaceOrientation {
    NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
    [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
    NSNumber *orientationTarget = [NSNumber numberWithInt:interfaceOrientation];
    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
}


@end

