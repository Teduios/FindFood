//
//  BusinessDetailViewController.m
//  FindFood
//
//  Created by tarena on 16/4/17.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "BusinessDetailViewController.h"
#import "BusinessDetailViewModel.h"
#import "BusinessDetailCell.h"
#import "BusinessOtherDetailCell.h"
#import "BusinessReviewViewCell.h"
#import "BusinessReviewViewModel.h"
#import "BusinessMoreReviewCell.h"
#import "MyCollectionViewController.h"

@interface BusinessDetailViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong) BusinessDetailViewModel *bdVM;
@property (nonatomic,strong) BusinessReviewViewModel *brVM;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *contextArr;
@property (nonatomic,assign) NSInteger rowHight;
@property (nonatomic,assign,getter=isbuttonViewShow) BOOL buttonViewShow;

@property (nonatomic,strong) NSMutableDictionary *collectionDict;
@property (weak, nonatomic) IBOutlet UIButton *collectionButton;

@property (nonatomic,copy) NSString *fileName;
@property (nonatomic,assign) BOOL collectFlag;
@property (nonatomic,assign) BOOL isCollection;
@end

@implementation BusinessDetailViewController
- (IBAction)back:(id)sender {

    [self.navigationController popViewControllerAnimated:YES];
}

-(NSMutableDictionary *)collectionDict
{
    if (!_collectionDict)
    {
            NSFileManager *fileManager=[NSFileManager defaultManager];
            if (![fileManager fileExistsAtPath:self.fileName])
            {
                NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:@"id",@"name",nil]; //写入假数据，不然不能创建plist文件
                [dic writeToFile:self.fileName atomically:YES];
            }
            _collectionDict=[[NSMutableDictionary alloc] initWithContentsOfFile:self.fileName];
        [_collectionDict removeObjectForKey:@"name"];
        [_collectionDict writeToFile:self.fileName atomically:YES];
    }
    return _collectionDict;
}

- (IBAction)collectionClick:(UIButton *)sender
{
    if (self.collectFlag) {
        [sender setImage:[UIImage imageNamed:@"icon_unlove_collect"] forState:UIControlStateNormal];
        [self removeCollection];
        self.collectFlag = NO;
        self.isCollection = NO;
        [[NSUserDefaults standardUserDefaults] setBool:self.isCollection forKey:kISCOLLECTION];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self showHUD];
    }
    else
    {
        sender.selected =!sender.isSelected;
        if (sender.selected)
        {
            [sender setImage:[UIImage imageNamed:@"icon_love_collect"] forState:UIControlStateNormal];
            [self saveCollection];
            self.isCollection =YES;
            [[NSUserDefaults standardUserDefaults] setBool:self.isCollection forKey:kISCOLLECTION];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self showHUD];
        }
        else
        {
            [sender setImage:[UIImage imageNamed:@"icon_unlove_collect"] forState:UIControlStateNormal];
            [self removeCollection];
            self.isCollection = NO;
            [[NSUserDefaults standardUserDefaults] setBool:self.isCollection forKey:kISCOLLECTION];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self showHUD];
         }
    }
    
}
-(void)removeCollection
{       dispatch_async(dispatch_get_global_queue(0, 0), ^{
    [self.collectionDict removeObjectForKey:self.collectionDict[self.shopName]];
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        [self.collectionDict removeObjectForKey:self.shopName];
        [self.collectionDict writeToFile:self.fileName atomically:YES];
    });
});
    
    
}
-(void)saveCollection
{        dispatch_async(dispatch_get_global_queue(0, 0), ^{
    NSString *value=[NSString stringWithFormat:@"%@,%@",self.shopName,[self reciveTime]];
    [self.collectionDict setObject:kCurrentShop forKey:self.shopName];
    [self.collectionDict setObject:value forKey:kCurrentShop];
    [self.collectionDict writeToFile:self.fileName atomically:YES];
});
}
-(NSString *)reciveTime
{
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *locationString=[dateformatter stringFromDate:senddate];
    return locationString;
}
-(void)showCollectionButton
{
    self.fileName=FILEPATH;
    if ( self.collectionDict[self.shopName])
    {
        [self.collectionButton setImage:[UIImage imageNamed:@"icon_love_collect"] forState:UIControlStateNormal];
        self.collectFlag = YES;
        self.isCollection =YES;
    }
    else
    {
         [self.collectionButton setImage:[UIImage imageNamed:@"icon_unlove_collect"] forState:UIControlStateNormal];
        self.isCollection =NO;
    }
}

