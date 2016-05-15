//
//  NSObject+Networking.h
//  FindFood
//
//  Created by tarena on 16/4/12.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Networking)
+(id)GET:(NSString *)path parameters:(NSDictionary *)parameters progress:(void(^)(NSProgress *downloadProgress))downloadProgress completionHandler:(void(^)(id responseObj,NSError *error))completionHandler;
@end
