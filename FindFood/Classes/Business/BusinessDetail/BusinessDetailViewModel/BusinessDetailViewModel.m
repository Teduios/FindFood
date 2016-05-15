//
//  BusinessDetailViewModel.m
//  FindFood
//
//  Created by tarena on 16/4/18.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "BusinessDetailViewModel.h"
#import "DPNetManager.h"
@implementation BusinessDetailViewModel
-(NSURL *)showWithShopImgURL
{
    return [NSURL URLWithString:[self.dataList[0] valueForKey:@"s_photo_url"]];
   
}

-(NSString *)showWithCategories
{
    return [self.dataList[0] valueForKey:@"categories"][0];
}
-(NSString *)showWithPopularDishes
{
    return [self.dataList[0] valueForKey:@"popular_dishes"];
}
-(NSString *)showWithAddress
{
    return [self.dataList[0] valueForKey:@"address"];
}
-(NSString *)showWithTelephone
{
    return [self.dataList[0] valueForKey:@"telephone"];
}
-(NSString *)showWithSpecialties
{
    return [self.dataList[0] valueForKey:@"specialties"];
}
-(NSString *)showWithHours
{
    return [self.dataList[0] valueForKey:@"hours"];
}
-(NSString *)showWithReviewCount
{
    return [self.dataList[0] valueForKey:@"review_count"];
}
-(NSString *)showWithBusinessID
{
    return [self.dataList[0] valueForKey:@"business_id"];
}
-(void)getBussinessWithCompletionHandler:(void (^)(NSError *))completionHandler
{
    [DPNetManager getBusinessesDetailWithCompletionHandler:^(BusinessDetailModel *model, NSError *error) {
        self.dataList = model.businesses;
       
        completionHandler(error);
    }];
}
@end
