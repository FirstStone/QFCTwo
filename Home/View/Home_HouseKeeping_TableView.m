//
//  Home_HouseKeeping_TableView.m
//  QFC
//
//  Created by tiaoxin on 2019/4/28.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_HouseKeeping_TableView.h"
#define CellID_HomeHouseKeepingCell @"HomeHouseKeepingCell"

@interface Home_HouseKeeping_TableView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation Home_HouseKeeping_TableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.separatorStyle = UITableViewCellAccessoryNone;
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = QFC_BackColor_Gray;
        [self registerNib:[UINib nibWithNibName:NSStringFromClass([Home_HouseKeepingCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_HomeHouseKeepingCell];
        [self LoadingDataSoure];
    }
    return self;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
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

    Home_HouseKeepingCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeHouseKeepingCell];
    [cell setModelToCell:self.dataArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.index == 0) {//普通清洁
        Home_HouseKeeping_PlaceOrder_ViewController *placeOrderVC =[[Home_HouseKeeping_PlaceOrder_ViewController alloc] init];
        placeOrderVC.GouseKeep_Style = self.index;
        placeOrderVC.HouseKeeping_ID = [self.dataArray[indexPath.row] HouseKeeping_id];
        [placeOrderVC setHidesBottomBarWhenPushed:YES];
        [self.My_NAVC pushViewController:placeOrderVC animated:YES];
    }else {
        Home_HouseKeeping_PlaceOrder_Depth_ViewController *placeOrderVC =[[Home_HouseKeeping_PlaceOrder_Depth_ViewController alloc] init];
        placeOrderVC.GouseKeep_Style = self.index;
        placeOrderVC.HouseKeeping_ID = [self.dataArray[indexPath.row] HouseKeeping_id];
        [placeOrderVC setHidesBottomBarWhenPushed:YES];
        [self.My_NAVC pushViewController:placeOrderVC animated:YES];
    }
}

/*
 //家政列表  type 1普通保洁2深度保洁
 Route::rule('setlist/:uid/:type/:page','index/Husbandry/setList');
 */
#pragma mark----UPdata
- (void)LoadingDataSoure {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:self.index == 0 ? @"1" : @"2" forKey:@"type"];
    [parm setObject:@"1" forKey:@"page"];
    [[HttpRequest sharedInstance] postWithURLString:URL_setList parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSArray *Array = [responseObject objectForKey:@"list"];
            for (NSDictionary *dic in Array) {
                Home_HouseKeeping_Model *model = [Home_HouseKeeping_Model mj_objectWithKeyValues:dic];
                [self.dataArray addObject:model];
            }
            [self reloadData];
        }else {
            [MBProgressHUD py_showError:@"暂无数据" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"数据获取失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}




@end
