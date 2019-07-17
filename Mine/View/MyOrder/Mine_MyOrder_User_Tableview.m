//
//  Mine_MyOrder_User_Tableview.m
//  QFC
//
//  Created by tiaoxin on 2019/4/22.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_MyOrder_User_Tableview.h"
#define CellID_MineMyOrderShopCell @"MineMyOrderShopCell"
#define CellID_MineMyOrderRunErrandsCell @"MineMyOrderRunErrandsCell."
#define CellID_MineMyOrderHouseKeepingCell @"MineMyOrderHouseKeepingCell"
@interface Mine_MyOrder_User_Tableview ()<UITableViewDelegate, UITableViewDataSource, MineMyOrderTableViewFooterViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation Mine_MyOrder_User_Tableview

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TabelViewBeginDataSoure) name:@"TabelViewBeginDataSoure" object:nil];
        self.separatorStyle = UITableViewCellAccessoryNone;
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = QFC_BackColor_Gray;
        [self registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_MyOrder_Shop_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MineMyOrderShopCell];
        [self registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_MyOrder_RunErrands_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MineMyOrderRunErrandsCell];
        [self registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_MyOrder_HouseKeeping_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MineMyOrderHouseKeepingCell];
        MJWeakSelf;
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakSelf.Page = 1;
            [weakSelf.dataArray removeAllObjects];
            [weakSelf LoadingDataSoure];
          
        }];
        self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            weakSelf.Page += 1;
            [weakSelf LoadingDataSoure];
        }];
    }
    return self;
}


