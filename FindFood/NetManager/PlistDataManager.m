//
//  PlistDataManager.m
//  FindFood
//
//  Created by tarena on 16/4/7.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "PlistDataManager.h"

@implementation PlistDataManager
+(void)getCityGroup:(void(^)(NSArray <BusinessCityModel *>*cityGroup,NSError *error))completionHandler;
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *CityGroupPath=[[NSBundle mainBundle] pathForResource:@"cityGroups" ofType:@"plist"];
        NSArray *arr=[NSArray arrayWithContentsOfFile:CityGroupPath];
        NSArray *cityGroup=[BusinessCityModel parseJOSN:arr];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(cityGroup,nil);
            
        });
    });
}
+ (NSArray *)getArrFromPlist:(NSString *)plistName{
    return [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"]];
}


+ (void)getCities:(void (^)(NSArray<CitiesModel *> *, NSError *))completionHandler{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSArray *tmpArr = [CitiesModel parseJOSN:[self getArrFromPlist:@"cities"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(tmpArr, nil);
        });
     
      
    });
   
}

+ (void)getSorts:(void (^)(NSArray<SortsModel *> *, NSError *))completionHandler{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *tmpArr = [SortsModel parseJOSN:[self getArrFromPlist:@"sorts"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(tmpArr, nil);
        });
    });
}
+(void)getDishes:(void (^)(NSArray<FindDishesModel *> *, NSError *))completionHandler
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *tmpArr=[FindDishesModel parseJOSN:[self getArrFromPlist:@"dishes"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(tmpArr,nil);
        });
    });
}

@end
