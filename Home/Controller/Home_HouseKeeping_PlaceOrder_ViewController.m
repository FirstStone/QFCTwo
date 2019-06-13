//
//  Home_HouseKeeping_PlaceOrder_ViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/5/10.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_HouseKeeping_PlaceOrder_ViewController.h"
#define CellIDHomeHouseKeepingCell @"Home_HouseKeepingCell"
#define CellID_HomeHouseeKeepingPlaceOrderOrdinaryCell @"HomeHouseeKeepingPlaceOrderOrdinaryCell"
#define CellID_HomeHouseKeepingPlaceOrderAddressTimeCell @"HomeHouseKeepingPlaceOrderAddressTimeCellid"
#define CellID_HomeHouseKeepingPlacOrderStandardCell @"HomeHouseKeepingPlacOrderStandardCell"
#define CellID_HomeHouseKeepingPlacOrderRemarksCell @"HomeHouseKeepingPlacOrderRemarksCell"
#define CellID_HomeHouseKeepingPlacOrderPriceCell  @"HomeHouseKeepingPlacOrderPriceCell"
@interface Home_HouseKeeping_PlaceOrder_ViewController ()<UITableViewDelegate, UITableViewDataSource, HomeHouseeKeepingPlaceOrderOrdinaryCellDelegate, HomeHouseKeepingPlaceOrderAddressTimeCellDelegate, HomeRunErrandsViewDelegate, PickerViewResultDelegate, HomeHouseKeepingPlacOrderRemarksCellDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIButton *Sure_BT;


@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) Home_HouseKeeping_Model *Top_Modle;

@property (nonatomic, strong) NSMutableDictionary *parm;

@property (nonatomic, strong) Mine_SetUP_MyAddress_Model *Address_Model;

@property (nonatomic, strong) NSString *Price;

@end

@implementation Home_HouseKeeping_PlaceOrder_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.Price = @"0";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Home_HouseKeepingCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellIDHomeHouseKeepingCell];
    
    [self.tableView registerClass:[Home_HouseeKeeping_PlaceOrderOrdinaryCell class] forCellReuseIdentifier:CellID_HomeHouseeKeepingPlaceOrderOrdinaryCell];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Home_HouseKeeping_PlaceOrder_AddressTimeCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_HomeHouseKeepingPlaceOrderAddressTimeCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Home_HouseKeeping_PlacOrder_StandardCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_HomeHouseKeepingPlacOrderStandardCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Home_HouseKeeping_PlacOrder_RemarksCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_HomeHouseKeepingPlacOrderRemarksCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Home_HouseKeeping_PlacOrder_PriceCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_HomeHouseKeepingPlacOrderPriceCell];
    [self LoadingDataSoure];
}

- (IBAction)LiftPOPButtonClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)SureButtonClick:(id)sender {
    /*
     //家政生成订单 普通保洁 pid家政ID endid 服务地点ID times服务时间 weight服务类型ID  remark备注
     Route::rule('generalhorderadd/:uid/:pid/:endid/:times/:weight/:remark','index/Husbandry/generalhOrderAdd');
     */
    if (![[self.parm objectForKey:@"endid"] intValue]) {
        [MBProgressHUD py_showError:@"请选择服务地址" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }else if (![[self.parm objectForKey:@"times"] intValue]) {
        [MBProgressHUD py_showError:@"请选择服务时间" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }else if (![[self.parm objectForKey:@"weight"] intValue]) {
        [MBProgressHUD py_showError:@"请选择服务类型" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }else {
        self.Sure_BT.userInteractionEnabled = NO;
        [self setDataSouerToBacker];
    }
}


- (NSMutableDictionary *)parm {
    if (!_parm) {
        _parm = [[NSMutableDictionary alloc] init];
    }
    return _parm;
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
    return 6;//self.dataArray.count;
}
// 返回Cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {//家政人员信息
        Home_HouseKeepingCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIDHomeHouseKeepingCell];
        cell.Right_imageview.hidden = YES;
        [cell setPlaceOrderModelToCell:self.Top_Modle];

        return cell;
    }else if (indexPath.row == 1){//服务面积
        Home_HouseeKeeping_PlaceOrderOrdinaryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeHouseeKeepingPlaceOrderOrdinaryCell];
        if (!cell) {
            cell = [[Home_HouseeKeeping_PlaceOrderOrdinaryCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellID_HomeHouseeKeepingPlaceOrderOrdinaryCell];
        }
        cell.delegate = self;
        cell.dataArray = self.dataArray;
        [cell setUPUI];
        return cell;
    }else if (indexPath.row == 2){//服务地点和时间
        Home_HouseKeeping_PlaceOrder_AddressTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeHouseKeepingPlaceOrderAddressTimeCell];
        cell.delegate = self;
        if ([[self.parm objectForKey:@"endid"] intValue]) {
            [cell setAddressTocell:[NSString stringWithFormat:@"%@%@", self.Address_Model.address, self.Address_Model.details]];
        }
        if ([self.parm objectForKey:@"times"]) {
            [cell setTimesTocell:[self.parm objectForKey:@"times"]];
        }
//        cell.Right_imageview.hidden = YES;
//        [cell setPlaceOrderModelToCell:self.Top_Modle];
        return cell;
    }else if (indexPath.row == 3){//服务标准
        Home_HouseKeeping_PlacOrder_StandardCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeHouseKeepingPlacOrderStandardCell];
        return cell;
    }else if (indexPath.row == 4){//备注
        Home_HouseKeeping_PlacOrder_RemarksCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeHouseKeepingPlacOrderRemarksCell];
        cell.delegate = self;
        if ([self.parm objectForKey:@"remark"]) {
            [cell setTextToTextField:[self.parm objectForKey:@"remark"]];
        }
        return cell;
    }else {//服务费用
        Home_HouseKeeping_PlacOrder_PriceCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeHouseKeepingPlacOrderPriceCell];
        [cell setPriceToCell:self.Price];
        return cell;
    }
}

