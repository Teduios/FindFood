//
//  SortViewController.h
//  FindFood
//
//  Created by tarena on 16/4/21.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "AlertViewController.h"

@interface SortViewController : AlertViewController
@property (nonatomic, copy) void(^chooseBlock)(NSString *sortValue,NSInteger sortNum);
@end
