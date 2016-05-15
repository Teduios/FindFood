//
//  BusinessDetailModel.h
//  FindFood
//
//  Created by tarena on 16/4/17.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BusinessDetailBusinessDetailModel;
@interface BusinessDetailModel : NSObject

@property (nonatomic, copy) NSString *status;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong) NSArray<BusinessDetailBusinessDetailModel *> *businesses;

@end
@interface BusinessDetailBusinessDetailModel : NSObject
//branch_name
@property (nonatomic, copy) NSString *branchName;
//rating_s_img_url
@property (nonatomic, copy) NSString *ratingSImgURL;
//deal_count
@property (nonatomic, assign) NSInteger dealCount;

@property (nonatomic, copy) NSString *telephone;

@property (nonatomic, copy) NSString *specialties;

@property (nonatomic, copy) NSString *address;
//coupon_url
@property (nonatomic, copy) NSString *couponURL;
//product_score
@property (nonatomic, assign) CGFloat productScore;
//has_deal
@property (nonatomic, assign) NSInteger hasDeal;
//popular_dishes
@property (nonatomic, copy) NSString *popularDishes;
//online_reservation_url
@property (nonatomic, copy) NSString *onlineReservationURL;
//review_list_url
@property (nonatomic, copy) NSString *reviewListURL;
//business_url
@property (nonatomic, copy) NSString *businessURL;
//product_grade
@property (nonatomic, assign) NSInteger productGrade;
//coupon_description
@property (nonatomic, copy) NSString *couponDescription;
//photo_list_url
@property (nonatomic, copy) NSString *photoListURL;
//rating_img_url
@property (nonatomic, copy) NSString *ratingImgURL;
//avg_rating
@property (nonatomic, assign) NSInteger avgRating;

@property (nonatomic, copy) NSString *name;
//has_online_reservation
@property (nonatomic, assign) NSInteger hasOnlineReservation;

@property (nonatomic, assign) CGFloat longitude;

@property (nonatomic, copy) NSString *city;
//service_score
@property (nonatomic, assign) CGFloat serviceScore;
//has_coupon
@property (nonatomic, assign) NSInteger hasCoupon;
//business_id
@property (nonatomic, assign) NSInteger businessID;
//coupon_id
@property (nonatomic, assign) NSInteger couponID;

@property (nonatomic, strong) NSArray *deals;

@property (nonatomic, strong) NSArray<NSString *> *categories;
//decoration_grade
@property (nonatomic, assign) NSInteger decorationGrade;
//service_grade
@property (nonatomic, assign) NSInteger serviceGrade;
//photo_url
@property (nonatomic, copy) NSString *photoURL;

@property (nonatomic, strong) NSArray<NSString *> *regions;
//review_count
@property (nonatomic, assign) NSInteger reviewCount;
//avg_price
@property (nonatomic, assign) NSInteger avgPrice;
//s_photo_url
@property (nonatomic, copy) NSString *sPhotoURL;
//photo_count
@property (nonatomic, assign) NSInteger photoCount;

@property (nonatomic, copy) NSString *hours;
//decoration_score
@property (nonatomic, assign) CGFloat decorationScore;

@property (nonatomic, assign) CGFloat latitude;

@end

