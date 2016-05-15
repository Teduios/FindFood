//
//  BusinessCityGroupViewModel.h
//  FindFood
//
//  Created by tarena on 16/4/12.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlistDataManager.h"
#import "BusinessCityModel.h"
@interface BusinessCityGroupViewModel : NSObject
@property (nonatomic,assign) NSInteger sectionNumber;
-(NSInteger)rowNumberForSection:(NSInteger)section;
-(NSString *)titleForSection:(NSInteger)section;
-(NSString *)titleForRowAtIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic,strong) NSArray <NSString *> *indexList;
@property (nonatomic,strong) NSArray <BusinessCityModel*> *cityGroup;
-(void)getCityGroupCompletionHandler:(void(^)(NSError *error))completionHandler;
@end
