//
//  FindWithMapViewController.m
//  FindFood
//
//  Created by tarena on 16/4/22.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "FindWithMapViewController.h"
#import "FindToBusinessViewModel.h"

#import "BMKPointAnnotation.h"
#import "BMKPointAnnotation+Create.h"
#import "BusinessDetailViewController.h"
#import "BMKMapView.h"
#define BMKSPAN 0.005
@interface FindWithMapViewController ()<BMKLocationServiceDelegate,BMKMapViewDelegate>
/** 百度地图view */
@property (nonatomic, strong) BMKMapView *mapView;
/** 百度地图的位置服务 */
@property (nonatomic, strong) BMKLocationService *mapLocationService;

@property (nonatomic,strong) FindToBusinessViewModel *findVM;

@property (weak, nonatomic) IBOutlet UILabel *dishesLabel;
@property (weak, nonatomic) IBOutlet UILabel *BusinessNumLabel;
@property (weak, nonatomic) IBOutlet UIView *DishesInfoView;
@property (nonatomic,strong) BMKUserLocation *userLocation;
@property (weak, nonatomic) IBOutlet UIButton *backUserLocationBtn;


@end


@implementation FindWithMapViewController
- (IBAction)backUserLocationbtnClick:(id)sender
{
    //CLLocationCoordinate2D userCoordinate=;
    [self.mapView setCenterCoordinate:self.userLocation.location.coordinate animated:YES];
}
- (IBAction)backFindMain:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(FindToBusinessViewModel *)findVM
{
    if (!_findVM) {
        _findVM=[FindToBusinessViewModel new];
    }
    return _findVM;
}


-(void)viewWillAppear:(BOOL)animated
{
    [self.mapView viewWillAppear];
    self.mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil; // 不用时，置nil
}

-(void)loadData
{
    [self.findVM getBusinessPointCompletionHandler:^(NSError *error) {
        self.BusinessNumLabel.text=self.findVM.dataList.count?[NSString stringWithFormat:@"附近有%ld家",(unsigned long)self.findVM.dataList.count]:@"附近没有找到该类店";
        for (int i=0;i<self.findVM.dataList.count;i++)
        {
            CLLocation *location=[[CLLocation alloc]initWithLatitude:self.findVM.dataList[i].latitude longitude:self.findVM.dataList[i].longitude];
            [self createBusinessPointWithLocation:location title:self.findVM.dataList[i].name businessID:[NSString stringWithFormat:@"%ld",(unsigned long)self.findVM.dataList[i].businessId]];
        }
    }];
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showGetError:) name:kGETERRORNotification object:nil];
    [self setup];
}
-(void)showGetError:(NSNotification *)noti
{
    [self.view showWarning:@"网络错误,请确认网络是否正常"];
}
-(void)setup
{
    
    self.mapView=[[BMKMapView alloc]init];
    self.mapView.frame = self.view.bounds;
    [self.view insertSubview:self.mapView atIndex:0];
    [self setBMKLocationService];
    [self setMapViewProperty];
    self.mapLocationService.delegate = self;
    [self.mapLocationService startUserLocationService];
    [self.mapView setShowsUserLocation:YES];
    //范围
    
}
- (void) setBMKLocationService
{
    self.mapLocationService = [BMKLocationService new];
    /** 设置位置过滤 */
    [BMKLocationService setLocationDistanceFilter:5];
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyBest];
}

/** 百度地图view 的设置 */
- (void) setMapViewProperty
{
    // 显示定位图层
    self.mapView.showsUserLocation = NO;
    // 定位模式
    self.mapView.userTrackingMode = BMKUserTrackingModeNone;
    self.mapView.rotateEnabled = NO;
    // 是否显示比例尺
    self.mapView.showMapScaleBar = YES;
    // 比例尺的位置
    self.mapView.mapScaleBarPosition = CGPointMake(self.view.frame.size.width - 80 , self.view.frame.size.height - 100);
    // 自定义样式参数
    BMKLocationViewDisplayParam *displayParam = [BMKLocationViewDisplayParam new];
    // 是否显示精度圈
    displayParam.isAccuracyCircleShow = NO;
    displayParam.locationViewOffsetX = 0;
    [self.mapView updateLocationViewWithParam:displayParam];
}

//更新到用户位置
-(void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    [self.mapView updateLocationData:userLocation];
    // 获取一个合适的区域
    BMKCoordinateRegion fitsRegion = [self.mapView regionThatFits:BMKCoordinateRegionMake(userLocation.location.coordinate, BMKCoordinateSpanMake(BMKSPAN, BMKSPAN))];
    [self.mapView setRegion:fitsRegion animated:YES];
    [self loadData];
    self.userLocation =userLocation;
    _backUserLocationBtn.hidden = NO;
    //如果获取了用户位置，就停止用户位置定位
    if (userLocation) {
        [self.mapLocationService stopUserLocationService];
    }
}
//
//创建商家的大头针模型
- (void) createBusinessPointWithLocation:(CLLocation*)location  title:(NSString*) title businessID:(NSString *)businessID
{
    BMKPointAnnotation *point = [BMKPointAnnotation new];
    point.coordinate = location.coordinate;
    point.title = title;
    point.businessID=businessID;
    // 把大头针 添加到mapView 上
    [self.mapView addAnnotation:point];
}
//创建百度大头针视图
- (BMKAnnotationView*) mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]])
    {
        BMKPinAnnotationView *anotationView = [[BMKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"BusinessAnnotation"];
    anotationView.image = [UIImage imageNamed:@"ic_category_1"];
    anotationView.animatesDrop = YES;
    anotationView.draggable = NO;
    return anotationView;
    }
    else
    {
        BMKAnnotationView *anotationView = [[BMKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"MyAnnotation"];
        anotationView.image = [UIImage imageNamed:@"定位-起"];
        anotationView.draggable = NO;
        return anotationView;
    }
}

- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view
{
    if (![view isKindOfClass:[BMKPinAnnotationView class]])
    {
        return ;
    }
     NSString *message = [NSString stringWithFormat:@"查看商家详情"];
    [UIAlertView bk_showAlertViewWithTitle:@"选择" message:message cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [[NSUserDefaults standardUserDefaults] setObject:((BMKPointAnnotation *)view.annotation).businessID forKey:kCurrentShopID];
                        });
        [self performSegueWithIdentifier:@"MapSegue" sender:((BMKPointAnnotation *)view.annotation).title];
                        [_mapView viewWillDisappear];
                        self.mapView.delegate=nil;
                        self.mapLocationService=nil;
         }
    }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id vc=segue.destinationViewController;
    if ([vc isKindOfClass:[BusinessDetailViewController class]]) {
        BusinessDetailViewController *bdvc=(BusinessDetailViewController *)vc;
        bdvc.shopName=sender;
    }
}

-(void)mapViewDidFinishLoading:(BMKMapView *)mapView
{
    self.dishesLabel.text=self.dishesName;
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
