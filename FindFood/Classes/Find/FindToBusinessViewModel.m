//
//  FindToBusinessViewModel.m
//  FindFood
//
//  Created by tarena on 16/4/22.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "FindToBusinessViewModel.h"
#import "DPNetManager.h"
@implementation FindToBusinessViewModel
-(NSInteger)rowNum
{
    return self.dataList.count;
}
-(NSMutableArray<BusinessBusinessesModel *> *)dataList
{
    if (!_dataList) {
        _dataList=[NSMutableArray array];
    }
    return _dataList;
}
-(void)getBusinessPointCompletionHandler:(void (^)(NSError *))completionHandler
{
    [DPNetManager getBusinessesPointcompletionHandler:^(BusinessModel *model, NSError *error) {
        if (!error)
        {
            [self.dataList addObjectsFromArray:model.businesses];
        }
        completionHandler(error);
    }];
}
@end