#pragma mark----UPdata
- (void)LoadingDataSoure {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:self.HouseKeeping_ID forKey:@"id"];
 
    [[HttpRequest sharedInstance] postWithURLString:URL_generalDetails parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        if ([[responseObject objectForKey:@"status"] intValue]) {
            self.Top_Modle = [Home_HouseKeeping_Model mj_objectWithKeyValues:[responseObject objectForKey:@"info"]];
            
            
            NSArray *Array = [responseObject objectForKey:@"list"];
            for (NSDictionary *dic in Array) {
                Home_HouseKeep_PlaceOrderOrdinary_Model *model = [Home_HouseKeep_PlaceOrderOrdinary_Model  mj_objectWithKeyValues:dic];
                model.Button_State = NO;
                [self.dataArray addObject:model];
            }
            [self.tableView reloadData];
        }else {
            [MBProgressHUD py_showError:@"暂无数据" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

#pragma mark----HomeHouseeKeepingPlaceOrderOrdinaryCellDelegate
- (void)HomeHouseeKeepingPlaceOrderOrdinaryCellButtonClick:(Home_HouseKeep_PlaceOrderOrdinary_Model *)model Number:(NSInteger)index {
    for (Home_HouseKeep_PlaceOrderOrdinary_Model *model in self.dataArray) {
        model.Button_State = NO;
    }
    Home_HouseKeep_PlaceOrderOrdinary_Model *modelMid = model;
    modelMid.Button_State = !modelMid.Button_State;
    [self.parm setObject:model.PlaceOrder_ID forKey:@"weight"];
    self.Price = model.price;
    [self.dataArray replaceObjectAtIndex:index withObject:modelMid];
    [self.tableView reloadData];
}
#pragma mark----HomeHouseKeepingPlaceOrderAddressTimeCellDelegate

- (void)ViewClick:(NSInteger)index {
    if (index == 1) {//地址
        Home_RunErrands_View *View = [[Home_RunErrands_View alloc] init];
        View.Navigation = self.navigationController;
        View.delegate = self;
        View.Title_Label.text = @"选择服务地址";
        [self.view addSubview:View];
    }else {//时间
        PickerView *pick = [[PickerView alloc] init];
        pick.delegate = self;
        pick.type = PickerViewTypeDataAndHour;
        [self.view addSubview:pick];
    }
}

#pragma mark----PickerViewResultDelegate
- (void)pickerView:(UIView *)pickerView result:(NSString *)string {
    [self.parm setObject:string forKey:@"times"];
    [self.tableView reloadData];
}

#pragma mark----HomeHouseKeepingPlacOrderRemarksCellDelegate
- (void)textFieldText:(NSString *)text {
    [self.parm setObject:text forKey:@"remark"];
    [self.tableView reloadData];
}


#pragma mark----HomeRunErrandsViewDelegate

- (void)AddressSelectItem:(nonnull Mine_SetUP_MyAddress_Model *)model Number:(NSInteger)number {
    [self.parm setObject:model.MyAddress_id forKey:@"endid"];
    self.Address_Model = model;
    [self.tableView reloadData];
}


/**
 //家政生成订单 普通保洁 pid家政ID endid 服务地点ID times服务时间 weight服务类型ID  remark备注
 Route::rule('generalhorderadd/:uid/:pid/:endid/:times/:weight/:remark','index/Husbandry/generalhOrderAdd');
 */

#pragma mark----UPdata
- (void)setDataSouerToBacker {
    [self.parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [self.parm setObject:self.Top_Modle.HouseKeeping_id forKey:@"pid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_generalOrderAdd parameters:self.parm success:^(NSDictionary * _Nonnull responseObject) {
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showSuccess:@"下单成功" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [MBProgressHUD py_showError:@"预约失败" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
        self.Sure_BT.userInteractionEnabled = YES;
    } failure:^(NSError * _Nonnull error) {
        self.Sure_BT.userInteractionEnabled = YES;
        [MBProgressHUD py_showError:@"下单失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}


@end
