//
//  AlertViewController.m
//  FindFood
//
//  Created by tarena on 16/4/20.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "AlertViewController.h"

@interface AlertViewController ()<UIPopoverPresentationControllerDelegate>

@end

@implementation AlertViewController
#pragma mark --UIPopoverPresentationControllerDelegate 方法
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller traitCollection:(UITraitCollection *)traitCollection{
    return UIModalPresentationNone;
}
- (instancetype)initWithSourceView:(UIView *)sourceView sourceRect:(CGRect)sourceRect contentSize:(CGSize)contentSize{
    self = [super init];
    if (self) {
        _sourceRect = sourceRect;
        _contentSize = contentSize;
        _sourceView = sourceView;
        //设置当前控制器的弹出方式是popover
        self.modalPresentationStyle = UIModalPresentationPopover;
        self.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
       
        self.popoverPresentationController.delegate = self;
        self.popoverPresentationController.sourceView = _sourceView;
        self.popoverPresentationController.sourceRect = _sourceRect;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.preferredContentSize = _contentSize;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
