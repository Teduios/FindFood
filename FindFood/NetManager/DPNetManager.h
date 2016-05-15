//
//  DPNetManager.h
//  FindFood
//
//  Created by tarena on 16/4/7.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPRequest.h"
#import "BusinessModel.h"
#import "BusinessDetailModel.h"
#import "BusinessReviewModel.h"
@import MapKit;
@interface DPNetManager : NSObject
+ (void)getBusinessesWithPage:(NSInteger)page completionHandler:(void (^)(BusinessModel *model,NSError *error))completionHandler;
+ (id)getBusinessesPointcompletionHandler:(void (^)(BusinessModel *model, NSError *error))completionHandler;
+(void)getBusinessesDetailWithCompletionHandler:(void(^)(BusinessDetailModel *model,NSError *error))completionHandler;
+(void)getBusinessesReviewsWithCompletionHandler:(void(^)(BusinessReviewModel *model,NSError *error))completionHandler;
+(void)getSearchBusinessesWithPage:(NSInteger)page completionHandler:(void (^)(BusinessModel *, NSError *))completionHandler;
@end
