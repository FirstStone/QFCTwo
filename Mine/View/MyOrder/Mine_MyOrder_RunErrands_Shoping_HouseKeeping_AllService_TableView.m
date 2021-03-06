//
//  Mine_MyOrder_RunErrands_Shoping_HouseKeeping_AllService_TableView.m
//  QFC
//
//  Created by tiaoxin on 2019/6/15.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_MyOrder_RunErrands_Shoping_HouseKeeping_AllService_TableView.h"
#define CellID_MineMyOrderShopCell @"MineMyOrderShopCell"
#define CellID_MineMyOrderRunErrandsCell @"MineMyOrderRunErrandsCell."
#define CellID_MineMyOrderHouseKeepingCell @"MineMyOrderHouseKeepingCell"

@interface Mine_MyOrder_RunErrands_Shoping_HouseKeeping_AllService_TableView ()<UITableViewDelegate, UITableViewDataSource, MineMyOrderTuiKuangFooterViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;


@end

@implementation Mine_MyOrder_RunErrands_Shoping_HouseKeeping_AllService_TableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = QFC_Color_F5F5F5;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.delegate = self;
        self.dataSource = self;
        [self registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_MyOrder_Shop_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MineMyOrderShopCell];
        [self registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_MyOrder_RunErrands_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MineMyOrderRunErrandsCell];
        [self registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_MyOrder_HouseKeeping_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MineMyOrderHouseKeepingCell];
        
        MJWeakSelf;
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakSelf.Page = 1;
            [weakSelf.dataArray removeAllObjects];
            if (weakSelf.index) {
                [weakSelf PostmyevaluateList];
            } else {
                [weakSelf LoadingDataSoure];
            }
        }];
        self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            weakSelf.Page += 1;
            if (weakSelf.index) {
                [weakSelf PostmyevaluateList];
            } else {
                [weakSelf LoadingDataSoure];
            }
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArray.count;
}
//返回一个分区里多少数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    Mine_Order_Model *model = self.dataArray[section];
    if ([model.type intValue] == 3) {
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
        if (model.goodslist.count) {
            [cell setDataSoureToCell:model.goodslist[indexPath.row] runPrice:model.errand_price YouhuiPrice:[NSString stringWithFormat:@"%0.2f", ([model.sum_price doubleValue] - [model.actual_price doubleValue])]];
        }
        return cell;
        
    }
    
    //    if (indexPath.section == 0) {
    //        Mine_MyOrder_Shop_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyOrderShopCell];
    //        return cell;
    //    }else if (indexPath.section == 1) {
    //        Mine_MyOrder_Shop_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyOrderShopCell];
    ////        cell.Title_Label.text = @"越南贵妃芒果香芒新鲜香甜";
    ////        cell.Sub_Label.text = @"500g/份";
    ////        cell.Discount_Label.hidden = YES;
    //        return cell;
    //    }else if(indexPath.section == 2) {
    //        Mine_MyOrder_RunErrands_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyOrderRunErrandsCell];
    //        return cell;
    //    }else {
    //        Mine_MyOrder_HouseKeeping_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyOrderHouseKeepingCell];
    //        return cell;
    //    }
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
        [headerView.Icon_imageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
        headerView.Title_Label.text = model.nickname;
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
    Mine_MyOrder_TuiKuang_FooterView *footerView = [[Mine_MyOrder_TuiKuang_FooterView alloc] init];
    footerView.delegate = self;
    footerView.OrderCellStyle = MyOrderFooterStyleShop;
    footerView.MyModel = model;
    if ([model.refundstatus intValue] == 0) {
        footerView.Right_BT.hidden = NO;
        [footerView.Right_BT setTitle:@"查看退款原因" forState:UIControlStateNormal];
    }else if ([model.refundstatus intValue] == 2) {
        //                [footerView.Right_BT setTitle:@"退款成功" forState:UIControlStateNormal];
        footerView.Right_BT.hidden = YES;
        footerView.Lift_BT.hidden = YES;
        footerView.Total_Label.hidden = YES;
        footerView.image_View.hidden = NO;

    }else if ([model.refundstatus intValue] == 3) {
        footerView.Right_BT.hidden = NO;
        [footerView.Right_BT setTitle:@"已拒绝" forState:UIControlStateNormal];
    }
    footerView.Discount_Label.text = [NSString stringWithFormat:@"跑腿费用：¥%@\n优惠：¥%0.2f", model.press_price, ([model.sum_price doubleValue] - [model.actual_price doubleValue])];
    [footerView setToTotalLabel:@"价格：" redText:[NSString stringWithFormat:@"¥%@", model.actual_price]];
    return footerView;
    
    /*if ([model.type intValue] == 3) {//商家
        footerView.OrderCellStyle = MyOrderStyleShop;
        footerView.Right_BT.hidden = NO;
        if ([model.merchant_errand intValue] == 1) {//配送
            if ([model.refundstatus intValue] == 0) {
                [footerView.Right_BT setTitle:@"待审核" forState:UIControlStateNormal];
            }else if ([model.refundstatus intValue] == 2) {
                //                [footerView.Right_BT setTitle:@"退款成功" forState:UIControlStateNormal];
                footerView.Right_BT.hidden = YES;
                footerView.Lift_BT.hidden = YES;
                footerView.Total_Label.hidden = YES;
                footerView.image_View.hidden = NO;
                
            }else if ([model.refundstatus intValue] == 3) {
                [footerView.Right_BT setTitle:@"退款失败" forState:UIControlStateNormal];
            }
        }else {//自取
            if ([model.refundstatus intValue] == 0) {
                [footerView.Right_BT setTitle:@"待审核" forState:UIControlStateNormal];
            }else if ([model.refundstatus intValue] == 2) {
                //                [footerView.Right_BT setTitle:@"退款成功" forState:UIControlStateNormal];
                footerView.Right_BT.hidden = YES;
                footerView.Lift_BT.hidden = YES;
                footerView.Total_Label.hidden = YES;
                footerView.image_View.hidden = NO;
                
            }else if ([model.refundstatus intValue] == 3) {
                [footerView.Right_BT setTitle:@"退款失败" forState:UIControlStateNormal];
            }
        }
        footerView.Discount_Label.text = [NSString stringWithFormat:@"跑腿费用：¥%@\n优惠：¥%0.2f", model.press_price, ([model.sum_price doubleValue] - [model.actual_price doubleValue])];
        [footerView setToTotalLabel:@"价格：" redText:[NSString stringWithFormat:@"¥%@", model.actual_price]];
        return footerView;
    }else if ([model.type intValue] == 1){//跑腿
        footerView.OrderCellStyle = MyOrderStyleRunErrands;
        [footerView setToTotalLabel:@"预约费用：" redText:[NSString stringWithFormat:@"¥%@", model.press_price]];
        if ([model.refundstatus intValue] == 0) {
            [footerView.Right_BT setTitle:@"待审核" forState:UIControlStateNormal];
        }else if ([model.refundstatus intValue] == 2) {
            //            [footerView.Right_BT setTitle:@"退款成功" forState:UIControlStateNormal];
            footerView.Right_BT.hidden = YES;
            footerView.Lift_BT.hidden = YES;
            footerView.Total_Label.hidden = YES;
            footerView.image_View.hidden = NO;
            
        }else if ([model.refundstatus intValue] == 3) {
            [footerView.Right_BT setTitle:@"退款失败" forState:UIControlStateNormal];
        }
        return footerView;
    }else{//家政
        footerView.OrderCellStyle = MyOrderStyleHouseKeeping;
        [footerView setToTotalLabel:@"服务费用：" redText:[NSString stringWithFormat:@"¥%@", model.actual_price]];
        
        if ([model.refundstatus intValue] == 0) {
            [footerView.Right_BT setTitle:@"待审核" forState:UIControlStateNormal];
        }else if ([model.refundstatus intValue] == 2) {
            //            [footerView.Right_BT setTitle:@"退款成功" forState:UIControlStateNormal];
            footerView.Right_BT.hidden = YES;
            footerView.Lift_BT.hidden = YES;
            footerView.Total_Label.hidden = YES;
            footerView.image_View.hidden = NO;
        }else if ([model.refundstatus intValue] == 3) {
            [footerView.Right_BT setTitle:@"退款失败" forState:UIControlStateNormal];
        }
        return footerView;
    }*/
    /*Mine_MyOrder_TableView_FooterView *footerView = [[Mine_MyOrder_TableView_FooterView alloc] init];
     footerView.Right_BT.hidden = YES;
     footerView.Lift_BT.hidden = YES;
     footerView.Total_Label.hidden = YES;
     footerView.image_View.hidden = NO;
     return footerView;*/
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 110.0f;
}

