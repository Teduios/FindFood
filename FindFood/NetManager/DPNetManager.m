//
//  DPNetManager.m
//  FindFood
//
//  Created by tarena on 16/4/7.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "DPNetManager.h"

@implementation DPNetManager
//搜索商店名的网络请求
+(void)getSearchBusinessesWithPage:(NSInteger)page completionHandler:(void (^)(BusinessModel *, NSError *))completionHandler
{
    NSDictionary *params = @{
                             @"city":kCurrentCity,
                             @"keyword":kCurrentSearchShop,
                             @"category":kCurrentCategory
                             };
    NSString *path =[DPRequest serializeURL:@"http://api.dianping.com/v1/business/find_businesses" params:params];
    [self GET:path parameters:nil progress:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandler([BusinessModel parseJOSN:responseObj],error);
    }];
}
//搜索商店
+(void)getBusinessesWithPage:(NSInteger)page completionHandler:(void (^)(BusinessModel *, NSError *))completionHandler
{
    NSDictionary *params=nil;
    if ([kCurrentSubCity isEqualToString:@""]||[kCurrentSubCity isEqualToString:@"全部"])
    {
        params=@{
                               @"city":kCurrentCity,
                               @"platform":@2,
                               @"page":@(page),//@(数字变量)
                               @"category":kCurrentCategory,
                               @"sort":@1
                               };
    }
    else
        {
            params=@{
                 @"city":kCurrentCity,
                 @"platform":@2,
                 @"page":@(page),//@(数字变量)
                 @"category":kCurrentCategory,
                 @"sort":kCurrentSort,
                 @"region":kCurrentSubCity
                 };
        }
    NSString *path=[DPRequest serializeURL:@"http://api.dianping.com/v1/business/find_businesses" params:params];
    [self GET:path parameters:nil progress:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandler([BusinessModel parseJOSN:responseObj],error);
    }];

   }
//搜索商店详情
+(void)getBusinessesDetailWithCompletionHandler:(void (^)(BusinessDetailModel *, NSError *))completionHandler
{
    NSDictionary *params=@{@"business_ids":kCurrentShop};
    NSString *path=[DPRequest serializeURL:@"http://api.dianping.com/v1/business/get_batch_businesses_by_id" params:params];
    [self GET:path parameters:nil progress:nil completionHandler:^(id responseObj, NSError *error) {
        if (!error) {
            completionHandler([BusinessDetailModel parseJOSN:responseObj],error);
        }
        
    }];
}
//搜索商店评论
+(void)getBusinessesReviewsWithCompletionHandler:(void (^)(BusinessReviewModel *, NSError *))completionHandler
{
    NSDictionary *params = @{@"business_id":kCurrentShop};
    NSString *path=[DPRequest serializeURL:@"http://api.dianping.com/v1/review/get_recent_reviews" params:params];
    [self GET:path parameters:nil progress:nil completionHandler:^(id responseObj, NSError *error) {
        
        completionHandler([BusinessReviewModel parseJOSN:responseObj],error);
        
    }];
}

//搜索地图上的商家
+(id)getBusinessesPointcompletionHandler:(void (^)(BusinessModel *model, NSError *))completionHandler{
    NSDictionary *pa = @{
                        @"out_offset_type":@2,
                         @"latitude":@(kCurrentShowLatitude),
                         @"platform":@2,
                         @"longitude":@(kCurrentShowLongitude),
                         @"radius": @(2000),
                         @"sort":@7,
                         @"offset_type":@2,
                        @"category":kCurrentDisnes
                         };
    NSString *path = [DPRequest serializeURL:@"http://api.dianping.com/v1/business/find_businesses" params:pa];
    return [self GET:path parameters:nil progress:nil completionHandler:^(id responseObj, NSError *error) {
                completionHandler([BusinessModel parseJOSN:responseObj], error);
    }];
}


@end