-(BusinessReviewViewModel *)brVM
{
    if (!_brVM) {
        _brVM = [BusinessReviewViewModel new];
    }
    return _brVM;
}

-(BusinessDetailViewModel *)bdVM
{
    if (!_bdVM) {
        _bdVM=[BusinessDetailViewModel new];
    }
    return _bdVM;
}

#pragma mark -- 生命周期
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self refreshData];
    [self showCollectionButton];
}
//监听数据获取
-(void)showGetError:(NSNotification *)noti
{
    [self.view showWarning:@"网络异常,请检查网络配置"];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=self.shopName;
    self.tableView.tableFooterView=[[UIView alloc]init];
}
//刷新
-(void)footRefresh
{
    __weak __typeof(&*self.tableView)weakTabelView = self.tableView;
        [self.brVM getBussinessWithRequestReviews:RequestReviewsMore completionHandler:^(NSError *error) {
        if (!error)
        {
            [weakTabelView reloadData];
        }
        }];
}
#pragma mark - 基本方法

-(void)refreshData
{
    __weak __typeof(&*self.tableView)weakTabelView = self.tableView;
    [self.bdVM getBussinessWithCompletionHandler:^(NSError *error) {
        if (!error) {
            self.tableView.hidden = NO;
            [weakTabelView reloadData];
        }
        
    }];
    [self.brVM getBussinessWithRequestReviews:RequestReviewsLittle completionHandler:^(NSError *error) {
        if (!error) {
            self.tableView.hidden = NO;
            [weakTabelView reloadData];
        }
       
   }];
}


