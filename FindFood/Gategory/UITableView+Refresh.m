//
//  UITableView+Refresh.m
//  FindFood
//
//  Created by tarena on 16/4/12.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "UITableView+Refresh.h"

@implementation UITableView (Refresh)
-(void)addHeaderRefresh:(MJRefreshComponentRefreshingBlock)block
{
    self.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:block];
}
-(void)beginHeaderRefresh
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mj_header beginRefreshing];
           });
}
-(void)endHeaderRefresh
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mj_header endRefreshing];
    });
}
-(void)addAutoFooterRefresh:(MJRefreshComponentRefreshingBlock)block
{
    self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:block];
}
-(void)addBackFooterRefresh:(MJRefreshComponentRefreshingBlock)block
{
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:block];
}
-(void)beginFooterRefresh
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mj_footer beginRefreshing];
    });
}
-(void)endFooterRefresh
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mj_footer endRefreshing];
    });
}
@end
