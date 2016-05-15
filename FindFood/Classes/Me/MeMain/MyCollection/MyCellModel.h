//
//  MyCellModel.h
//  FindFood
//
//  Created by tarena on 16/4/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyCellModel : NSObject
@property (nonatomic,copy) NSString *businessName;
@property (nonatomic,copy) NSString *businessID;
@property (nonatomic,copy) NSString *time;
+(NSMutableArray *)getModelWithDict:(NSDictionary *)dict;
@end
