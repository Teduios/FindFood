//
//  BusinessReviewViewModel.h
//  FindFood
//
//  Created by tarena on 16/4/19.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BusinessReviewModel.h"
typedef enum
{
    RequestReviewsLittle,
    RequestReviewsMore
}RequestReviews;
@interface BusinessReviewViewModel : NSObject
@property (nonatomic)NSInteger rowNumber;
-(NSString *)showUserNickNameForIndex:(NSInteger)index;
-(NSURL *)showReviewRatingURLForIndex:(NSInteger)index;
-(NSString *)showProductScoreForIndex:(NSInteger)index;
-(NSString *)showServiceScoreForIndex:(NSInteger)index;
-(NSString *)showDecorationScoreForIndex:(NSInteger)index;
-(NSString *)showTextExcerptForIndex:(NSInteger)index;

@property (nonatomic,strong) NSMutableArray <BusinessReviewBusinessReviewModel*> *ReviewDataList;
-(void)getBussinessWithRequestReviews:(RequestReviews)RequestReviews   completionHandler:(void(^)(NSError *error))completionHandler;
@end
