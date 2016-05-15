//
//  BusinessReviewModel.m
//  FindFood
//
//  Created by tarena on 16/4/19.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "BusinessReviewModel.h"

@implementation BusinessReviewModel

@end

@implementation Additional_InfoModel

@end


@implementation BusinessReviewBusinessReviewModel
+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{
             @"textExcerpt":@"text_excerpt",
             @"reviewID":@"review_id",
             @"ratingSImgURL":@"rating_s_img_url",
             @"decorationRating":@"decoration_rating",
             @"serviceRating":@"service_rating",
             @"userNickname":@"user_nickName",
             @"reviewURL":@"review_url",
             @"ratingImgURL":@"rating_img_url",
             @"productRating":@"product_rating",
             @"createdTime":@"created_time",
              @"reviewRating":@"review_rating"
             };
    
}
@end


