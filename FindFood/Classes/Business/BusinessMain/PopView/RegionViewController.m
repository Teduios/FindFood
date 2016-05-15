//
//  RegionViewController.m
//  FindFood
//
//  Created by tarena on 16/4/20.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "RegionViewController.h"
#import "PlistDataManager.h"
@interface RegionViewController ()<UITableViewDelegate,UITableViewDataSource>
/**  */
@property (nonatomic, strong) NSArray<CitiesModel *> *cityList;
/** <#属性#> */
@property (nonatomic, strong) UITableView *cityTableView;
/** u */
@property (nonatomic, strong) UITableView *subCityTableView;
/**  */
@property (nonatomic, strong) NSArray<CitiesRegionsModel *> *subCityList;
/**  */
@property (nonatomic, strong) NSString *city;
@end

@implementation RegionViewController
- (UITableView *)cityTableView
{
    if (!_cityTableView) {
        _cityTableView = [[UITableView
                           alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _cityTableView.delegate = self;
        _cityTableView.dataSource = self;
        [_cityTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cityCell"];
        [self.view addSubview:_cityTableView];
        
    }return _cityTableView;
}
- (UITableView *)subCityTableView
{
    if (!_subCityTableView) {
        _subCityTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _subCityTableView.delegate = self;
        _subCityTableView.dataSource = self;
        [_subCityTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cityCell"];
        [self.view addSubview:_subCityTableView];
        
    }return _subCityTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.cityTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.mas_equalTo(0);
        make.right.mas_equalTo(self.subCityTableView.mas_left);
        make.width.mas_equalTo(self.subCityTableView.mas_width);
    }];
    [self.subCityTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.mas_equalTo(0);
    }];
    [PlistDataManager getCities:^(NSArray<CitiesModel *> *cities, NSError *error) {
        self.cityList = cities;
        [self.cityTableView reloadData];
    }]; // Do any additional setup after loading the view.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.cityTableView]) {
        return self.cityList.count;
    }
    return self.subCityList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cityCell" forIndexPath:indexPath];
    if ([tableView isEqual:self.cityTableView]) {
        cell.textLabel.text = self.cityList[indexPath.row].name;
        return cell;
    }
    cell.textLabel.text = self.subCityList[indexPath.row].name;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.cityTableView]) {
        self.subCityList = self.cityList[indexPath.row].regions;
        _city = self.cityList[indexPath.row].name;
        [self.subCityTableView reloadData];
    }else
    {
        self.ChooseBlock(_city,self.subCityList[indexPath.row].name);
        [self dismissViewControllerAnimated:YES completion:nil];
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