-(void)createForLabelWithArray:(NSArray *)contextArr
{
    if (contextArr.count==1)
    {
        return ;
    }
    if ([UIScreen mainScreen].bounds.size.width<=321.00)
    {
        for (int i=0; i<contextArr.count; i++)
        {
            UILabel *lable =[[UILabel alloc]initWithFrame:CGRectMake(i<2?(186+i%2*(62+2)):(110+(i-2)%3*(62+5)),i<2?(39+i/2*(21+8)):(68+(i-2)/3*(21+8)), 62, 21)];
            if(((NSString *)contextArr[i]).length>4)
            {
                lable.text=[contextArr[i] substringToIndex:4];
            }
            else
            {
            lable.text=contextArr[i];
            }
            lable.font=[UIFont systemFontOfSize:15];
            //lable.textColor=[UIColor grayColor];
            lable.layer.borderColor =[UIColor greenColor].CGColor;
            lable.textAlignment =NSTextAlignmentCenter;
            [lable setRoundLayer];
            [self.tableView addSubview:lable];
        }
        
    }
    else
    {
        for (int i=0; i<contextArr.count; i++)
        {
            UILabel *lable =[[UILabel alloc]initWithFrame:CGRectMake(i<3?(186+i%3*(62+2)):(110+(i-3)%4*(62+6)),i<3?(39+i/3*(21+8)):(68+(i-3)/4*(21+8)), 62, 21)];
            if(((NSString *)contextArr[i]).length>4)
            {
                lable.text=[contextArr[i] substringToIndex:4];
            }
            else
            {
                lable.text=contextArr[i];
            }
            lable.font=[UIFont systemFontOfSize:15];
           // lable.textColor=[UIColor grayColor];
            lable.layer.borderColor =[UIColor greenColor].CGColor;
           lable.textAlignment =NSTextAlignmentCenter;
            [lable setRoundLayer];
            [self.tableView addSubview:lable];
        }
    }

}
#pragma mark - -加载
-(void)showHUD
{
    [self.view showBusyHUD:@"正在保存收藏记录"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
        [self.view hideBusyHUD];
    });
}
#pragma  mark - UITableViewDelegate 方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    if (section ==0)
    {
         return 1;
    }

   else if (section == 1)
   {
       return 1;
   }
    else if (section ==2)
    {
        return self.brVM.rowNumber;
    }
    else
        return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
    BusinessDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:@"BusinessDetailCell" forIndexPath:indexPath];
        [cell.shopImgView setLittleRoundLayer];
    [cell.shopImgView setImageURL:[self.bdVM showWithShopImgURL]];
    cell.categoriesLabel.text =[self.bdVM showWithCategories];
    NSString *str=[self.bdVM showWithPopularDishes];
    if(str)
    {
            self.contextArr=[str componentsSeparatedByString:@","];
        
           [self createForLabelWithArray:self.contextArr];
      
    }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
    }
    else if (indexPath.section == 1)
    {
        BusinessOtherDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BusinessOtherDetailCell" forIndexPath:indexPath];
        cell.addressLabel.text = [self.bdVM showWithAddress];
        if (cell.addressLabel.text) {
            self.buttonViewShow = YES;
        }
        cell.telephoneLabel.text = [self.bdVM showWithTelephone];
        cell.specialtiesLabel.text = [self.bdVM showWithSpecialties];
        cell.hoursLabel.text = [self.bdVM showWithHours];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if(indexPath.section ==2)
    {
        BusinessReviewViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BusinessReviewTableViewCell" forIndexPath:indexPath];
        cell.userNickNameLabel.text=[self.brVM showUserNickNameForIndex:indexPath.row];
        [cell.reviewRatingImageView setImageURL:[self.brVM showReviewRatingURLForIndex:indexPath.row]];
        cell.productScoreLabel.text =[self.brVM showProductScoreForIndex:indexPath.row];
        cell.serviceScoreLabel.text = [self.brVM showServiceScoreForIndex:indexPath.row];
        cell.decorationScoreLabel.text = [self.brVM showDecorationScoreForIndex:indexPath.row];
        cell.textExcerptLabel.text=[self.brVM showTextExcerptForIndex:indexPath.row];
          cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        return  cell;
    }
    else
    {
     
        BusinessMoreReviewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"BusinessMoreReviewCell"];
            [cell.clickButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
       
        cell.ButtonView.hidden = YES;
        if (self.buttonViewShow)
        {
          cell.ButtonView.hidden =NO;
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
}
-(void)click:(UIButton *)sender
{
    [sender setTitle:@"没有更多评论!" forState:UIControlStateNormal];
    [self footRefresh];
    sender.enabled = NO;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1)
    {
      return @"商家基本信息";
    }
    else if (section == 2)
    {
        return @"最新评论";
    }
    return nil;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section==0)
    {
        NSString *str=[self.bdVM showWithPopularDishes];
        if(str)
        {
            self.contextArr=[str componentsSeparatedByString:@","];
            if ([UIScreen mainScreen].bounds.size.width<=321.00)
            {
                if(self.contextArr.count>5.0)
                {
                    return 109.0+((self.contextArr.count-5)%3?((self.contextArr.count-5)/3+1):((self.contextArr.count-5)/3))*29+10;
                }
                return 109.0;
            }
            else
            {
            if (self.contextArr.count>7)
                {
                    
                    return 109.0+((self.contextArr.count-7)%4?((self.contextArr.count-7)/4+1):((self.contextArr.count-7)/4))*29+20;
                }
             
                return 109.0;
            }
        }
        else
            return 109.0;
    }
    else if(indexPath.section ==1)
    {
        NSString *addressStr = [_bdVM showWithAddress];
        CGSize size1=[addressStr sizeForFont:[UIFont systemFontOfSize:17.0] size:CGSizeMake([UIScreen mainScreen].bounds.size.width - 115, MAXFLOAT) mode:NSLineBreakByWordWrapping];
        NSString *specialtiesStr = [_bdVM showWithSpecialties];
        CGSize size2=[specialtiesStr sizeForFont:[UIFont systemFontOfSize:17.0] size:CGSizeMake([UIScreen mainScreen].bounds.size.width - 115, MAXFLOAT) mode:NSLineBreakByWordWrapping];
        NSString *hoursStr = [_bdVM showWithHours];
        CGSize size3=[hoursStr sizeForFont:[UIFont systemFontOfSize:17.0] size:CGSizeMake([UIScreen mainScreen].bounds.size.width - 115, MAXFLOAT) mode:NSLineBreakByWordWrapping];
        return size1.height+size2.height+size3.height+121;
    }
    else if (indexPath.section == 2)
    {
        NSString *reviewStr=[_brVM showTextExcerptForIndex:indexPath.row];
       CGSize size=[reviewStr sizeForFont:[UIFont systemFontOfSize:17.0] size:CGSizeMake([UIScreen mainScreen].bounds.size.width - 33, MAXFLOAT) mode:NSLineBreakByWordWrapping];
        return size.height+75+20;
    }
    else
        return 30;
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
