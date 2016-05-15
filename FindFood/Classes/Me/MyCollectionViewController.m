//
//  MyCollectionViewController.m
//  FindFood
//
//  Created by tarena on 16/4/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "MyCollectionCell.h"
#import "MyCellModel.h"
#import "BusinessDetailViewController.h"

@interface MyCollectionViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSDictionary *dict;
@property (nonatomic,strong) NSMutableArray *collectArr;
@property (nonatomic,assign) NSInteger row;
@property (nonatomic,assign) BOOL isNotFirst;
@property (weak, nonatomic) IBOutlet UITableView *collectiontableView;

@end
@implementation MyCollectionViewController
- (IBAction)backMeMain:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSDictionary *)dict
{
    if (!_dict) {
        _dict=[NSDictionary dictionaryWithContentsOfFile:FILEPATH];
    }
    return _dict;
}
-(NSMutableArray *)collectArr
{
    if (!_collectArr) {
        _collectArr=[MyCellModel getModelWithDict:self.dict].mutableCopy;
    }
    return _collectArr;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.collectiontableView reloadData];
    
    if (self.isNotFirst==NO)
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kISCOLLECTION];
        
        return ;
    }
    if(kISCOLLECT==NO&&self.isNotFirst==YES)
   {
    [self.collectArr removeObjectAtIndex:self.row];
    [self.collectiontableView reloadData];
       [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kISCOLLECTION];
   }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

#pragma mark - -加载
-(void)showHUD
{
    [self.view showBusyHUD:@"正在保存对收藏的操作"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
        [self.view hideBusyHUD];
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.collectArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionCell *cell=[tableView dequeueReusableCellWithIdentifier:@"MyCollectionCell" forIndexPath:indexPath];
    MyCellModel *model=[MyCellModel getModelWithDict:self.dict][indexPath.row];
    cell.businessName.text=model.businessName;
    cell.saveTime.text=model.time;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCellModel *model=[MyCellModel getModelWithDict:self.dict][indexPath.row];
    self.row=indexPath.row;
    
    [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentShopID];
    [self performSegueWithIdentifier:@"CollectionSegue" sender:model.businessName];
    self.isNotFirst =YES;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id vc=segue.destinationViewController;
    if ([vc isKindOfClass:[BusinessDetailViewController class]])
    {
        BusinessDetailViewController *bdVC=(BusinessDetailViewController *)vc;
        bdVC.shopName =sender;
    }
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *collectDict=[NSMutableDictionary dictionaryWithContentsOfFile:FILEPATH];
    MyCellModel *model=self.collectArr[indexPath.row];
    [self.collectArr removeObjectAtIndex:indexPath.row];
       [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self removeCollection:collectDict and:model];
    [self showHUD];
}
-(void)removeCollection:(NSMutableDictionary *)dict and:(MyCellModel *)model
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [dict removeObjectForKey:dict[model.businessName]];
        [dict removeObjectForKey:model.businessName];
        [dict writeToFile:FILEPATH atomically:YES];
    });
    
    
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
