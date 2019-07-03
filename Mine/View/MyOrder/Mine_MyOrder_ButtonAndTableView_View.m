//
//  Mine_MyOrder_ButtonAndTableView_View.m
//  QFC
//
//  Created by tiaoxin on 2019/4/22.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_MyOrder_ButtonAndTableView_View.h"

#define CellID_MineMyOrderShopCell @"MineMyOrderShopCell"
#define CellID_MineMyOrderRunErrandsCell @"MineMyOrderRunErrandsCell."
#define CellID_MineMyOrderHouseKeepingCell @"MineMyOrderHouseKeepingCell"
@interface Mine_MyOrder_ButtonAndTableView_View ()<UITableViewDelegate, UITableViewDataSource, MineMyOrderTableViewFooterViewDelegate>

@property (nonatomic, strong) UIButton *Lift_BT;
@property (nonatomic, strong) UIButton *Right_BT;

@property (nonatomic, strong) Basic_TableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation Mine_MyOrder_ButtonAndTableView_View

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TabelViewBeginDataSoure) name:@"TabelViewBeginDataSoure" object:nil];
        [self setUPUI];
    }
    return self;
}

- (void)setUPUI {
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_MyOrder_Shop_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MineMyOrderShopCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_MyOrder_RunErrands_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MineMyOrderRunErrandsCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_MyOrder_HouseKeeping_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MineMyOrderHouseKeepingCell];
    [self addSubview:self.Lift_BT];
    [self.Lift_BT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(40.0f);
        make.left.equalTo(self.mas_left).offset(10.0f);
        make.width.mas_offset((SCREEN_WIDTH - 30.0f)/ 2.0f);
        make.top.equalTo(self.mas_top).offset(10.0f);
    }];
    [self addSubview:self.Right_BT];
    [self.Right_BT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.Lift_BT.mas_right).offset(10.0f);
        make.right.equalTo(self.mas_right).offset(-10.0f);
        make.centerY.height.equalTo(self.Lift_BT);
    }];
    [self addSubview:self.tableView];
    MJWeakSelf;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.tableView.Page = 1;
        [weakSelf.dataArray removeAllObjects];
        if (self.Lift_BT.selected) {//我发出的
            [weakSelf LoadingHouseKeepingDataSoure];
        }else {//我接到的
            [weakSelf LoadingJieDaoHouseKeepingDataSoure];
        }
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.tableView.Page += 1;
        if (self.Lift_BT.selected) {//我发出的
            [weakSelf LoadingHouseKeepingDataSoure];
        }else {//我接到的
            [weakSelf LoadingJieDaoHouseKeepingDataSoure];
        }
    }];
}

- (void)TabelViewBeginDataSoure {
    [self.tableView beginFresh];
}

