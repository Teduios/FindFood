//
//  BusinessReviewViewCell.h
//  FindFood
//
//  Created by tarena on 16/4/19.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusinessReviewViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *userNickNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *reviewRatingImageView;
@property (weak, nonatomic) IBOutlet UILabel *productScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *serviceScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *decorationScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *textExcerptLabel;

@end
