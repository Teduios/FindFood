//
//  BusinessDetailViewModel.h
//  FindFood
//
//  Created by tarena on 16/4/18.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BusinessDetailModel.h"

@interface BusinessDetailViewModel : NSObject
@property (nonatomic,assign) NSInteger *rowNum;
@property (nonatomic,strong) NSArray <BusinessDetailBusinessDetailModel *> *dataList;
-(NSURL *)showWithShopImgURL;
-(NSString *)showWithCategories;
-(NSString *)showWithPopularDishes;
-(NSString *)showWithAddress;
-(NSString *)showWithTelephone;
-(NSString *)showWithSpecialties;
-(NSString *)showWithHours;
-(NSString *)showWithReviewCount;
-(NSString *)showWithBusinessID;
-(void)getBussinessWithCompletionHandler:(void (^)(NSError *))completionHandler;
@end
