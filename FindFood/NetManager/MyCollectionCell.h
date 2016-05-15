//
//  MyCollectionCell.h
//  FindFood
//
//  Created by tarena on 16/4/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *businessName;
@property (weak, nonatomic) IBOutlet UILabel *saveTime;
@property (nonatomic,copy) NSString *businessID;
@property (weak, nonatomic) IBOutlet UIImageView *collectImageView;

@end