#pragma mark----懒加载

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (UIButton *)Lift_BT {
    if (!_Lift_BT) {
        _Lift_BT = [[UIButton alloc] init];
        [_Lift_BT setTitle:@"我发出的" forState:UIControlStateNormal];
        _Lift_BT.titleLabel.font = [UIFont systemFontOfSize:14.0f weight:UIFontWeightBold];
        [_Lift_BT setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _Lift_BT.backgroundColor = QFC_Color_30AC65;
        [_Lift_BT addTarget:self action:@selector(TopButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _Lift_BT.layer.cornerRadius = 20.0f;
        _Lift_BT.selected = YES;
        _Lift_BT.tag = 58958;
    }
    return _Lift_BT;
}

- (UIButton *)Right_BT {
    if (!_Right_BT) {
        _Right_BT = [[UIButton alloc] init];
        [_Right_BT setTitle:@"我接到的" forState:UIControlStateNormal];
        _Right_BT.titleLabel.font = [UIFont systemFontOfSize:14.0f weight:UIFontWeightBold];
        [_Right_BT setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _Right_BT.backgroundColor = QFC_Color_D8D8D8;
        [_Right_BT addTarget:self action:@selector(TopButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _Right_BT.layer.cornerRadius = 20.0f;
        _Right_BT.tag = 58959;
    }
    return _Right_BT;
}
- (void)TopButtonClick:(UIButton *)button {
    if (button.tag == 58958) {//我发出的
        button.selected = YES;
        self.Right_BT.selected = NO;
        button.backgroundColor = QFC_Color_30AC65;
        self.Right_BT.backgroundColor = QFC_Color_D8D8D8;
    }else {
        button.selected = YES;
        self.Lift_BT.selected = NO;
        button.backgroundColor = QFC_Color_30AC65;
        self.Lift_BT.backgroundColor = QFC_Color_D8D8D8;
    }
    [self.tableView beginFresh];
}

- (Basic_TableView *)tableView {
    if (!_tableView) {
        _tableView = [[Basic_TableView alloc] initWithFrame:CGRectMake(0, 60.0f, SCREEN_WIDTH, CGRectGetHeight(self.frame) - 60.0f) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellEditingStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = QFC_BackColor_Gray;
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate
//返回多少个分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.MyOrderViewStyle == MyOrderViewStyleRunErrands) {//跑腿
        return self.dataArray.count;
    }else if (self.MyOrderViewStyle == MyOrderViewStyleHouseKeeping) {//家政
        return self.dataArray.count;
    }else {//商家
        return self.dataArray.count;
    }
}
//返回一个分区里多少数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.MyOrderViewStyle == MyOrderViewStyleHouseKeeping) {//家政
        return 1;
    } else if (self.MyOrderViewStyle == MyOrderViewStyleRunErrands) {//跑腿
        return 1;
    } else {//商家
        Mine_Order_Model *model = self.dataArray[section];
        return model.goodslist.count;
    }
}
// 返回Cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
       Mine_Order_Model *model = self.dataArray[indexPath.section];
    if (self.Lift_BT.selected) {//我发出的
        if ([model.type intValue] == 1) {//1跑腿
            Mine_MyOrder_RunErrands_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyOrderRunErrandsCell];
            [cell setModelToCell:model];
            return cell;
        }else if ([model.type intValue] == 2) {//家政
            Mine_MyOrder_HouseKeeping_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyOrderHouseKeepingCell];
            [cell setModelToCell:model];
            return cell;
        }else {//商家
            Mine_MyOrder_Shop_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyOrderShopCell];
            [cell setDataSoureToCell:model.goodslist[indexPath.row] runPrice:model.errand_price YouhuiPrice:[NSString stringWithFormat:@"%0.2f", ([model.sum_price doubleValue] - [model.actual_price doubleValue])]];
            return cell;
        }
    }else {//我接到的
        if ([[Singleton sharedSingleton].type_id  intValue] == 1) {//跑腿
            Mine_MyOrder_RunErrands_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyOrderRunErrandsCell];
            [cell setModelToCell:model];
            return cell;
        }else {
            if ([model.type intValue] == 2) {//家政
                Mine_MyOrder_HouseKeeping_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyOrderHouseKeepingCell];
                [cell setModelToCell:model];
                return cell;
            }else {//商家
                Mine_MyOrder_Shop_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyOrderShopCell];
                [cell setDataSoureToCell:model.goodslist[indexPath.row] runPrice:model.errand_price YouhuiPrice:[NSString stringWithFormat:@"%0.2f", ([model.sum_price doubleValue] - [model.actual_price doubleValue])]];
                return cell;
            }
        }
        
    }
    
   /* if ([model.type intValue] == 1) {//1跑腿
        Mine_MyOrder_RunErrands_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyOrderRunErrandsCell];
        [cell setModelToCell:model];
        return cell;
    }else if ([model.type intValue] == 2) {//家政
        Mine_MyOrder_HouseKeeping_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyOrderHouseKeepingCell];
        [cell setModelToCell:model];
        return cell;
    }else {//商家
        Mine_MyOrder_Shop_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyOrderShopCell];
        [cell setDataSoureToCell:model.goodslist[indexPath.row] runPrice:model.errand_price YouhuiPrice:[NSString stringWithFormat:@"%0.2f", ([model.sum_price doubleValue] - [model.actual_price doubleValue])]];
        return cell;
    }*/
    /*
     else {//普通用户
     if (indexPath.section == 0) {
     Mine_MyOrder_Shop_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyOrderShopCell];
     return cell;
     }else if (indexPath.section == 1) {
     Mine_MyOrder_Shop_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyOrderShopCell];
     cell.Title_Label.text = @"越南贵妃芒果香芒新鲜香甜";
     cell.Sub_Label.text = @"500g/份";
     cell.Discount_Label.hidden = YES;
     return cell;
     }else if(indexPath.section == 2) {
     Mine_MyOrder_RunErrands_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyOrderRunErrandsCell];
     return cell;
     }else {
     Mine_MyOrder_HouseKeeping_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyOrderHouseKeepingCell];
     return cell;
     }
     }
     */
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    Mine_Order_Model *model = self.dataArray[section];
    Mine_MyOrder_TableView_HeaderView *headerView = [[Mine_MyOrder_TableView_HeaderView alloc] init];
    if (self.MyOrderViewStyle == MyOrderViewStyleHouseKeeping) {//家政
        [headerView.Icon_imageView sd_setImageWithURL:[NSURL URLWithString:model.service_avatar]];
        headerView.Title_Label.text = [NSString stringWithFormat:@"订单号：%@", model.ordersn];
        headerView.Right_imageView.hidden = YES;
        headerView.Right_Label.hidden = YES;
        return headerView;
    } else if (self.MyOrderViewStyle == MyOrderViewStyleRunErrands) {//跑腿
//        if (section == 0) {
        [headerView.Icon_imageView sd_setImageWithURL:[NSURL URLWithString:model.service_avatar]];
        headerView.Title_Label.text = [NSString stringWithFormat:@"订单号：%@", model.ordersn];
        headerView.Right_imageView.hidden = YES;
        headerView.Right_Label.hidden = YES;
        return headerView;
//        } else {
//            headerView.Icon_imageView.image = [UIImage imageNamed:@"icon_WD_Order_Dianpu_hui"];
//            headerView.Title_Label.text = @"臻品果园";
//            headerView.Right_imageView.image = [UIImage imageNamed:@"icon_WD_Order_Dianpu_LV"];
//            headerView.Right_Label.text = @"配送";
//            return headerView;
//        }
    }else {//商家
        Mine_Order_Model *model = self.dataArray[section];
        if (self.Right_BT.selected) {
            [headerView.Icon_imageView sd_setImageWithURL:[NSURL URLWithString:model.userimg]];
            headerView.Title_Label.text = model.username;
            if ([model.merchant_errand intValue] == 1) {//配送
                headerView.Right_imageView.image = [UIImage imageNamed:@"icon_WD_Order_Dianpu_LV"];
                headerView.Right_Label.text = @"配送";
            }else {
                headerView.Right_Label.text = @"自取";
                headerView.Right_imageView.image = [UIImage imageNamed:@"icon_WD_Order_Dianpu_ziqu"];
            }
        }else {
            [headerView.Icon_imageView sd_setImageWithURL:[NSURL URLWithString:model.service_avatar]];
            headerView.Title_Label.text = model.service_name;
            if ([model.merchant_errand intValue] == 1) {//配送
                headerView.Right_imageView.image = [UIImage imageNamed:@"icon_WD_Order_Dianpu_LV"];
                headerView.Right_Label.text = @"配送";
            }else {
                headerView.Right_Label.text = @"自取";
                headerView.Right_imageView.image = [UIImage imageNamed:@"icon_WD_Order_Dianpu_ziqu"];
            }
        }
        return headerView;
    }
    /*
     else {//普通用户
     if (section == 2 || section == 3) {
     headerView.Title_Label.text = @"订单号：12345678910";
     headerView.Right_imageView.hidden = YES;
     headerView.Right_Label.hidden = YES;
     return headerView;
     }else {
     headerView.Icon_imageView.image = [UIImage imageNamed:@"icon_WD_Order_Dianpu_hui"];
     headerView.Title_Label.text = @"臻品果园";
     headerView.Right_imageView.image = [UIImage imageNamed:@"icon_WD_Order_Dianpu_ziqu"];
     headerView.Right_Label.text = @"自取";
     return headerView;
     }
     }
     */
}
/**
 else if ([model.status intValue] == 2) {
 [self.Lift_BT setTitle:@"退款/售后" forState:UIControlStateNormal];
 [self.Right_BT setTitle:@"等待服务" forState:UIControlStateNormal];
 }
 */

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    Mine_Order_Model *model = self.dataArray[section];
    Mine_MyOrder_TableView_FooterView *footerView = [[Mine_MyOrder_TableView_FooterView alloc] init];
    footerView.MyModel = model;
    footerView.delegate = self;
    if (self.MyOrderViewStyle == MyOrderViewStyleHouseKeeping) {//家政
        footerView.OrderCellStyle = MyOrderStyleHouseKeeping;
        [footerView setToTotalLabel:@"价格：" redText:[NSString stringWithFormat:@"¥%@", model.sum_price]];
        footerView.Right_BT.hidden = NO;
        if (self.Right_BT.selected) {
            //我接到的
            if ([model.status intValue] == 0) {
                [footerView.Right_BT setTitle:@"等待付款" forState:UIControlStateNormal];//不可点
                
            }else if ([model.status intValue] == 1) {
                [footerView.Right_BT setTitle:@"立即接单" forState:UIControlStateNormal];
                
            }else if ([model.status intValue] == 3) {
                [footerView.Right_BT setTitle:@"开始服务" forState:UIControlStateNormal];
                
            }else if ([model.status intValue] == 4) {
                [footerView.Right_BT setTitle:@"完成服务" forState:UIControlStateNormal];
                
            }else if ([model.status intValue] == 5) {
                [footerView.Right_BT setTitle:@"待用户确认" forState:UIControlStateNormal];//不可点
            }else if ([model.status intValue] == 6) {
                [footerView.Right_BT setTitle:@"待用户评价" forState:UIControlStateNormal];//不可点
            }
        }else {
            //我发出的
            if ([model.status intValue] == 0) {
                footerView.Lift_BT.hidden = NO;
                [footerView.Lift_BT setTitle:@"取消订单" forState:UIControlStateNormal];
                [footerView.Right_BT setTitle:@"付款" forState:UIControlStateNormal];
                
            }else if ([model.status intValue] == 1) {
                [footerView.Right_BT setTitle:@"待家政接单" forState:UIControlStateNormal];//不可点
                
            }else if ([model.status intValue] == 3) {
                [footerView.Right_BT setTitle:@"待开始服务" forState:UIControlStateNormal];//不可点
                
            }else if ([model.status intValue] == 4) {
                [footerView.Right_BT setTitle:@"待完成服务" forState:UIControlStateNormal];//不可点
                
            }else if ([model.status intValue] == 5) {
                [footerView.Right_BT setTitle:@"确认完成" forState:UIControlStateNormal];
            }else if ([model.status intValue] == 6) {
                [footerView.Right_BT setTitle:@"评价" forState:UIControlStateNormal];
            }
        }
        
        return footerView;
    } else if (self.MyOrderViewStyle == MyOrderViewStyleRunErrands) {//跑腿
        footerView.OrderCellStyle = MyOrderStyleRunErrands;
        footerView.Right_BT.hidden = NO;
        if (self.Right_BT.selected) {//我接到的
            if ([model.type intValue] == 1) {//跑腿
                if ([model.status intValue] == 1) {
                    [footerView.Right_BT setTitle:@"立即抢单" forState:UIControlStateNormal];
                    
                }else if ([model.status intValue] == 2) {
                    [footerView.Right_BT setTitle:@"取货" forState:UIControlStateNormal];
                    
                }else if ([model.status intValue] == 3) {
                    [footerView.Right_BT setTitle:@"待用户付款" forState:UIControlStateNormal];
                    
                }else if ([model.status intValue] == 4) {
                    [footerView.Right_BT setTitle:@"确认送达" forState:UIControlStateNormal];
                    
                }else if ([model.status intValue] == 5) {
                    [footerView.Right_BT setTitle:@"待用户确认" forState:UIControlStateNormal];//不可点
                }else if ([model.status intValue] == 6) {
                    [footerView.Right_BT setTitle:@"待用户评价" forState:UIControlStateNormal];//不可点
                }
            }else {//商家
                if ([model.status intValue] == 2) {
                    [footerView.Right_BT setTitle:@"立即抢单" forState:UIControlStateNormal];
                    
                }else if ([model.status intValue] == 3) {
                    [footerView.Right_BT setTitle:@"取货" forState:UIControlStateNormal];
                    
                }else if ([model.status intValue] == 4) {
                    [footerView.Right_BT setTitle:@"送达" forState:UIControlStateNormal];
                    
                }else if ([model.status intValue] == 5) {
                    [footerView.Right_BT setTitle:@"待用户确认" forState:UIControlStateNormal];//不可点
                }else if ([model.status intValue] == 6) {
                    [footerView.Right_BT setTitle:@"待用户评价" forState:UIControlStateNormal];//不可点
                }
            }
        }else {//我发出的
            if ([model.status intValue] == 0) {
                footerView.Lift_BT.hidden = NO;
                [footerView.Lift_BT setTitle:@"取消订单" forState:UIControlStateNormal];
                [footerView.Right_BT setTitle:@"付款" forState:UIControlStateNormal];
                
            }else if ([model.status intValue] == 1) {
                [footerView.Right_BT setTitle:@"等待接单" forState:UIControlStateNormal];//不可点
                
            }else if ([model.status intValue] == 2) {
                [footerView.Right_BT setTitle:@"等待取货" forState:UIControlStateNormal];//不可点
                
            }else if ([model.status intValue] == 3) {
                [footerView.Right_BT setTitle:@"二次付款" forState:UIControlStateNormal];
            }else if ([model.status intValue] == 4) {
                [footerView.Right_BT setTitle:@"等待送达" forState:UIControlStateNormal];//不可点
                
            }else if ([model.status intValue] == 5) {
                [footerView.Right_BT setTitle:@"确认完成" forState:UIControlStateNormal];
            }else if ([model.status intValue] == 6) {
                [footerView.Right_BT setTitle:@"评价" forState:UIControlStateNormal];
            }
        }
        [footerView setToTotalLabel:@"价格：" redText:[NSString stringWithFormat:@"¥%@", model.press_price]];
        return footerView;
    }else {//商家
        footerView.OrderCellStyle = MyOrderStyleShop;
            footerView.Right_BT.hidden = NO;
        if (self.Right_BT.selected) {//我接到的
            if ([model.merchant_errand intValue] == 1) {//配送
                if ([model.status intValue] == 0) {
                    [footerView.Right_BT setTitle:@"待付款" forState:UIControlStateNormal];//不可点
                    
                }else if ([model.status intValue] == 1) {
                    footerView.Lift_BT.hidden = NO;
                    [footerView.Lift_BT setTitle:@"自送" forState:UIControlStateNormal];
                    [footerView.Right_BT setTitle:@"配送" forState:UIControlStateNormal];
                    
                }else if ([model.status intValue] == 2) {
                    [footerView.Right_BT setTitle:@"待跑腿接单" forState:UIControlStateNormal];//不可点
                    
                }else if ([model.status intValue] == 3) {
                    [footerView.Right_BT setTitle:@"待跑腿取货" forState:UIControlStateNormal];
                }else if ([model.status intValue] == 4) {
                    [footerView.Right_BT setTitle:@"待跑腿配送" forState:UIControlStateNormal];//不可点
                    
                }else if ([model.status intValue] == 5) {
                    [footerView.Right_BT setTitle:@"待用户确认" forState:UIControlStateNormal];
                }else if ([model.status intValue] == 6) {
                    [footerView.Right_BT setTitle:@"待用户评价" forState:UIControlStateNormal];
                }
            }else {//自取
                if ([model.status intValue] == 0) {
                    [footerView.Right_BT setTitle:@"待用户付款" forState:UIControlStateNormal];//不可点
                    
                }else if ([model.status intValue] == 1) {
                    [footerView.Right_BT setTitle:@"立即接单" forState:UIControlStateNormal];
                    
                }else if ([model.status intValue] == 5) {
                    [footerView.Right_BT setTitle:@"待用户取货" forState:UIControlStateNormal];
                }else if ([model.status intValue] == 6) {
                    [footerView.Right_BT setTitle:@"待用户评价" forState:UIControlStateNormal];
                }
            }
        }else {//我发出的
            if ([model.merchant_errand intValue] == 1) {//配送
                if ([model.status intValue] == 0) {
                    footerView.Lift_BT.hidden = NO;
                    [footerView.Lift_BT setTitle:@"取消订单" forState:UIControlStateNormal];
                    [footerView.Right_BT setTitle:@"付款" forState:UIControlStateNormal];
                    
                }else if ([model.status intValue] == 1) {
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
                    [footerView.Right_BT setTitle:@"待接单" forState:UIControlStateNormal];
                    
                }else if ([model.status intValue] == 5) {
                    [footerView.Right_BT setTitle:@"立即取货" forState:UIControlStateNormal];
                }else if ([model.status intValue] == 6) {
                    [footerView.Right_BT setTitle:@"评价" forState:UIControlStateNormal];
                }
            }
        }
        footerView.Discount_Label.text = [NSString stringWithFormat:@"跑腿费用：¥%@\n优惠：¥%0.2f", model.press_price, ([model.sum_price doubleValue] - [model.actual_price doubleValue])];
        [footerView setToTotalLabel:@"价格：" redText:[NSString stringWithFormat:@"¥%@", model.actual_price]];
        return footerView;
    }
    /*
     else {
     if (section == 2 || section == 3) {
     [footerView setToTotalLabel:@"预约费用：" redText:@"10"];
     return footerView;
     }else {
     [footerView setToTotalLabel:@"共1件商品  合计：" redText:@"120"];
     return footerView;
     }
     }
     */
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Mine_Order_Model *model = self.dataArray[indexPath.section];
    Mine_MyOrder_Details_ViewController *detailsVC = [[Mine_MyOrder_Details_ViewController alloc] init];
    detailsVC.OrderID = model.order_ID;
    [self.My_NAVC pushViewController:detailsVC animated:YES];
}

