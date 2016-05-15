//
//  UIImageView+RoundImageView.m
//  FindFood
//
//  Created by tarena on 16/4/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "UIImageView+RoundImageView.h"

@implementation UIImageView (RoundImageView)
- (void) setRoundLayer
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.bounds.size.width * 0.5;
    self.layer.borderWidth = 2;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
}
-(void) setLittleRoundLayer
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.bounds.size.width *0.1;
    self.layer.borderWidth = 0.1;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
}

@end
