//
//  Mine_MyOrder_Details_ViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/4/30.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_MyOrder_Details_ViewController.h"
#define CellID_MineMyOrderDetailsStatisticsCell @"MineMyOrderDetailsStatisticsCell"

#define CellID_MineMyOrderDetailsTimeCell @"MineMyOrderDetailsTimeCell"
#define CellID_MineMyOrderShopCell @"MineMyOrderShopCell"
#define CellID_MineMyOrderRunErrandsCell @"MineMyOrderRunErrandsCell"
#define CellID_MineMyOrderHouseKeepingCell @"MineMyOrderHouseKeepingCell"
#define CellID_MineMyOrderDetailsStatisticsNewCell @"MineMyOrderDetailsStatisticsNewCell"
@interface Mine_MyOrder_Details_ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) Mine_Order_Details_Model *MyDetails_Model;

@property (nonatomic, strong) Mine_MyOrderDetails_Special_HeaderView *HeadView;

@end

@implementation Mine_MyOrder_Details_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_MyOrderDetails_Statistics_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MineMyOrderDetailsStatisticsCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_MyOrder_RunErrands_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MineMyOrderRunErrandsCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_MyOrder_HouseKeeping_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MineMyOrderHouseKeepingCell];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_MyOrderDetails_Time_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MineMyOrderDetailsTimeCell];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_MyOrder_Shop_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MineMyOrderShopCell];
   
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_MyOrderDetails_Statistics_New_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MineMyOrderDetailsStatisticsNewCell];
    
    self.HeadView = [[Mine_MyOrderDetails_Special_HeaderView alloc] init];
    self.HeadView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 130.0f);//170
    self.tableView.tableHeaderView = self.HeadView;
    [self LoadingDataSoure];
}
- (IBAction)LiftButtonPOP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDelegate
//返回多少个分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
//返回一个分区里多少数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.MyDetails_Model) {
        if ([self.MyDetails_Model.type intValue] == 3) {
            return 2 + self.MyDetails_Model.goodslist.count;
        } else {
            return 3;//self.dataArray.count;
        }
    }else {
        return 0;
    }
    
}
// 返回Cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.MyDetails_Model.type intValue] == 3) {//商家
        if (self.MyDetails_Model.goodslist.count > indexPath.row) {
                Message_Shoping_Branch_Model *model = self.MyDetails_Model.goodslist[indexPath.row];
                Mine_MyOrder_Shop_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyOrderShopCell];
                [cell setDataSoureToCell:model runPrice:@"" YouhuiPrice:@""];
                return cell;

        }else if (self.MyDetails_Model.goodslist.count == indexPath.row) {
            Mine_MyOrderDetails_Statistics_New_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyOrderDetailsStatisticsNewCell];
            [cell setMineOrderDetailsModelToCell:self.MyDetails_Model];
            return cell;
            
        }else {
            Mine_MyOrderDetails_Time_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyOrderDetailsTimeCell];
            [cell setMineOrderDetailsModelToCell:self.MyDetails_Model];
            return cell;
        }
    }else {
        if (indexPath.row == 0) {
            if ([self.MyDetails_Model.type intValue] == 1) {//跑腿
                Mine_MyOrder_RunErrands_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyOrderRunErrandsCell];
                [cell setMineOrderDetailsModelToCell:self.MyDetails_Model];
                return cell;
                
            }else {//家政
                Mine_MyOrder_HouseKeeping_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyOrderHouseKeepingCell];
                [cell setMineOrderDetailsModelToCell:self.MyDetails_Model];
                return cell;
            }
        }else if (indexPath.row == 1) {
            Mine_MyOrderDetails_Statistics_New_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyOrderDetailsStatisticsNewCell];
            [cell setMineOrderDetailsModelToCell:self.MyDetails_Model];
            return cell;
            
        }else {
            Mine_MyOrderDetails_Time_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyOrderDetailsTimeCell];
            [cell setMineOrderDetailsModelToCell:self.MyDetails_Model];
            return cell;
        }
    }
    /*
     else if (indexPath.row == 1) {
     Mine_MyOrderDetails_Statistics_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyOrderDetailsStatisticsCell];
     return cell;
     }else if (indexPath.row == 2) {
     Mine_MyOrderDetails_RunErrands_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyOrderDetailsRunErrandsCell];
     return cell;
     }
     */
}

#pragma mark----UPdata
/**
 订单详情
 URL : https://www.txkuaiyou.com/index/orders/orderDetails
 参数 :
 uid
 用户ID
 orderid
 订单ID
 */
- (void)LoadingDataSoure {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:self.OrderID forKey:@"orderid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_orders_orderDetails parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSDictionary *dic = [responseObject objectForKey:@"info"];
            self.MyDetails_Model  = [Mine_Order_Details_Model mj_objectWithKeyValues:dic];
            [self.HeadView.Photo_View sd_setImageWithURL:[NSURL URLWithString:self.MyDetails_Model.service_avatar]];
            switch ([self.MyDetails_Model.merchant_status intValue]) {
                case 0:
                    {
                        self.HeadView.Tip_Label.text = @"等待付款...";
                    }
                    break;
                case 1:
                {
                    self.HeadView.Tip_Label.text = @"等待接单...";
                }
                    break;
                case 2:
                {
                    self.HeadView.Tip_Label.text = @"待跑腿取货...";
                }
                    break;
                case 3:
                {
                    self.HeadView.Tip_Label.text = @"待跑腿取货...";
                }
                    break;
                case 4:
                {
                    self.HeadView.Tip_Label.text = @"待送达...";
                }
                    break;
                case 5:
                {
                    self.HeadView.Tip_Label.text = @"待确认...";
                }
                    break;
                default:
                {
                    self.HeadView.Tip_Label.hidden = YES;
                }
                    break;
            }
            [self.tableView reloadData];
        }
        if (!self.MyDetails_Model) {
            [self.tableView configDefaultEmptyView];
            [self.tableView.emptyPlaceView showWithImgName:@"暂无内容" title:@"暂无数据" des:nil tapClick:nil];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}



@end