#pragma mark----MineMyOrderTableViewFooterViewDelegate

- (void)buttonStyle:(NSInteger)index model:(Mine_Order_Model *)model OrderStyle:(OrderStyle)style {
    switch (style) {
        case MyOrderStyleHouseKeeping:
        {
            if (self.Right_BT.selected) {
                //我接到的
                if ([model.status intValue] == 1) {//立即接单
                    [self PostindexHusbandryJoinOrderAdd:model];
                    
                }else if ([model.status intValue] == 3) {//开始服务
                    [self PostindexmerchantsbeginOrder:model];
                    
                }else if ([model.status intValue] == 4) {//完成服务
                    [self PostIndexHusbandryEndOrder:model];
                }
            }else {
                //我发出的
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
                }
            }
        }
            break;
        case MyOrderStyleRunErrands:
        {
            if (self.Right_BT.selected) {//我接到的
                if ([model.type intValue] == 1) {//跑腿
                    if ([model.status intValue] == 1) {
//                        [footerView.Right_BT setTitle:@"立即抢单" forState:UIControlStateNormal];
                        
                    }else if ([model.status intValue] == 2) {//取货
                        [self AlterViewShow:model];
                        
                    }else if ([model.status intValue] == 4) {//确认送达
                        [self PostIndexErrandOrderComplete:model];
                        
                    }
                }else {//商家
                    if ([model.status intValue] == 3) {//取货
                        [self PostIndexErrandMerchantErrandFetch:model];
                        
                    }else if ([model.status intValue] == 4) {//送达
                        [self PostIndexErrandOrderComplete:model];
                        
                    }
                }
            }else {//我发出的
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
                }
            }
        }
            break;
        case MyOrderStyleShop:
        {
            if (self.Right_BT.selected) {//我接到的
                if ([model.merchant_errand intValue] == 1) {//配送 自送 接单
                    if ([model.status intValue] == 1) {
                        if (index == 1) {//左  自送
                            [self PostindexMerchantsMyJoinOrder:model];
                        }else {//配送
                            [self PostindexMerchantsErrandJoinOrder:model];
                        }
                    }else if ([model.status intValue] == 4) {
                        [self PostindexMerchantsMerchantComplete:model];
                    }
                }else {//自取
                    if ([model.status intValue] == 1) {//立即接单
                        [self PostindexMerchantsMySildJoinOrder:model];
                        
                    }else if ([model.status intValue] == 5) {
//                        [footerView.Right_BT setTitle:@"待用户取货" forState:UIControlStateNormal];
                    }else if ([model.status intValue] == 6) {
//                        [footerView.Right_BT setTitle:@"待用户评价" forState:UIControlStateNormal];
                    }
                }
            }else {//我发出的
                if ([model.merchant_errand intValue] == 1) {//配送
                    if ([model.status intValue] == 0) {
                        if (index == 1) {//左   取消订单
                            [self PostIndexOrdersOrderDel:model];
                        }else {//付款
                            Pay_ViewController *payVC = [[Pay_ViewController alloc] init];
                            payVC.OrderID = model.order_ID;
                            [self.My_NAVC pushViewController:payVC animated:YES];
                        }
                    }else if ([model.status intValue] == 5) {//确认完成
                        [self PostindexMerchantsUserComplete:model];
                        
                    }else if ([model.status intValue] == 6) {
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
                        
                    }else if ([model.status intValue] == 5) {
//                        [footerView.Right_BT setTitle:@"立即取货" forState:UIControlStateNormal];
                    }else if ([model.status intValue] == 6) {
//                        [footerView.Right_BT setTitle:@"评价" forState:UIControlStateNormal];
                    }
                }
            }
        }
            break;
        default:
        {
            
        }
            break;
    }
}



