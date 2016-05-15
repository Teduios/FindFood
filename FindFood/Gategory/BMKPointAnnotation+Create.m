//
//  BMKPointAnnotation+Create.m
//  FindFood
//
//  Created by tarena on 16/4/23.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "BMKPointAnnotation+Create.h"

@implementation BMKPointAnnotation (Create)
-(void)setBusinessID:(NSString *)businessID
{
    return objc_setAssociatedObject(self, @selector(businessID), businessID, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
-(NSString *)businessID
{
    return objc_getAssociatedObject(self, _cmd);
}
@end
