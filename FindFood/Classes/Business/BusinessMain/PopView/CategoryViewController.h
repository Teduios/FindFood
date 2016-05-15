//
//  CategoryViewController.h
//  FindFood
//
//  Created by tarena on 16/4/20.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlertViewController.h"
@interface CategoryViewController : AlertViewController
@property (nonatomic, copy)void (^ChooseBlock)(NSString *subCategory);
@end