#pragma mark----UPdata
/**
 //我发出的订单列表  type 0全部 1代付款 2待接单 3待完成 4待评价
 Route::rule('OrderList/:uid/:page/:type','index/Orders/OrderList');
 */
- (void)LoadingHouseKeepingDataSoure {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:@(self.tableView.Page) forKey:@"page"];
    [parm setObject:@(self.index) forKey:@"type"];
    [[HttpRequest sharedInstance] postWithURLString:URL_Orders_OrderList parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        [self.tableView endRefresh];
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSArray *Array = [responseObject objectForKey:@"list"];
            for (NSDictionary *dic in Array) {
//                NSLog(@"------------------------------%@", [dic objectForKey:@"type"]);
                Mine_Order_Model *model = [Mine_Order_Model  mj_objectWithKeyValues:dic];
                [self.dataArray addObject:model];
            }
        }
        if (self.dataArray.count && self.tableView.Page == 1) {
            [self.tableView hidenFooterView:NO];
        }else {
            [self.tableView hidenFooterView:YES];
        }
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        [self.tableView endRefresh];
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

/**
 //我接到的订单列表  type 0全部 1代付款 2待接单 3待完成 4待评价
 Route::rule('myOrderList/:uid/:page/:type','index/Orders/myOrderList');
 */
