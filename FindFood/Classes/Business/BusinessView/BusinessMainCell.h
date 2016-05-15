//
//  BusinessMainCell.h
//  FindFood
//
//  Created by tarena on 16/5/10.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusinessMainCell : UITableViewCell
@property (nonatomic,copy) NSString *price;
@property (weak, nonatomic) IBOutlet UIImageView *iconIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *saleNumLabel;
@property (weak, nonatomic) IBOutlet UIImageView *firstStarImageView;
@property (weak, nonatomic) IBOutlet UIImageView *secondStarImageView;
@property (weak, nonatomic) IBOutlet UIImageView *thirdStarImageView;
@property (weak, nonatomic) IBOutlet UIImageView *fourthStarImageView;
@property (weak, nonatomic) IBOutlet UIImageView *fifthStarImageView;
-(void)showStarForShopAvgRating:(float)avgRating;
@end
