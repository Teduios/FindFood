//
//  AlertViewController.h
//  FindFood
//
//  Created by tarena on 16/4/20.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertViewController : UIViewController 
//弹出的控制器需要知道从哪个视图,哪个位置弹出来,弹出的内容多大.
- (instancetype)initWithSourceView:(UIView *)sourceView sourceRect:(CGRect)sourceRect contentSize:(CGSize)contentSize;
/** 位置 */
@property (nonatomic,readonly) CGSize contentSize;
/** 大小 */
@property (nonatomic, readonly) CGRect sourceRect;
/** 哪个视图 */
@property (nonatomic, weak,readonly) UIView *sourceView;
@end
