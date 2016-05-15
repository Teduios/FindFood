//
//  MyInfoViewController.m
//  FindFood
//
//  Created by tarena on 16/4/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MyInfoViewController.h"

@interface MyInfoViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@end

@implementation MyInfoViewController
//取消键盘
- (IBAction)TextFieldDidEndOnExit:(id)sender {
    [self.nickNameTextField resignFirstResponder];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.nickNameTextField.becomeFirstResponder==YES) {
        [self.nickNameTextField resignFirstResponder];
    }
}
//返回
- (IBAction)backToMeMainVC:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//保存
- (IBAction)saveNickName:(id)sender
{
    if (!self.nickNameTextField.text.length==0)
    {
    [[NSUserDefaults standardUserDefaults] setObject:self.nickNameTextField.text forKey:kNickName];
    [self dismissViewControllerAnimated:YES completion:nil];
          }
}
//取消
- (IBAction)cancel:(id)sender
{
    self.nickNameTextField.text=@"";
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.nickNameTextField resignFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.nickNameTextField.text=self.currentNickName;
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
