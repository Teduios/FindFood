//
//  BusinessMainCell.m
//  FindFood
//
//  Created by tarena on 16/5/10.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "BusinessMainCell.h"

@implementation BusinessMainCell

- (void)awakeFromNib {
//    self.separatorInset=UIEdgeInsetsZero;
//    self.layoutMargins=UIEdgeInsetsZero;
//    self.preservesSuperviewLayoutMargins=NO;
}
-(void)setPrice:(NSString *)price
{
    _price=price;
    NSDictionary *str1Dict=@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor redColor]};
    NSAttributedString *str1=[[NSAttributedString alloc]initWithString:@"￥" attributes:str1Dict];
    NSDictionary *str2Dict=@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor blackColor]};
    NSAttributedString *str2=[[NSAttributedString alloc]initWithString:price attributes:str2Dict];
    NSMutableAttributedString *str=[NSMutableAttributedString new];
    [str appendAttributedString:str1];
    [str appendAttributedString:str2];
   _priceLabel.attributedText=str;
}

-(void)showStarForShopAvgRating:(float)avgRating
{
    
    if ((int)avgRating==0)
    {
        return ;
    }
    else if(((int)avgRating)*10%10==0)
    {
        switch (((int)avgRating)*10/10) {
            case 1:self.firstStarImageView.image=[self star2Image];
                break;
            case 2:self.firstStarImageView.image=self.secondStarImageView.image=[self star2Image];
                break;
            case 3:self.firstStarImageView.image=self.secondStarImageView.image=self.thirdStarImageView.image=[self star2Image];
                break;
            case 4:self.firstStarImageView.image=self.secondStarImageView.image=self.thirdStarImageView.image=self.fourthStarImageView.image=[self star2Image];
                break;
            case 5:self.firstStarImageView.image=self.secondStarImageView.image=self.thirdStarImageView.image=self.fourthStarImageView.image=self.fifthStarImageView.image=[self star2Image];
                break;
            default:
                break;
        }
    }
    else if(((int)avgRating)*10%10!=0)
    {
        switch (((int)avgRating)*10/10) {
            case 1:self.firstStarImageView.image=[self star2Image];self.secondStarImageView.image=[self star3Image];
                break;
            case 2:self.firstStarImageView.image=self.secondStarImageView.image=[self star2Image];self.thirdStarImageView.image=[self star3Image];
                break;
            case 3:self.firstStarImageView.image=self.secondStarImageView.image=self.thirdStarImageView.image=[self star2Image];self.fourthStarImageView.image=[self star3Image];
                break;
            case 4:self.firstStarImageView.image=self.secondStarImageView.image=self.thirdStarImageView.image=self.fourthStarImageView.image=[self star2Image];self.fifthStarImageView.image=[self star3Image];
                break;
            default:
                break;
        }
    }
}
-(UIImage *)star2Image
{
    UIImage *image=[UIImage imageNamed:@"icon_star2"];
    return image;
}
-(UIImage *)star3Image
{
    UIImage *image=[UIImage imageNamed:@"icon_star3"];
    return image;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
