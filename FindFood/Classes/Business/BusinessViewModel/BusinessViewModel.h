//
//  BusinessViewModel.h
//  FindFood
//
//  Created by tarena on 16/4/7.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPNetManager.h"
typedef NS_ENUM(NSUInteger,RequestMode)
{
    RequestModeRefresh,
    RequestModeMore,
};
@interface BusinessViewModel : NSObject
@property (nonatomic)NSInteger rowNumber;
-(NSURL *)businessURLForIndex:(NSInteger)index;
-(NSURL *)iconURLForIndex:(NSInteger)index;
-(NSString *)shopNameForIndex:(NSInteger)index;
-(NSString *)discountForIndex:(NSInteger)index;
-(NSString *)saleNumForIndex:(NSInteger)index;
-(NSString *)businessIDForIndex:(NSInteger)index;
//-(NSString *)orginalPriceForForIndex:(NSInteger)index;
-(NSString *)currentPriceForIndex:(NSInteger)index;
-(float)shopAvgRatingForIndex:(NSInteger)index;
-(NSURL *)avgRatingForIndex:(NSInteger)index;

@property (nonatomic,strong) NSMutableArray <BusinessBusinessesModel *> *dataList;


@property (nonatomic,assign)NSInteger pageNum;
-(void)getBussinessWithRequestMode:(RequestMode)requestMode completionHandler:(void(^)(NSError *error))completionHandler;

@end