- (void)LoadingJieDaoHouseKeepingDataSoure {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:@(self.tableView.Page) forKey:@"page"];
    [parm setObject:@(self.index) forKey:@"type"];
    [[HttpRequest sharedInstance] postWithURLString:URL_Orders_myOrderList parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        [self.tableView endRefresh];
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSArray *Array = [responseObject objectForKey:@"list"];
            for (NSDictionary *dic in Array) {
                //                NSLog(@"------------------------------%@", [dic objectForKey:@"type"]);
                Mine_Order_Model *model = [Mine_Order_Model  mj_objectWithKeyValues:dic];
                [self.dataArray addObject:model];
            }
        }
        if (self.dataArray.count && self.tableView.Page == 1) {
            [self.tableView hidenFooterView:NO];
        }else {
            [self.tableView hidenFooterView:YES];
        }
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        [self.tableView endRefresh];
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

#pragma mark----家政
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
        [self.tableView endRefresh];
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showError:@"删除成功" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            [self TabelViewBeginDataSoure];
        }
    } failure:^(NSError * _Nonnull error) {
        [self.tableView endRefresh];
        [MBProgressHUD py_showError:@"操作失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

 /**
 index/husbandry/joinOrderAdd
 uid
 orderid
 家政接单
 */

- (void)PostindexHusbandryJoinOrderAdd:(Mine_Order_Model *)model {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:model.order_ID forKey:@"orderid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_husbandry_joinOrderAdd parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
            if ([[responseObject objectForKey:@"status"] intValue]) {
                [MBProgressHUD py_showError:@"接单成功" toView:nil];
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

/**
 index/husbandry/beginOrder
 uid
 orderid
 开始服务
 */
- (void)PostindexmerchantsbeginOrder:(Mine_Order_Model *)model {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:model.order_ID forKey:@"orderid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_husbandry_beginOrder parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showError:@"服务开始" toView:nil];
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
 index/husbandry/endOrder
 uid
 orderid
 完成服务
 */
- (void)PostIndexHusbandryEndOrder:(Mine_Order_Model *)model {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:model.order_ID forKey:@"orderid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_husbandry_endOrder parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showError:@"服务完毕" toView:nil];
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

#pragma mark----跑腿


- (void)AlterViewShow:(Mine_Order_Model *)model {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请输入取货信息" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    MJWeakSelf;
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //
        [alertController dismissViewControllerAnimated:YES completion:nil];
        UITextField *textField = alertController.textFields[0];
        UITextField *textField1 = alertController.textFields[1];
        if (textField.text.length && textField1.text.length) {
            [weakSelf PostIndexErrandOrderFetch:model weight:textField1.text parcelPW:textField.text];
        }
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入取货码";
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入物品重量";
    }];
    [self.My_NAVC presentViewController:alertController animated:YES completion:nil];
}


/*
 index/errand/orderFetch
 parcel_pw   取货码
 weight     重量
 uid
 orderid
 取货
 */
- (void)PostIndexErrandOrderFetch:(Mine_Order_Model *)model weight:(NSString *)weight parcelPW:(NSString *)parcelpw {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:model.order_ID forKey:@"orderid"];
    [parm setObject:parcelpw forKey:@"parcel_pw"];
    [parm setObject:weight forKey:@"weight"];
    [[HttpRequest sharedInstance] postWithURLString:URL_errand_orderFetch parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showError:@"确认取货" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            [self TabelViewBeginDataSoure];
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
 index/errand/orderComplete
 uid
 orderid
 跑腿确认送达借口
 */
- (void)PostIndexErrandOrderComplete:(Mine_Order_Model *)model {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:model.order_ID forKey:@"orderid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_errand_orderComplete parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showError:@"确认送达" toView:nil];
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
#pragma mark----商家
/**
 index/merchants/MyJoinOrder
 uid
 orderid
 商家自己配送接单
 */
- (void)PostindexMerchantsMyJoinOrder:(Mine_Order_Model *)model {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:model.order_ID forKey:@"orderid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_merchants_MyJoinOrder parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showError:@"接单成功" toView:nil];
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

/**
 index/merchants/ErrandJoinOrder
 uid
 orderid
 配送 商家接单
 */
- (void)PostindexMerchantsErrandJoinOrder:(Mine_Order_Model *)model {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:model.order_ID forKey:@"orderid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_merchants_ErrandJoinOrder parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showError:@"接单成功" toView:nil];
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

/**
 index/merchants/MerchantComplete
 uid
 orderid
 商家配送 确认完成
 */
- (void)PostindexMerchantsMerchantComplete:(Mine_Order_Model *)model {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:model.order_ID forKey:@"orderid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_merchants_MerchantComplete parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showError:@"商品已送达" toView:nil];
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
    [[HttpRequest sharedInstance] postWithURLString:URL_errand_userComplete parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
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


/**
 index/errand/merchantErrandFetch
 uid
 orderid
 跑腿。商家取货
 */
- (void)PostIndexErrandMerchantErrandFetch:(Mine_Order_Model *)model {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:model.order_ID forKey:@"orderid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_errand_merchantErrandFetch parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showError:@"确认取货" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            [self TabelViewBeginDataSoure];
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
 index/merchants/MySildJoinOrder
 uid
 orderid
 自取接单
 */
- (void)PostindexMerchantsMySildJoinOrder:(Mine_Order_Model *)model {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:model.order_ID forKey:@"orderid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_merchants_MySildJoinOrder parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showError:@"接单成功" toView:nil];
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

///**跑腿 t对用户
// index/errand/orderComplete
// */
//- (void)PostIndexErrandOrderComplete:(Mine_Order_Model *)model {
//    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
//    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
//    [parm setObject:model.order_ID forKey:@"orderid"];
//    [[HttpRequest sharedInstance] postWithURLString:URL_errand_orderComplete parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
//        NSLog(@"%@", responseObject);
//        if ([[responseObject objectForKey:@"status"] intValue]) {
//            [MBProgressHUD py_showError:@"商品已送达" toView:nil];
//            [MBProgressHUD setAnimationDelay:0.7f];
//            [self TabelViewBeginDataSoure];
//        }else {
//            [MBProgressHUD py_showError:[responseObject objectForKey:@"message"] toView:nil];
//            [MBProgressHUD setAnimationDelay:0.7f];
//        }
//    } failure:^(NSError * _Nonnull error) {
//        [MBProgressHUD py_showError:@"操作失败" toView:nil];
//        [MBProgressHUD setAnimationDelay:0.7f];
//    }];
//}


@end
