//
//  CategoryViewController.m
//  FindFood
//
//  Created by tarena on 16/4/20.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "CategoryViewController.h"
#import "PlistDataManager.h"
@interface CategoryViewController ()<UITableViewDelegate ,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic,strong) NSArray *categoriesArr;


@end

@implementation CategoryViewController
-(NSArray *)categoriesArr
{
    if (!_categoriesArr) {
        _categoriesArr=[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"categories.plist" ofType:nil]];
    }
    return _categoriesArr;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.ChooseBlock(self.categoriesArr[indexPath.row]);
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.categoriesArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text =self.categoriesArr[indexPath.row];
    return cell;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView reloadData];
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
