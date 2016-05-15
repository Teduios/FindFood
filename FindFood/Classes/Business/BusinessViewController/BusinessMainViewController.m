//
//  BusinessMainViewController.m
//  FindFood
//
//  Created by tarena on 16/4/10.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "BusinessMainViewController.h"
#import "BusinessViewModel.h"
#import "BusinessModel.h"
#import "BusinessDetailViewController.h"
#import "AlertViewController.h"
#import "SortViewController.h"
#import "RegionViewController.h"
#import "CategoryViewController.h"
#import "BusinessMainCell.h"
@interface BusinessMainViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)  BusinessViewModel*businessVM;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cityBarItem;
@property (weak, nonatomic) IBOutlet UIButton *sortBtn;
@property (weak, nonatomic) IBOutlet UIButton *regionBtn;
@property (weak, nonatomic) IBOutlet UIButton *categoryBtn;

@end

@implementation BusinessMainViewController


#pragma mark - 懒加载
-(BusinessViewModel *)businessVM
{
    if (!_businessVM)
    {
        _businessVM=[[BusinessViewModel alloc]init];
    }
    return _businessVM;
    
}
//排序搜索
- (IBAction)sortBtnClick:(UIButton *)sender
{
    if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
   SortViewController *vc=[[SortViewController alloc]initWithSourceView:sender sourceRect:sender.bounds contentSize:CGSizeMake(120, 200)];
    
    vc.chooseBlock = ^(NSString *sortValue,NSInteger sortNum){
        [[NSUserDefaults standardUserDefaults] setObject:@(sortNum) forKey:kCurrentSortName];
        [self headRefresh];
        [sender setTitle:sortValue forState:UIControlStateNormal];
    };
    [self presentViewController:vc animated:YES completion:nil];
    }
}
//区域选择
- (IBAction)regionBtnClick:(UIButton *)sender {
    if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
    RegionViewController *vc = [[RegionViewController alloc]initWithSourceView:sender sourceRect:sender.bounds contentSize:CGSizeMake(200, 300)];
    vc.ChooseBlock = ^(NSString *city,NSString *subCity)
    {
        [_regionBtn setTitle:subCity forState:UIControlStateNormal];
        self.cityBarItem.title =city;
        [[NSUserDefaults standardUserDefaults] setObject:city forKey:kCurrentCityName];
        [[NSUserDefaults standardUserDefaults] setObject:subCity forKey:kCurrentSubCityName];
        [self headRefresh];
    };
    [self presentViewController:vc animated:YES completion:nil];
    }
}
//美食
- (IBAction)categoryBtnClick:(UIButton *)sender {
   if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
    CategoryViewController *vc = [[CategoryViewController alloc]initWithSourceView:sender sourceRect:sender.bounds contentSize:CGSizeMake(120, 230)];
    vc.ChooseBlock =^(NSString *category)
    {
        [[NSUserDefaults standardUserDefaults] setObject:category forKey:kCurrentCategoryName];
        [_categoryBtn setTitle:category forState:UIControlStateNormal];
        [self headRefresh];
    };
    [self presentViewController:vc animated:YES completion:nil];
     }
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

         return self.businessVM.rowNumber;
   
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BusinessMainCell *cell=[tableView dequeueReusableCellWithIdentifier:@"BusinessCell"];
//    cell.textLabel.text =[self.businessVM currentPriceForIndex:indexPath.row];
    [cell.iconIV setImageURL:[self.businessVM iconURLForIndex:indexPath.row]];
    [cell.iconIV setLittleRoundLayer];
    cell.titleLabel.text = [self.businessVM shopNameForIndex:indexPath.row];
    cell.saleNumLabel.text=[self.businessVM saleNumForIndex:indexPath.row];
    [cell showStarForShopAvgRating:[self.businessVM shopAvgRatingForIndex:indexPath.row]];
    cell.price =[self.businessVM currentPriceForIndex:indexPath.row];

    
        return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        [[NSUserDefaults standardUserDefaults] setObject:[self.businessVM businessIDForIndex:indexPath.row] forKey:kCurrentShopID];
        [self performSegueWithIdentifier:@"DetailSegue" sender:[self.businessVM shopNameForIndex:indexPath.row]];
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id vc=segue.destinationViewController;
    if ([vc isKindOfClass:[BusinessDetailViewController class]])
    {
        BusinessDetailViewController *dvc=vc;
        dvc.shopName=sender;
    }
}

#pragma mark - 生命周期
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    //开始运行刷新一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self headRefresh];
    });
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.cityBarItem setTintColor:[UIColor whiteColor]];
    [self setup];
    [self footRefresh];
}
-(void)setup
{
    self.cityBarItem.title=kCurrentCity;
     [_regionBtn setTitle:kCurrentSubCity forState:UIControlStateNormal];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showGetError:) name:kGETERRORNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityChange:) name:kCurrentCityChangedNotification object:nil];
    
}
#pragma mark - 刷新方法
-(void)headRefresh
{
    //
    __weak __typeof(&*self.tableView)weakTabelView = self.tableView;
    [weakTabelView addHeaderRefresh:^{
        [self.businessVM getBussinessWithRequestMode: RequestModeRefresh completionHandler:^(NSError *error) {
            if (!error) {
                //weakTabelView.hidden = NO;
                if (self.businessVM.dataList.count==0) {
                    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(100,[UIScreen mainScreen].bounds.size.height/3.0,180, 30)];
                    label.text=@"数据正在加载中...";
                    label.tintColor =[UIColor blackColor];
                    [self.tableView insertSubview:label atIndex:0];
                }
                [weakTabelView reloadData];
            }
            [weakTabelView endHeaderRefresh];
            
        }];
      
    }];
    [weakTabelView beginHeaderRefresh];
}
-(void)footRefresh
{
    __weak __typeof(&*self.tableView)weakTabelView = self.tableView;
    [weakTabelView addBackFooterRefresh:^{
        [self.businessVM getBussinessWithRequestMode:RequestModeMore completionHandler:^(NSError *error) {
            if (!error) {
                
                [weakTabelView reloadData];
            }
            [weakTabelView endFooterRefresh];
        }];
    }];
    [weakTabelView beginFooterRefresh];
}
#pragma mark - @select()方法
-(void)cityChange:(NSNotification *)noti
{
    self.cityBarItem.title=kCurrentCity;
    [_regionBtn setTitle:@"全部" forState:UIControlStateNormal];
    [[NSUserDefaults standardUserDefaults] setObject:@"全部" forKey:kCurrentSubCityName];
    [self headRefresh];
    [self footRefresh];
}
-(void)showGetError:(NSNotification *)noti
{
   
    [self.view showWarning:@"网络异常，请检查网络配置"];
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kCurrentCityChangedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kGETERRORNotification object:nil];
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
