//
//  UIView+HUD.m
//  FindFood
//
//  Created by tarena on 16/4/29.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "UIView+HUD.h"
#define kShowWarningDelayDuration   1
#define kTimeoutDuration 0.5
@implementation UIView (HUD)
- (void)showWarning:(NSString *)words{
//    为使用者考虑, 如果子线程执行此方法会崩溃, 我们要把方法做成线程安全的.
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:self animated:NO];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = words;
        [hud hide:NO afterDelay:kShowWarningDelayDuration];
    });
}
- (void)showBusyHUD:(NSString *)words{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud =[MBProgressHUD showHUDAddedTo:self animated:NO];
        hud.mode = MBProgressHUDModeText;
        hud.labelText =words;
        [hud hide:NO afterDelay:kTimeoutDuration];
    });
}
- (void)hideBusyHUD{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:self animated:NO];
    });
    
}

@end