- (void)TabelViewBeginDataSoure {
    [self beginFresh];
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
    
    return self.dataArray.count;
}
//返回一个分区里多少数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.dataArray[section] goodslist].count) {
        return [self.dataArray[section] goodslist].count;
    }else {
        return 1;//self.dataArray.count;
    }
}
// 返回Cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Mine_Order_Model *model = self.dataArray[indexPath.section];
    NSLog(@"=========================%@", model.type);
    if ([model.type intValue] == 1) {//跑腿
        Mine_MyOrder_RunErrands_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyOrderRunErrandsCell];
        [cell setModelToCell:model];
        return cell;
    }else if ([model.type intValue] == 2) {//家政
        Mine_MyOrder_HouseKeeping_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyOrderHouseKeepingCell];
        [cell setModelToCell:model];
        return cell;
    }else {// 商家
        Mine_MyOrder_Shop_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyOrderShopCell];
        [cell setDataSoureToCell:model.goodslist[indexPath.row] runPrice:model.errand_price YouhuiPrice:[NSString stringWithFormat:@"%0.2f", ([model.sum_price doubleValue] - [model.actual_price doubleValue])]];
        return cell;
        
        /*if (indexPath.section == 0) {
            Mine_MyOrder_Shop_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyOrderShopCell];
            return cell;
        }else if (indexPath.section == 1) {
            Mine_MyOrder_Shop_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyOrderShopCell];
//            cell.Title_Label.text = @"越南贵妃芒果香芒新鲜香甜";
//            cell.Sub_Label.text = @"500g/份";
//            cell.Discount_Label.hidden = YES;
            return cell;
        }else if(indexPath.section == 2) {
            Mine_MyOrder_RunErrands_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyOrderRunErrandsCell];
            return cell;
        }else {
            Mine_MyOrder_HouseKeeping_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyOrderHouseKeepingCell];
            return cell;
        }*/
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    Mine_Order_Model *model = self.dataArray[section];
    Mine_MyOrder_TableView_HeaderView *headerView = [[Mine_MyOrder_TableView_HeaderView alloc] init];
    if ([model.type intValue] == 1) {//跑腿
        headerView.Title_Label.text = [NSString stringWithFormat:@"订单号：%@", model.ordersn];
        headerView.Icon_imageView.image = [UIImage imageNamed:@"icon_Photo"];
        headerView.Right_imageView.hidden = YES;
        headerView.Right_Label.hidden = YES;
        return headerView;
    }else if ([model.type intValue] == 2) {//家政
        headerView.Title_Label.text = [NSString stringWithFormat:@"订单号：%@", model.ordersn];
        [headerView.Icon_imageView sd_setImageWithURL:[NSURL URLWithString:model.service_avatar]];
        headerView.Right_imageView.hidden = YES;
        headerView.Right_Label.hidden = YES;
        return headerView;
    }else {//商家
        [headerView.Icon_imageView sd_setImageWithURL:[NSURL URLWithString:model.service_avatar]];
        headerView.Title_Label.text = model.service_name;
        if ([model.merchant_errand intValue] == 1) {//配送
            headerView.Right_imageView.image = [UIImage imageNamed:@"icon_WD_Order_Dianpu_LV"];
            headerView.Right_Label.text = @"配送";
        }else {
            headerView.Right_Label.text = @"自取";
            headerView.Right_imageView.image = [UIImage imageNamed:@"icon_WD_Order_Dianpu_ziqu"];
        }
        return headerView;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    Mine_Order_Model *model = self.dataArray[section];
    Mine_MyOrder_TableView_FooterView *footerView = [[Mine_MyOrder_TableView_FooterView alloc] init];
    footerView.MyModel = model;
    footerView.delegate = self;
    if ([model.type intValue] == 1) {//跑腿
        footerView.OrderCellStyle = MyOrderStyleRunErrands;
        [footerView setToTotalLabel:@"预约费用：" redText:[NSString stringWithFormat:@"¥%@", model.press_price]];
        switch ([model.status intValue]) {
            case 0://待付款
            {
                footerView.Lift_BT.hidden = NO;
                footerView.Right_BT.hidden = NO;
                [footerView.Lift_BT setTitle:@"  删除订单  " forState:UIControlStateNormal];
                [footerView.Right_BT setTitle:@" 去付款 " forState:UIControlStateNormal];
            }
                break;
            case 1://待接单
            {
                footerView.Lift_BT.hidden = NO;
                footerView.Right_BT.hidden = NO;
                footerView.Right_BT.userInteractionEnabled = NO;
                [footerView.Lift_BT setTitle:@"  取消订单  " forState:UIControlStateNormal];
                [footerView.Right_BT setTitle:@"  等待接单... " forState:UIControlStateNormal];
            }
                break;
            case 2://待取货
            {
                footerView.Lift_BT.hidden = NO;
                footerView.Right_BT.hidden = NO;
                footerView.Right_BT.userInteractionEnabled = NO;
                [footerView.Lift_BT setTitle:@"  退款/售后  " forState:UIControlStateNormal];
                [footerView.Right_BT setTitle:@"  等待取货  " forState:UIControlStateNormal];
            }
                break;
            case 3://二次付款
            {
                footerView.Lift_BT.hidden = NO;
                footerView.Right_BT.hidden = NO;
                [footerView.Lift_BT setTitle:@"  退款/售后  " forState:UIControlStateNormal];
                [footerView.Right_BT setTitle:@"  确认付款  " forState:UIControlStateNormal];
            }
                break;
            case 4://等待送货
            {
                footerView.Lift_BT.hidden = NO;
                footerView.Right_BT.hidden = NO;
                footerView.Right_BT.userInteractionEnabled = NO;
                [footerView.Lift_BT setTitle:@"  退款/售后  " forState:UIControlStateNormal];
                [footerView.Right_BT setTitle:@"  等待跑腿送货  " forState:UIControlStateNormal];
            }
            case 5://等待确认
            {
                footerView.Lift_BT.hidden = NO;
                footerView.Right_BT.hidden = NO;
                [footerView.Lift_BT setTitle:@"  退款/售后  " forState:UIControlStateNormal];
                [footerView.Right_BT setTitle:@"  确认完成  " forState:UIControlStateNormal];
            }
                break;
            default://评价
            {
                footerView.Right_BT.hidden = NO;
                [footerView.Right_BT setTitle:@"  评价  " forState:UIControlStateNormal];
            }
                break;
        }
        return footerView;
    }else if ([model.type intValue] == 2) {//家政
        footerView.OrderCellStyle = MyOrderStyleHouseKeeping;
        [footerView setToTotalLabel:@"服务费用：" redText:[NSString stringWithFormat:@"¥%@", model.actual_price]];
        switch ([model.status intValue]) {
            case 0://待付款
            {
                footerView.Lift_BT.hidden = NO;
                footerView.Right_BT.hidden = NO;
                [footerView.Lift_BT setTitle:@"  删除订单  " forState:UIControlStateNormal];
                [footerView.Right_BT setTitle:@" 去付款 " forState:UIControlStateNormal];
            }
                break;
            case 1://待接单
            {
                footerView.Lift_BT.hidden = NO;
                footerView.Right_BT.hidden = NO;
                footerView.Right_BT.userInteractionEnabled = NO;
                [footerView.Lift_BT setTitle:@"  取消订单  " forState:UIControlStateNormal];
                [footerView.Right_BT setTitle:@"  等待接单... " forState:UIControlStateNormal];
            }
                break;
            case 3://等待服务
            {
                footerView.Lift_BT.hidden = NO;
                footerView.Right_BT.hidden = NO;
                footerView.Right_BT.userInteractionEnabled = NO;
                [footerView.Lift_BT setTitle:@"  退款/售后  " forState:UIControlStateNormal];
                [footerView.Right_BT setTitle:@"  等待服务  " forState:UIControlStateNormal];
            }
                break;
            case 4://服务中
            {
                footerView.Lift_BT.hidden = NO;
                footerView.Right_BT.hidden = NO;
                footerView.Right_BT.userInteractionEnabled = NO;
                [footerView.Lift_BT setTitle:@"  退款/售后  " forState:UIControlStateNormal];
                [footerView.Right_BT setTitle:@"  服务中  " forState:UIControlStateNormal];
            }
                break;
            case 5://等待送货
            {
                footerView.Lift_BT.hidden = NO;
                footerView.Right_BT.hidden = NO;
                footerView.Right_BT.userInteractionEnabled = NO;
                [footerView.Lift_BT setTitle:@"  退款/售后  " forState:UIControlStateNormal];
                [footerView.Right_BT setTitle:@"  确认完成  " forState:UIControlStateNormal];
            }
                break;
            default://评价
            {
                footerView.Right_BT.hidden = NO;
                [footerView.Right_BT setTitle:@"  评价  " forState:UIControlStateNormal];
            }
                break;
        }
        return footerView;
    }else {//商家
        footerView.OrderCellStyle = MyOrderStyleShop;
        footerView.Right_BT.hidden = NO;
        if ([model.merchant_errand intValue] == 1) {//配送
            if ([model.status intValue] == 0) {
                footerView.Lift_BT.hidden = NO;
                [footerView.Lift_BT setTitle:@"取消订单" forState:UIControlStateNormal];
                [footerView.Right_BT setTitle:@"付款" forState:UIControlStateNormal];
                
            }else if ([model.status intValue] == 1) {
                footerView.Lift_BT.hidden = NO;
                [footerView.Lift_BT setTitle:@"退款" forState:UIControlStateNormal];
                [footerView.Right_BT setTitle:@"待接单" forState:UIControlStateNormal];
                
            }else if ([model.status intValue] == 2) {
                [footerView.Right_BT setTitle:@"待跑腿接单" forState:UIControlStateNormal];//不可点
                
            }else if ([model.status intValue] == 3) {
                [footerView.Right_BT setTitle:@"待跑腿取货" forState:UIControlStateNormal];
            }else if ([model.status intValue] == 4) {
                [footerView.Right_BT setTitle:@"待送达" forState:UIControlStateNormal];//不可点
                
            }else if ([model.status intValue] == 5) {
                [footerView.Right_BT setTitle:@"确认完成" forState:UIControlStateNormal];
            }else if ([model.status intValue] == 6) {
                [footerView.Right_BT setTitle:@"评价" forState:UIControlStateNormal];
            }
        }else {//自取
            if ([model.status intValue] == 0) {
                footerView.Lift_BT.hidden = NO;
                [footerView.Lift_BT setTitle:@"取消订单" forState:UIControlStateNormal];
                [footerView.Right_BT setTitle:@"付款" forState:UIControlStateNormal];
                
            }else if ([model.status intValue] == 1) {
                footerView.Lift_BT.hidden = NO;
                [footerView.Lift_BT setTitle:@"退款" forState:UIControlStateNormal];
                [footerView.Right_BT setTitle:@"待接单" forState:UIControlStateNormal];
                
            }else if ([model.status intValue] == 5) {
                [footerView.Right_BT setTitle:@"立即取货" forState:UIControlStateNormal];
            }else if ([model.status intValue] == 6) {
                [footerView.Right_BT setTitle:@"评价" forState:UIControlStateNormal];
            }
        }
        footerView.Discount_Label.text = [NSString stringWithFormat:@"跑腿费用：¥%@\n优惠：¥%0.2f", model.press_price, ([model.sum_price doubleValue] - [model.actual_price doubleValue])];
        [footerView setToTotalLabel:@"价格：" redText:[NSString stringWithFormat:@"¥%@", model.actual_price]];
        return footerView;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Mine_Order_Model *model = self.dataArray[indexPath.section];
    Mine_MyOrder_Details_ViewController *detailsVC = [[Mine_MyOrder_Details_ViewController alloc] init];
    detailsVC.OrderID = model.order_ID;
    [self.My_NAVC pushViewController:detailsVC animated:YES];
}

#pragma mark----UPdata
/**
 //我发出的订单列表  type 0全部 1代付款 2待接单 3待完成 4待评价
 Route::rule('OrderList/:uid/:page/:type','index/Orders/OrderList');
 */
- (void)LoadingDataSoure {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[Singleton sharedSingleton].Mid forKey:@"uid"];
    [parm setObject:@(self.Page) forKey:@"page"];
    [parm setObject:@(self.index) forKey:@"type"];
    [[HttpRequest sharedInstance] postWithURLString:URL_Orders_OrderList parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        [self endRefresh];
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSArray *Array = [responseObject objectForKey:@"list"];
            [self.dataArray removeAllObjects];
            for (NSDictionary *dic in Array) {
                NSLog(@"------------------------------%@", [dic objectForKey:@"type"]);
                Mine_Order_Model *model = [Mine_Order_Model  mj_objectWithKeyValues:dic];
                [self.dataArray addObject:model];
            }
            if (!Array.count) {
                [self hidenFooterView:NO];
            }
        }
        if (!self.dataArray.count){
            [self hidenFooterView:YES];
        }
        [self reloadData];
    } failure:^(NSError * _Nonnull error) {
        [self endRefresh];
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

#pragma mark----MineMyOrderTableViewFooterViewDelegate

- (void)buttonStyle:(NSInteger)index model:(Mine_Order_Model *)model OrderStyle:(OrderStyle)style {
    switch (style) {
        case MyOrderStyleHouseKeeping:
        {
            if ([model.status intValue] == 0) {
                if (index == 1) {//左   取消订单
                    [self PostIndexOrdersOrderDel:model];
                }else {//付款
                    Pay_ViewController *payVC = [[Pay_ViewController alloc] init];
                    payVC.OrderID = model.order_ID;
                    [self.My_NAVC pushViewController:payVC animated:YES];
                }
            }else if ([model.status intValue] == 5) {//确认完成
                [self PostIndexHusbandryFinishOrder:model];
                
            }else if ([model.status intValue] == 6) {
                //                    [footerView.Right_BT setTitle:@"评价" forState:UIControlStateNormal];
                Mine_MyOrder_Evaluate_ViewController *EvaluateVC = [[Mine_MyOrder_Evaluate_ViewController alloc] init];
                EvaluateVC.OrderID = model.order_ID;
                [self.My_NAVC pushViewController:EvaluateVC animated:YES];
            }
        }
            break;
        case MyOrderStyleRunErrands:
        {
            if ([model.status intValue] == 0) {//付款
                if (index == 1) {//左   取消订单
                    [self PostIndexOrdersOrderDel:model];
                }else {//付款
                    Pay_ViewController *payVC = [[Pay_ViewController alloc] init];
                    payVC.OrderID = model.order_ID;
                    [self.My_NAVC pushViewController:payVC animated:YES];
                }
            }else if ([model.status intValue] == 3) {//二次付款
                Pay_ViewController *payVC = [[Pay_ViewController alloc] init];
                payVC.OrderID = model.order_ID;
                payVC.Number = 1;
                [self.My_NAVC pushViewController:payVC animated:YES];
                
            }else if ([model.status intValue] == 5) {//确认完成
                [self PostIndexErrandUserComplete:model];
                
            }else if ([model.status intValue] == 6) {
                //                    [footerView.Right_BT setTitle:@"评价" forState:UIControlStateNormal];
                Mine_MyOrder_Evaluate_ViewController *EvaluateVC = [[Mine_MyOrder_Evaluate_ViewController alloc] init];
                EvaluateVC.OrderID = model.order_ID;
                [self.My_NAVC pushViewController:EvaluateVC animated:YES];
            }
        }
            break;

        case MyOrderStyleShop:
        {
            if ([model.merchant_errand intValue] == 1) {//配送
                if ([model.status intValue] == 0) {
                    if (index == 1) {//左   取消订单
                        [self PostIndexOrdersOrderDel:model];
                    }else {//付款
                        Pay_ViewController *payVC = [[Pay_ViewController alloc] init];
                        payVC.OrderID = model.order_ID;
                        [self.My_NAVC pushViewController:payVC animated:YES];
                    }
                }else if ([model.status intValue] == 1) {//退款售后
                    if (index == 1) {//左
                        Mine_MyOrder_UserTuikuan_ViewController *tuikuanVC = [[Mine_MyOrder_UserTuikuan_ViewController alloc] init];
                        tuikuanVC.MyOrder = model;
                        [tuikuanVC setHidesBottomBarWhenPushed:YES];
                        [self.My_NAVC pushViewController:tuikuanVC animated:YES];
                    }
                } else if ([model.status intValue] == 5) {//确认完成
                    [self PostindexMerchantsUserComplete:model];
                    
                }else if ([model.status intValue] == 6) {
                    Mine_MyOrder_Evaluate_ViewController *EvaluateVC = [[Mine_MyOrder_Evaluate_ViewController alloc] init];
                    EvaluateVC.OrderID = model.order_ID;
                    [self.My_NAVC pushViewController:EvaluateVC animated:YES];
                    //                        [footerView.Right_BT setTitle:@"评价" forState:UIControlStateNormal];
                }
            }else {//自取
                if ([model.status intValue] == 0) {
                    if (index == 1) {//左   取消订单
                        [self PostIndexOrdersOrderDel:model];
                    }else {//付款
                        Pay_ViewController *payVC = [[Pay_ViewController alloc] init];
                        payVC.OrderID = model.order_ID;
                        [self.My_NAVC pushViewController:payVC animated:YES];
                    }
                    
                }else if ([model.status intValue] == 1) {//退款售后
                    if (index == 1) {//左
                        Mine_MyOrder_UserTuikuan_ViewController *tuikuanVC = [[Mine_MyOrder_UserTuikuan_ViewController alloc] init];
                        tuikuanVC.MyOrder = model;
                        [tuikuanVC setHidesBottomBarWhenPushed:YES];
                        [self.My_NAVC pushViewController:tuikuanVC animated:YES];
                    }
                    
                } else if ([model.status intValue] == 5) {
//                                            [footerView.Right_BT setTitle:@"立即取货" forState:UIControlStateNormal];
                    NSMutableDictionary *dataSoure = [[NSMutableDictionary alloc] init];
                    [dataSoure setObject:model.order_ID forKey:@"orderid"];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"SetOrderQecode" object:nil userInfo:[NSDictionary dictionaryWithDictionary:dataSoure]];
//                    [self PostIndexOrdersOrderQrcode:model];
                }else if ([model.status intValue] == 6) {
                    //                        [footerView.Right_BT setTitle:@"评价" forState:UIControlStateNormal];
                    Mine_MyOrder_Evaluate_ViewController *EvaluateVC = [[Mine_MyOrder_Evaluate_ViewController alloc] init];
                    EvaluateVC.OrderID = model.order_ID;
                    [self.My_NAVC pushViewController:EvaluateVC animated:YES];
                }
            }
        }
            break;
        default:
            break;
    }
}
/**用户立即取货
 index/orders/OrderQrcode
 orderid
 */
