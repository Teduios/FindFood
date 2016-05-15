//
//  BusinessReviewViewModel.m
//  FindFood
//
//  Created by tarena on 16/4/19.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "BusinessReviewViewModel.h"
#import "DPNetManager.h"
@implementation BusinessReviewViewModel
-(NSInteger)rowNumber
{

    return self.ReviewDataList.count;
}
-(NSString *)showUserNickNameForIndex:(NSInteger)index
{
    return [self.ReviewDataList[index] valueForKey:@"user_nickname"];
}
-(NSURL *)showReviewRatingURLForIndex:(NSInteger)index
{
    return [NSURL URLWithString:[self.ReviewDataList[index] valueForKey:@"rating_img_url"]];
}
-(NSString *)showProductScoreForIndex:(NSInteger)index
{
    return [NSString stringWithFormat:@"%@分",[self.ReviewDataList[index] valueForKey:@"product_rating"]];
}
-(NSString *)showServiceScoreForIndex:(NSInteger)index
{
    return [NSString stringWithFormat:@"%@分",[self.ReviewDataList[index] valueForKey:@"service_rating"]];
}
-(NSString *)showDecorationScoreForIndex:(NSInteger)index
{
    return [NSString stringWithFormat:@"%@分",[self.ReviewDataList[index] valueForKey:@"decoration_rating"]];
}
-(NSString *)showTextExcerptForIndex:(NSInteger)index
{
    return [NSString stringWithFormat:@"%@ %@",[self.ReviewDataList[index] valueForKey:@"created_time"],[self.ReviewDataList[index] valueForKey:@"text_excerpt"]];
}
-(NSMutableArray<BusinessReviewBusinessReviewModel *> *)ReviewDataList
{
    if (!_ReviewDataList) {
        _ReviewDataList=[NSMutableArray array];
    }
    return _ReviewDataList;
    
}
-(void)getBussinessWithRequestReviews:(RequestReviews)RequestReviews completionHandler:(void (^)(NSError *))completionHandler
{
        [DPNetManager getBusinessesReviewsWithCompletionHandler:^(BusinessReviewModel *model, NSError *error) {
    
            if (!error)
            {
                if (model.count>=3)
                {
                    if (RequestReviews==RequestReviewsLittle)
                        {
                           
                            for (int i=0; i<2;i++)
                            {
                                
                                [self.ReviewDataList addObject:model.reviews[i]];
                            }
                           
                        }
                    else
                    {
                        
                        for (int i=2; i<model.reviews.count; i++)
                        {
                            [self.ReviewDataList addObject:model.reviews[i]];
                        }
                        
                    }
                }
                else
                {
                    [self.ReviewDataList removeAllObjects];
                    [self.ReviewDataList addObjectsFromArray:model.reviews];
                }
            
            }
            completionHandler(error);
        }];
}

@end
