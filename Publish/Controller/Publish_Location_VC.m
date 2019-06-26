//
//  Publish_Location_VC.m
//  QFC
//
//  Created by tiaoxin on 2019/4/12.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Publish_Location_VC.h"
#define CellID_PublishLocationCell  @"PublishLocationCell"
@interface Publish_Location_VC ()<UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, AMapSearchDelegate>

@property (strong, nonatomic) IBOutlet UISearchBar *SearchBar;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *Sure_BT;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) AMapSearchAPI *search;

@end

@implementation Publish_Location_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Publish_Location_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_PublishLocationCell];
    self.SearchBar.delegate = self;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    /*
    //构造AMapNearbySearchRequest对象，配置周边搜索参数
    AMapNearbySearchRequest *request = [[AMapNearbySearchRequest alloc] init];
    request.center = [AMapGeoPoint locationWithLatitude:121.385373 longitude:31.111152];//中心点,
    request.radius = 10000;//搜索半径
    request.timeRange = 10000;//查询的时间
    request.searchType = AMapNearbySearchTypeDriving;//驾车距离，AMapNearbySearchTypeLiner表示直线距离
    //发起附近周边搜索
    [self.search AMapNearbySearch:request];*/
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    
    request.location            = [AMapGeoPoint locationWithLatitude:[[Singleton sharedSingleton].latitude floatValue] longitude:[[Singleton sharedSingleton].longitude floatValue]];
//    request.keywords            = @"地名地址信息";
    /* 按照距离排序. */
    request.sortrule            = 0;
    request.requireExtension    = YES;
    [self.search AMapPOIAroundSearch:request];
}

- (IBAction)LiftButtonClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)SureButtonClick:(id)sender {
    for (Publish_Location_Model *model in self.dataArray) {
        NSLog(@"%@",model.Name);
        if (model.State) {
            if (self.PublishLocationVCBlock) {
                self.PublishLocationVCBlock(model.Name, model.latStr, model.longStr);
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
        Publish_Location_Model *model = [[Publish_Location_Model alloc] init];
        model.Name = [Singleton sharedSingleton].formattedAddress;
        model.latStr = [Singleton sharedSingleton].latitude;
        model.longStr = [Singleton sharedSingleton].longitude;
        model.SubName = @"";
        [_dataArray addObject:model];
    }
    return _dataArray;
}

#pragma mark - UITableViewDelegate
//返回多少个分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
//返回一个分区里多少数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
// 返回Cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Publish_Location_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_PublishLocationCell];
    Publish_Location_Model *model = self.dataArray[indexPath.row];
    [cell setDataSoureToCell:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    for (int i = 0; i < self.dataArray.count; i++) {
        Publish_Location_Model *model = self.dataArray[i];
        if ([model isEqual:self.dataArray[indexPath.row]]) {
            model.State = YES;
            self.dataArray[indexPath.row] = model;
        }else {
            model.State = NO;
            self.dataArray[i] = model;
        }
    }
    [self.tableView reloadData];
}

/*//附近周边搜索回调
- (void)onNearbySearchDone:(AMapNearbySearchRequest *)request response:(AMapNearbySearchResponse *)response
{
    if(response.infos.count == 0)
    {
        return;
    }
    
    for (AMapNearbyUserInfo *info in response.infos)
    {
        MKPointAnnotation *anno = [[MKPointAnnotation alloc] init];
        anno.title = info.userID;
        anno.subtitle = [[NSDate dateWithTimeIntervalSince1970:info.updatetime] descriptionWithLocale:[NSLocale currentLocale]];
        
        anno.coordinate = CLLocationCoordinate2DMake(info.location.latitude, info.location.longitude);
        
//        [_mapView addAnnotation:anno];
    }
}*/

/* POI 搜索回调. */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0)
    {
        return;
    }else {
        [self.dataArray removeAllObjects];
        Publish_Location_Model *model = [[Publish_Location_Model alloc] init];
        model.Name = [Singleton sharedSingleton].formattedAddress;
        model.latStr = [Singleton sharedSingleton].latitude;
        model.longStr = [Singleton sharedSingleton].longitude;
        model.SubName = @"";
        [self.dataArray addObject:model];
        for (AMapPOI *model in response.pois) {
            Publish_Location_Model *locModel = [[Publish_Location_Model alloc] init];
            locModel.Name = model.name;
            locModel.SubName = model.address;
            locModel.latStr = [NSString stringWithFormat:@"%lf", model.location.latitude];
            locModel.longStr = [NSString stringWithFormat:@"%lf", model.location.longitude];
            locModel.State = NO;
            [self.dataArray addObject:locModel];
        }
        [self.tableView reloadData];
    }
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if (searchBar.text.length) {
        AMapInputTipsSearchRequest *tips = [[AMapInputTipsSearchRequest alloc] init];
        tips.keywords = searchBar.text;
        tips.city     = [Singleton sharedSingleton].City;
        //   tips.cityLimit = YES; 是否限制城市
        [self.search AMapInputTipsSearch:tips];
    } else {
        AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
        
        request.location            = [AMapGeoPoint locationWithLatitude:121.385373 longitude:31.111152];
        //    request.keywords            = @"地名地址信息";
        /* 按照距离排序. */
        request.sortrule            = 0;
        request.requireExtension    = YES;
        [self.search AMapPOIAroundSearch:request];
    }
}
/* 输入提示回调. */
- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response
{
    //解析response获取提示词，具体解析见 Demo
    if (response.tips.count == 0)
    {
        return;
    }else {
        [self.dataArray removeAllObjects];
        Publish_Location_Model *model = [[Publish_Location_Model alloc] init];
        model.Name = [Singleton sharedSingleton].formattedAddress;
        model.latStr = [Singleton sharedSingleton].latitude;
        model.longStr = [Singleton sharedSingleton].longitude;
        model.SubName = @"";
        [self.dataArray addObject:model];
        for (AMapTip *model in response.tips) {
            Publish_Location_Model *locModel = [[Publish_Location_Model alloc] init];
            locModel.Name = model.name;
            locModel.SubName = model.address;
            locModel.latStr = [NSString stringWithFormat:@"%lf", model.location.latitude];
            locModel.longStr = [NSString stringWithFormat:@"%lf", model.location.longitude];
            locModel.State = NO;
            [self.dataArray addObject:locModel];
        }
        [self.tableView reloadData];
    }
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    if (searchBar.text.length) {
        AMapInputTipsSearchRequest *tips = [[AMapInputTipsSearchRequest alloc] init];
        tips.keywords = searchBar.text;
        tips.city     = [Singleton sharedSingleton].City;
        //   tips.cityLimit = YES; 是否限制城市
        [self.search AMapInputTipsSearch:tips];
    }else {
        AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
        
        request.location            = [AMapGeoPoint locationWithLatitude:121.385373 longitude:31.111152];
        //    request.keywords            = @"地名地址信息";
        /* 按照距离排序. */
        request.sortrule            = 0;
        request.requireExtension    = YES;
        [self.search AMapPOIAroundSearch:request];
    }
    return YES;
}

@end
