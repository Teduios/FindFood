//
//  BusinessReviewModel.h
//  FindFood
//
//  Created by tarena on 16/4/19.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Additional_InfoModel,BusinessReviewBusinessReviewModel;
@interface BusinessReviewModel : NSObject

@property (nonatomic, copy) NSString *status;

@property (nonatomic, strong) NSArray<BusinessReviewBusinessReviewModel *> *reviews;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong) Additional_InfoModel *additional_info;

@end
@interface Additional_InfoModel : NSObject

@property (nonatomic, copy) NSString *more_reviews_url;

@end

@interface BusinessReviewBusinessReviewModel : NSObject
//text_excerpt
@property (nonatomic, copy) NSString *textExcerpt;
//review_id
@property (nonatomic, assign) NSInteger reviewID;
//rating_s_img_url
@property (nonatomic, copy) NSString *ratingSImgURL;
//decoration_rating
@property (nonatomic, assign) NSInteger decorationRating;
//service_rating
@property (nonatomic, assign) NSInteger serviceRating;
//user_nickname
@property (nonatomic, copy) NSString *userNickName;
//review_url
@property (nonatomic, copy) NSString *reviewURL;
//rating_img_url
@property (nonatomic, copy) NSString *ratingImgURL;
//product_rating
@property (nonatomic, assign) NSInteger productRating;
//created_time
@property (nonatomic, copy) NSString *createdTime;
//review_rating
@property (nonatomic, assign) NSInteger reviewRating;

@end

