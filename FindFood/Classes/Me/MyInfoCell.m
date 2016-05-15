//
//  MyInfoCell.m
//  FindFood
//
//  Created by tarena on 16/4/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MyInfoCell.h"
#import "MyInfoViewController.h"
@interface MyInfoCell ()

@end
@implementation MyInfoCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:NO];
    ((UILabel *)[self viewWithTag:100]).text=kShowNickName;
    // Configure the view for the selected state
}

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//    MyInfoViewController *miVc=[story instantiateViewControllerWithIdentifier:@"MyInfoViewController"];
//   // miVc.currentNickName =((UILabel *)[self viewWithTag:100]).text;
//    [self.viewController presentViewController:miVc animated:YES completion:nil];
//}
@end
