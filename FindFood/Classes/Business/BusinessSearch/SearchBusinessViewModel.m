//
//  SearchBusinessViewModel.m
//  FindFood
//
//  Created by tarena on 16/4/21.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "SearchBusinessViewModel.h"

@implementation SearchBusinessViewModel
-(NSMutableArray<BusinessBusinessesModel *> *)searchDataList
{
    if (!_searchDataList) {
        _searchDataList = [NSMutableArray array];
    }
    return _searchDataList;
}
-(NSInteger)rowNumber
{
    return self.searchDataList.count;
}
-(NSURL *)showIconURLForIndex:(NSInteger)index
{
   return [NSURL URLWithString:self.searchDataList[index].photoURL];
}
-(NSString *)showShopNameForIndex:(NSInteger)index
{
    return self.searchDataList[index].name;
}
-(NSString *)showSaleNumForIndex:(NSInteger)index
{
    return [NSString stringWithFormat:@"浏览%ld",(long)self.searchDataList[index].reviewCount];
}
-(NSURL *)showAvgRatingForIndex:(NSInteger)index
{
    return [NSURL URLWithString:self.searchDataList[index].ratingImgURL];
    
}
-(NSString *)showBusinessIDForIndex:(NSInteger)index
{
    return [NSString stringWithFormat:@"%ld",(long)self.searchDataList[index].businessId];
}
-(NSString *)currentPriceForIndex:(NSInteger)index
{
    return @(self.searchDataList[index].avgPrice).stringValue;
}
-(void)getSearchBusinessWithRequestMode:(RequestMode)requestMode completionHandler:(void(^)(NSError *error))completionHandler
{
    NSInteger tmpPage=1;
    if (requestMode==RequestModeMore) {
        tmpPage=_pageNum + 1;
    }
    [DPNetManager getSearchBusinessesWithPage:tmpPage completionHandler:^(BusinessModel *model, NSError *error) {
        if (!error)
        {
            _pageNum = tmpPage;
            if (requestMode==RequestModeRefresh)
            {
                [self.searchDataList removeAllObjects];
            }
            [self.searchDataList addObjectsFromArray:model.businesses];
        }
        completionHandler(error);
    }];
}

@end
