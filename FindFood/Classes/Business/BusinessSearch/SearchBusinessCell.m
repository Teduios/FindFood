//
//  SearchBusinessCell.m
//  FindFood
//
//  Created by tarena on 16/4/21.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "SearchBusinessCell.h"

@implementation SearchBusinessCell

- (void)awakeFromNib {
    // Initialization code
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
    _priceLb.attributedText=str;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
