//
//  FindToBusinessViewModel.h
//  FindFood
//
//  Created by tarena on 16/4/22.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BusinessModel.h"
@interface FindToBusinessViewModel : NSObject 
@property (nonatomic,assign) NSInteger rowNum;
@property (nonatomic,strong) NSMutableArray <BusinessBusinessesModel *>*dataList;
-(void)getBusinessPointCompletionHandler:(void(^)(NSError *error))completionHandler;

@end