- (void)PostIndexOrdersOrderQrcode:(Mine_Order_Model *)model {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    //    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:model.order_ID forKey:@"orderid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_orders_OrderQrcode parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            Mine_OrderQrcode_View *View = [[Mine_OrderQrcode_View alloc] init];
            [self addSubview:View];
        }else {
            [MBProgressHUD py_showError:[responseObject objectForKey:@"message"] toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"操作失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

/**
 index/orders/orderDel
 orderid
 uid
 取消订单
 */
- (void)PostIndexOrdersOrderDel:(Mine_Order_Model *)model {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:model.order_ID forKey:@"orderid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_orders_orderDel parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showError:@"删除成功" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            [self TabelViewBeginDataSoure];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"操作失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

/**
 index/errand/userComplete
 uid
 orderid
 用户确认订单完成接口
 */
- (void)PostIndexErrandUserComplete:(Mine_Order_Model *)model {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:model.order_ID forKey:@"orderid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_errand_userComplete parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showError:@"确认完成" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            [self TabelViewBeginDataSoure];
        }else {
            [MBProgressHUD py_showError:@"操作失败" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"操作失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

/**
 index/husbandry/finishOrder
 uid
 orderid
 用户确认完成
 */
- (void)PostIndexHusbandryFinishOrder:(Mine_Order_Model *)model {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:model.order_ID forKey:@"orderid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_husbandry_finishOrder parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showError:@"确认完成" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            [self TabelViewBeginDataSoure];
        }else {
            [MBProgressHUD py_showError:@"操作失败" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"操作失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

/**
 index/merchants/userComplete
 uid
 orderid
 用户确认完成
 */
- (void)PostindexMerchantsUserComplete:(Mine_Order_Model *)model {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:model.order_ID forKey:@"orderid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_merchants_userComplete parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showError:@"确认完成" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            [self TabelViewBeginDataSoure];
        }else {
            [MBProgressHUD py_showError:@"接单失败" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"操作失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

@end
