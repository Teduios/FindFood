//
//  FindDishesViewController.m
//  FindFood
//
//  Created by tarena on 16/4/27.
//  Copyright © 2016年 tarena. All rights reserved.
//
//该类主要功能是对菜单从plist文件中下载下来，以及显示
#import "FindDishesViewController.h"
#import "FindWithMapViewController.h"
#import "FindDishesModel.h"
#import "PlistDataManager.h"
#define kWIDTH [UIScreen mainScreen].bounds.size.width/2

@interface FindDishesViewController ()
@property (nonatomic,strong) NSArray <FindDishesModel *> *dishesList;
@property (nonatomic,assign) NSInteger rowNum;
@property (nonatomic,assign) BOOL isFirstClickBtn;
@property (weak, nonatomic) IBOutlet UIButton *foodBtn;
@property (weak, nonatomic) IBOutlet UIButton *changeDishes;

@end

@implementation FindDishesViewController

- (IBAction)changeDishesClickBtn:(id)sender {
    if (self.rowNum>=0&&self.rowNum<self.dishesList.count-1) {
    for (int i=0; i<self.dishesList[self.rowNum].subcategories.count; i++) {
            [[self.view viewWithTag:i+10] removeFromSuperview];
        }
        self.rowNum ++;
        [self creatButton];
    }
    else {
        for (int i=0; i<self.dishesList[self.rowNum].subcategories.count; i++) {
            [[self.view viewWithTag:i+10] removeFromSuperview];
        }
        [self creatButton];
        self.rowNum = 0;
        for (int i=0; i<self.dishesList[self.rowNum].subcategories.count; i++) {
            [[self.view viewWithTag:i+10] removeFromSuperview];
        }
        [self creatButton];
    }
}
- (IBAction)foodBtnClick:(UIButton *)sender
{
    [self chooseDishes:sender];
}


#pragma mark - 懒加载
-(NSArray<FindDishesModel *> *)dishesList
{
    if (!_dishesList) {
        _dishesList=[NSArray array];
    }
    return _dishesList;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.foodBtn setRoundLayer];
    [self.changeDishes setRoundLayer];
    self.changeDishes.tintColor=[UIColor whiteColor];
    self.changeDishes.layer.borderColor=[UIColor clearColor].CGColor;
    [PlistDataManager getDishes:^(NSArray<FindDishesModel *> *dishes, NSError *error) {
        if (!error) {
            self.dishesList = dishes;
            [self creatButton];
        }
    }];
}



//创建菜单button
-(void)creatButton
{
    for (int i=0; i<self.dishesList[self.rowNum].subcategories.count; i++)
    {
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(i%2?0:kWIDTH+(kWIDTH-120),184+i/2*50, 120, 30)];
        
        [button setTitle:self.dishesList[self.rowNum].subcategories[i] forState:UIControlStateNormal];
        button.backgroundColor=[UIColor grayColor];
        [button setTag:i+10];
        button.titleLabel.font=[UIFont systemFontOfSize:15];
        [button addTarget:self action:@selector(chooseDishes:) forControlEvents:UIControlEventTouchUpInside];
        [button setRoundLayer];
        [self.view addSubview:button];
    }
}

-(void)chooseDishes:(UIButton *)sender
{
   
    [sender setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [[NSUserDefaults standardUserDefaults] setObject:sender.titleLabel.text forKey:kCurrentDishesName];
    [self performSegueWithIdentifier:@"FindMapSegue" sender:sender.titleLabel.text];
   
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id vc=segue.destinationViewController;
    if ([vc isKindOfClass:[FindWithMapViewController class]]) {
        FindWithMapViewController *fmVC=(FindWithMapViewController *)vc;
        fmVC.dishesName=sender;
    }
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
