//
//  AppDelegate.m
//  FindFood
//
//  Created by tarena on 16/3/31.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Location.h"

@interface AppDelegate () <BMKGeneralDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupLocation];
    [self setup];
    [self configGloabeUI];
    self.manager = [BMKMapManager new];
    BOOL ret=[self.manager start:@"7s2ZVROgZH72YkB2vFHcEn0l51wWUBp8" generalDelegate:self];
    if (ret) {
//        NSLog(@"地图开启成功");
    }
    return YES;
}
-(void)setup
{
    if (!kCurrentSort) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
             [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:kCurrentSortName];
        });
    }
    
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
           [[NSUserDefaults standardUserDefaults] setObject:@"美食" forKey:kCurrentCategoryName];
        });
   
    if (!kCurrentSubCity) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [[NSUserDefaults standardUserDefaults] setObject:@"全部"
                                                      forKey:kCurrentSubCityName];
        });
    }
    if (!kShowNickName) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [[NSUserDefaults standardUserDefaults] setObject:@"用户123"
                                                      forKey:kNickName];
        });
    }
}
-(void)configGloabeUI
{
    self.window.tintColor=[UIColor blackColor];
    [[UITabBar appearance] setTintColor:kRGBColor(245,202,10, 1.0)];
    [[UINavigationBar appearance] setBarTintColor:kRGBColor(245, 202,10,1.0)];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:20]}];
}

- (void)applicationWillResignActive:(UIApplication *)application {
  //  [BMKMapView willBackGround];
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough apeeeeeplication state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  //  [BMKMapView didForeGround];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