#pragma mark----MineMyOrderTuiKuangFooterViewDelegate

- (void)buttonStyle:(NSInteger)index model:(Mine_Order_Model *)model OrderStyle:(OrderStyle)style {
    if ((index = 2) && (self.index == 1) && (style == MyOrderFooterStyleShop)) {
        if ([model.refundstatus intValue] == 0) {
            UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"提示" message:model.cause preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"同意" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //成功返回Block
                [self POSTIndexOrdersRefundMerchantYes:@"1" HomeModel:model];
            }];
            UIAlertAction *CancelAction = [UIAlertAction actionWithTitle:@"拒绝" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //成功返回Block
                [self POSTIndexOrdersRefundMerchantYes:@"2" HomeModel:model];
            }];
            
            [alertV addAction:okAction];
            [alertV addAction:CancelAction];
            
            [self.My_NAVC presentViewController:alertV animated:YES completion:nil];
        }
    }
}


#pragma mark----UPdata
- (void)LoadingDataSoure {
    /**
     我发出的订单退款列表
     URL : https://www.txkuaiyou.com/index/orders/orderRefundList
     参数 :
     uid
     用户ID
     page
     分页
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:@(self.Page) forKey:@"page"];
    [[HttpRequest sharedInstance] postWithURLString:URL_orders_orderRefundList parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        [self endRefresh];
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSArray *Array = [responseObject objectForKey:@"list"];
            for (NSDictionary *dic in Array) {
                Mine_Order_Model *model = [Mine_Order_Model mj_objectWithKeyValues:dic];
                [self.dataArray addObject:model];
            }
            if (!Array.count) {
                [self hidenFooterView:NO];
            }
        }
        if (!self.dataArray.count && self.Page == 1) {
            [self hidenFooterView:YES];
        }
        [self reloadData];
    } failure:^(NSError * _Nonnull error) {
        [self endRefresh];
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

- (void)PostmyevaluateList {
    /**
     我收到的订单退款列表
     URL : https://www.txkuaiyou.com/index/orders/myOrderRefundList
     参数 :
     uid
     用户ID
     page
     分页
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:@(self.Page) forKey:@"page"];
    [[HttpRequest sharedInstance] postWithURLString:URL_orders_myOrderRefundList parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        [self endRefresh];
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSArray *Array = [responseObject objectForKey:@"list"];
            for (NSDictionary *dic in Array) {
                Mine_Order_Model *model = [Mine_Order_Model mj_objectWithKeyValues:dic];
                [self.dataArray addObject:model];
            }
            if (!Array.count) {
                [self hidenFooterView:NO];
            }
        }
        if (!self.dataArray.count && self.Page == 1) {
            [self hidenFooterView:YES];
        }
        [self reloadData];
    } failure:^(NSError * _Nonnull error) {
        [self endRefresh];
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
    
}

- (void)POSTIndexOrdersRefundMerchantYes:(NSString *)State HomeModel:(Mine_Order_Model *)model {
    /**
     服务商退款审核
     URL : https://www.txkuaiyou.com/index/orders/refundMerchantYes
     参数 :
     id
     退款列表ID
     uid
     用户ID
     type
     1同意2不同意
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:model.order_ID forKey:@"id"];
    [parm setObject:State forKey:@"type"];
    [[HttpRequest sharedInstance] postWithURLString:URL_orders_refundMerchantYes parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [self beginFresh];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"操作失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

@end
