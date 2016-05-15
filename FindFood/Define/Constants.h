//
//  Constants.h
//  FindFood
//
//  Created by tarena on 16/4/10.
//  Copyright © 2016年 tarena. All rights reserved.
//

#ifndef Constants_h
#define Constants_h
#define equalTo(...)                     mas_equalTo(__VA_ARGS__)

#define kRGBColor(R,G,B,Alpha) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:Alpha]

//错误页面
#define  kGETERRORNotification @"GETERRORNotification"
//当前城市
#define kCurrentCityName @"kCurrentCityName"
#define kCurrentCityChangedNotification @"kCurrentCityChangedNotification"
#define kCurrentCity [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentCityName]
//当前商店
#define kCurrentShopID @"kCurrentShopID"
#define kCurrentShop [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentShopID]

//排序
#define kCurrentSortName @"kCurrentSortName"
#define kCurrentSort [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentSortName]
//搜素商店
#define kCurrentSearchShopName @"kCurrentSearchShopName"
#define kCurrentSearchShop [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentSearchShopName]

//当前城市区域
#define kCurrentSubCityName @"kCurrentSubCityName"
#define kCurrentSubCity [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentSubCityName]
//根据得到的城市
#define kCurrentRealityCityName @"kCurrentRealityCityName"
#define kCurrentRealityCity [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentRealityCityName]
//当起美食分类
#define kCurrentCategoryName @"kCurrentCategoryName"
#define kCurrentCategory [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentCategoryName]

#define kCurrentCityAndSubCityChangedNotification @"kCurrentCityAndSubCityChangedNotification"

#define kCurrentDishesName @"kCurrentDishesName"
#define kCurrentDisnes [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentDishesName]

#define kCurrentLatitude @"kCurrentLatitude"
#define kCurrentShowLatitude [[NSUserDefaults standardUserDefaults] floatForKey:kCurrentLatitude]

#define kCurrentLongitude @"kCurrentLongitude"
#define kCurrentShowLongitude [[NSUserDefaults standardUserDefaults] floatForKey:kCurrentLongitude]
#define kNickName @"kNickName"
#define kShowNickName [[NSUserDefaults standardUserDefaults] objectForKey:kNickName]

#define FILEPATH [NSHomeDirectory() stringByAppendingString:@"/Library/Preferences/collection.plist"]
#define kISCOLLECTION @"kISCOLLECT"
#define kISCOLLECT [[NSUserDefaults standardUserDefaults] boolForKey:kISCOLLECTION]
#endif /* Constants_h */
