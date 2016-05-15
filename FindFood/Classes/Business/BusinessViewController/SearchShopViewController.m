//
//  SearchShopViewController.m
//  FindFood
//
//  Created by tarena on 16/4/16.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "SearchShopViewController.h"
#import "SearchBusinessViewModel.h"
#import "SearchBusinessCell.h"
#import "BusinessDetailViewController.h"
@interface SearchShopViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *searchfieldText;
@property (nonatomic,strong) SearchBusinessViewModel *businessVM;
//网络错误显示界面
@property (nonatomic,strong) UIImageView *errorImageView;
@end

@implementation SearchShopViewController

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.searchfieldText.becomeFirstResponder==YES) {
         [self.searchfieldText resignFirstResponder];
    }
   
}
- (IBAction)textFieldDidEndOnExit:(id)sender {
    [self.searchfieldText resignFirstResponder];
}


- (IBAction)backBtnClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)show:(id)sender
{
    [self.searchfieldText resignFirstResponder];
    [[NSUserDefaults standardUserDefaults] setObject:self.searchfieldText.text forKey:kCurrentSearchShopName];
    [self headRefresh];
}
#pragma mark -懒加载
-(SearchBusinessViewModel *)businessVM
{
    if(!_businessVM)
    {
        _businessVM=[SearchBusinessViewModel new];
    }
    return _businessVM;
}

#pragma mark - UITableViewDelegate方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.businessVM.rowNumber;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchBusinessCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SearchBusinessCell" forIndexPath:indexPath];
    cell.titleLb.text=[self.businessVM showShopNameForIndex:indexPath.row];
   
    [cell.iconIV setImageURL:[self.businessVM showIconURLForIndex:indexPath.row]];
    cell.buyNumLb.text = [self.businessVM showSaleNumForIndex:indexPath.row];
    [cell.avgRatingImageView setImageURL:[self.businessVM showAvgRatingForIndex:indexPath.row]];
    cell.price =[self.businessVM currentPriceForIndex:indexPath.row];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[NSUserDefaults standardUserDefaults] setObject:[self.businessVM showBusinessIDForIndex:indexPath.row] forKey:kCurrentShopID];
    [self performSegueWithIdentifier:@"SearchSegue" sender:[self.businessVM showShopNameForIndex:indexPath.row]];
}
#pragma mark - 跳转方法
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id vc=segue.destinationViewController;
    if ([vc isKindOfClass:[BusinessDetailViewController class]]) {
        BusinessDetailViewController *dvc=vc;
        dvc.shopName=sender;
    }
}
#pragma mark - 刷新方法
-(void)headRefresh
{
    __weak __typeof(&*self.tableView)weakTabelView = self.tableView;
    [self.tableView addHeaderRefresh:^{
        [self.businessVM getSearchBusinessWithRequestMode:RequestModeRefresh completionHandler:^(NSError *error) {
            if (!error)
            {
                if (self.businessVM.searchDataList.count==0) {
                    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(100,[UIScreen mainScreen].bounds.size.height/3.0,180, 30)];
                    label.text=@"数据正在加载中...";
                    label.tintColor =[UIColor blackColor];
                    [self.tableView insertSubview:label atIndex:0];
                }
                //weakTabelView.hidden = NO;
                [weakTabelView reloadData];
            }
            [weakTabelView endHeaderRefresh];
        }];
    }];
    [self.tableView beginHeaderRefresh];
}
#pragma mark - 生命周期
-(void)viewWillDisappear:(BOOL)animated
{
    
    [self.searchfieldText resignFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
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
