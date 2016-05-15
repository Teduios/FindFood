//
//  MyCellModel.m
//  FindFood
//
//  Created by tarena on 16/4/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MyCellModel.h"

@implementation MyCellModel
+(NSMutableArray *)getModelWithDict:(NSDictionary *)dict
{
    NSMutableArray *array=[NSMutableArray array];
    
   for (NSString *s in [dict allValues])
   {
       if ([s rangeOfString:@","].location ==NSNotFound) {
           MyCellModel *model=[[MyCellModel alloc]init];
           model.businessID = s;
           model.businessName = [dict[s] substringToIndex:[dict[s] rangeOfString:@","].location];
           model.time=[dict[s] substringFromIndex:[dict[s] rangeOfString:@","].location+1];
           [array addObject:model];
       }
   }
    return array;
}
@end
