//
//  BusinessCityListTableViewController.m
//  FindFood
//
//  Created by tarena on 16/4/13.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "BusinessCityListTableViewController.h"
#import "BusinessCityGroupViewModel.h"

@interface BusinessCityListTableViewController ()
@property (nonatomic,strong) BusinessCityGroupViewModel *cityListMV;

@end

@implementation BusinessCityListTableViewController
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(BusinessCityGroupViewModel *)cityListMV
{
    if (!_cityListMV) {
        _cityListMV=[BusinessCityGroupViewModel new];
    }
    return _cityListMV;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.cityListMV getCityGroupCompletionHandler:^(NSError *error) {
        [self.tableView reloadData];
    }];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
       // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.cityListMV.sectionNumber;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.cityListMV rowNumberForSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CityCell"];
    cell.textLabel.text=[self.cityListMV titleForRowAtIndexPath:indexPath];
    
    NSString *currentCity=[[NSUserDefaults standardUserDefaults] objectForKey:kCurrentCityName];
    cell.accessoryType = [currentCity isEqualToString:cell.textLabel.text]?UITableViewCellAccessoryCheckmark:UITableViewCellAccessoryNone;
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.cityListMV titleForSection:section];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //返回时确认为选中那一行
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[NSUserDefaults standardUserDefaults] setObject:[self.cityListMV titleForRowAtIndexPath:indexPath] forKey:kCurrentCityName];
    //保存到plist文件,避免系统崩溃时没有及时保存城市数据
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:kCurrentCityChangedNotification object:nil];
    [tableView reloadData];
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
