//
//  BusinessCityGroupViewModel.m
//  FindFood
//
//  Created by tarena on 16/4/12.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "BusinessCityGroupViewModel.h"

@implementation BusinessCityGroupViewModel
-(NSInteger)sectionNumber
{
    return self.cityGroup.count;
}
-(NSString *)titleForSection:(NSInteger)section
{
    return [self.cityGroup[section] title];
}
-(NSString *)titleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.cityGroup[indexPath.section] cities][indexPath.row];
}
-(NSArray<NSString *> *)indexList
{
    return [self.cityGroup valueForKey:@"title"];
}
-(NSInteger)rowNumberForSection:(NSInteger)section
{
    return [self.cityGroup[section] cities].count;
}
-(void)getCityGroupCompletionHandler:(void (^)(NSError *))completionHandler
{
    [PlistDataManager getCityGroup:^(NSArray<BusinessCityModel *> *cityGroup, NSError *error) {
        self.cityGroup=cityGroup;
        completionHandler(error);
    }];
}
@end
