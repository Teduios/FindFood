//
//  NSObject+Networking.m
//  FindFood
//
//  Created by tarena on 16/4/12.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "NSObject+Networking.h"

@implementation NSObject (Networking)
+(id)GET:(NSString *)path parameters:(NSDictionary *)parameters progress:(void (^)(NSProgress *))downloadProgress completionHandler:(void (^)(id, NSError *))completionHandler
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"text/plain",@"text/json",@"text/javasript",@"application/json", nil];
    return [manager GET:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completionHandler(responseObject,nil);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GETRIGHTNotification" object:self userInfo:@{@"error":@""}];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GETERRORNotification" object:self userInfo:@{@"error":error}];
    }];
}

@end
