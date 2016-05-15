//
//  UIView+HUD.h
//  FindFood
//
//  Created by tarena on 16/4/29.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HUD)
/** 显示文字提示 */
- (void)showWarning:(NSString *)words;

/** 显示忙提示 */
- (void)showBusyHUD:(NSString *)words;
/** 隐藏忙提示 */
- (void)hideBusyHUD;
@end
