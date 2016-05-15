//
//  SearchBusinessViewModel.h
//  FindFood
//
//  Created by tarena on 16/4/21.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPNetManager.h"
typedef NS_ENUM(NSUInteger,RequestMode)
{
    RequestModeRefresh,
    RequestModeMore,
};
@interface SearchBusinessViewModel : NSObject
@property (nonatomic)NSInteger rowNumber;
-(NSURL *)showIconURLForIndex:(NSInteger)index;
-(NSString *)showShopNameForIndex:(NSInteger)index;
-(NSString *)showSaleNumForIndex:(NSInteger)index;
-(NSURL *)showAvgRatingForIndex:(NSInteger)index;
-(NSString *)currentPriceForIndex:(NSInteger)index;
-(NSString *)showBusinessIDForIndex:(NSInteger)index;

@property (nonatomic,strong) NSMutableArray <BusinessBusinessesModel*> *searchDataList;

@property (nonatomic,assign)NSInteger pageNum;
-(void)getSearchBusinessWithRequestMode:(RequestMode)requestMode completionHandler:(void(^)(NSError *error))completionHandler;
@end
