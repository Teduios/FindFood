//
//  UILabel+RoundLabel.m
//  FindFood
//
//  Created by tarena on 16/4/30.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "UILabel+RoundLabel.h"

@implementation UILabel (RoundLabel)
- (void) setRoundLayer
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.bounds.size.width * 0.1;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor grayColor].CGColor;
}
@end
