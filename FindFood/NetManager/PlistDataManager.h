//
//  PlistDataManager.h
//  FindFood
//
//  Created by tarena on 16/4/7.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BusinessCityModel.h"
#import "CitiesModel.h"
#import "SortsModel.h"
#import "FindDishesModel.h"
@interface PlistDataManager : NSObject
+(void)getCityGroup:(void(^)(NSArray <BusinessCityModel *>*cityGroup,NSError *error))completionHandler;
+ (void)getSorts:(void (^)(NSArray<SortsModel *> *sorts, NSError *))completionHandler;

+ (void)getCities:(void(^)(NSArray<CitiesModel *> *cities, NSError *error))completionHandler;

+(void)getDishes:(void(^)(NSArray<FindDishesModel *> *dishes,NSError *error))completionHandler;

@end
