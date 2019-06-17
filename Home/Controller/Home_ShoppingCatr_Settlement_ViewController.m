//
//  Mine_ShoppingCatr_Settlement_ViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/4/23.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_ShoppingCatr_Settlement_ViewController.h"
#define CellID_HomeShoppingCatrSettlementCell @"HomeShoppingCatrSettlementCell"
#define CellID_HomeShopCatrSettlementAddressCell @"HomeShopCatrSettlementAddressCell"
@interface Home_ShoppingCatr_Settlement_ViewController ()<UITableViewDelegate, UITableViewDataSource, HomeShopCatrSettlementFooterViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *SumPrice_Label;


@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSString *AddressID;

@property (nonatomic, strong) NSString *merchatid;

@end

@implementation Home_ShoppingCatr_Settlement_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.AddressID = @"";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Home_ShoppingCatr_Settlement_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_HomeShoppingCatrSettlementCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Home_ShopCatr_Settlement_Address_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_HomeShopCatrSettlementAddressCell];
    [self LoadingDataSoure];
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (IBAction)LiftButtonPOP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)SureButtonClick:(id)sender {
    if ([self.AddressID intValue]) {
        [self setDataSoureTobacker];
    }else {
        [MBProgressHUD py_showError:@"请选择地址" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }
}

#pragma mark - UITableViewDelegate
//返回多少个分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataArray.count;
}

//返回一个分区里多少数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.dataArray[section] isMemberOfClass:[Mine_SetUP_MyAddress_Model class]]) {
        return 1;
    }else {
        Home_ShoppingCatr_Settlement_Model *model = self.dataArray[section];
        return model.goods.count;
    }
}

// 返回Cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.dataArray[indexPath.section] isMemberOfClass:[Mine_SetUP_MyAddress_Model class]]) {
        Mine_SetUP_MyAddress_Model *model = self.dataArray[indexPath.section];
        Home_ShopCatr_Settlement_Address_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeShopCatrSettlementAddressCell];
        [cell setDataSoureToCell:model];
        return cell;
    }else {
        Home_ShoppingCatr_Settlement_Model *model = self.dataArray[indexPath.section];
        Home_ShoppingCatr_Settlement_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeShoppingCatrSettlementCell];
        [cell setDataSoureToCell:model.goods[indexPath.row]];
        return cell;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    } else {
        Home_ShoppingCatr_Settlement_Model *model = self.dataArray[section];
        Mine_MyOrder_TableView_HeaderView *headerView = [[Mine_MyOrder_TableView_HeaderView alloc] init];
        [headerView.Icon_imageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
        headerView.Title_Label.text = model.merchant;
        headerView.Right_imageView.hidden = YES;
        headerView.Right_Label.hidden = YES;
        return headerView;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    } else {
        Home_ShoppingCatr_Settlement_Model *model = self.dataArray[section];
        Home_ShopCatr_Settlement_FooterView *footerView = [[Home_ShopCatr_Settlement_FooterView alloc] init];
        [footerView setDataSoureToCell:model];
        footerView.delegate = self;
        return footerView;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 10;
    } else {
        return 50.0f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    } else {
        return 170.0f;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0 && indexPath.row == 0) {
        MJWeakSelf;
        Mine_SetUP_MyAddress_ViewController *MyaddressVC = [[Mine_SetUP_MyAddress_ViewController alloc] init];
        MyaddressVC.MineSetUPMyAddressBlock = ^(Mine_SetUP_MyAddress_Model * _Nonnull model) {
            weakSelf.dataArray[0] = model;
            weakSelf.AddressID = model.MyAddress_id;
            [weakSelf GetDataSourePrice:weakSelf.merchatid];
        };
        [self.navigationController pushViewController:MyaddressVC animated:YES];
    }
}

#pragma mark----UPdata
/*
 购物车选择商品 取货生成订单页面的数据
 URL : https://www.txkuaiyou.com/index/Shoppings/shoppingOrderDetails
 参数 :
 uid
 用户ID
 shoppingid
 购物车ID  字符串 1,2,3 单条传 1
 */
- (void)LoadingDataSoure {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:self.ShoppingIDString forKey:@"shoppingid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_Shoppings_shoppingOrderDetails parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSDictionary *addressDic = [responseObject objectForKey:@"address"];
            if (addressDic) {
                Mine_SetUP_MyAddress_Model *addModel = [Mine_SetUP_MyAddress_Model mj_objectWithKeyValues:addressDic];
                self.AddressID = addModel.MyAddress_id;
                if (!addModel.address.length) {
                    addModel.address = @"您还没有选择地址去选一个吧";
                }
                [self.dataArray addObject:addModel];
            }
            NSArray *Array = [responseObject objectForKey:@"list"];
            for (NSDictionary *dic in Array) {
                Home_ShoppingCatr_Settlement_Model *model = [Home_ShoppingCatr_Settlement_Model mj_objectWithKeyValues:dic];
                self.merchatid = model.merchant_id;
                model.RunPrice = @"0";
                model.ShoppingId = @"";
                model.Remark = @"";
                model.DeliveryState = YES;
                [self.dataArray addObject:model];
            }
        }
        [self getSumPrice];
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

/**
 购物车生成订单页面 选择配送获取跑腿价格
 URL : https://www.txkuaiyou.com/index/Shoppings/deliveryPrice
 参数 :
 addressid
 收货地址ID
 merchantid
 商家ID
 */
- (void)GetDataSourePrice:(NSString *)merchant_id {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:self.AddressID forKey:@"addressid"];
    [parm setObject:merchant_id forKey:@"merchantid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_Shoppings_deliveryPrice parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            for (int i = 0; i < self.dataArray.count; i ++) {
                if ([self.dataArray[i] isMemberOfClass:[Home_ShoppingCatr_Settlement_Model class]]) {
                    Home_ShoppingCatr_Settlement_Model *model = self.dataArray[i];
                    if ([model.merchant_id intValue] == [merchant_id intValue]) {
                        model.RunPrice = [responseObject objectForKey:@"message"];
                        model.DeliveryState = NO;
                        self.dataArray[i] = model;
                        [self getSumPrice];
                        [self.tableView reloadData];
                        break;
                    }
                }
            }
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

#pragma mark----HomeShopCatrSettlementFooterViewDelegate

- (void)HomeShopCatrSettlementFooterViewRemark:(NSString *)Remark modelID:(NSString *)modleid {
    for (int i = 0; i < self.dataArray.count; i ++) {
        if ([self.dataArray[i] isMemberOfClass:[Home_ShoppingCatr_Settlement_Model class]]) {
            Home_ShoppingCatr_Settlement_Model *model = self.dataArray[i];
            if ([model.merchant_id intValue] == [modleid intValue]) {
                model.Remark = Remark;
                 self.dataArray[i] = model;
                break;
            }
        }
    }
    [self.tableView reloadData];
}

- (void)HomeShopCatrSettlementFooterViewButton:(NSInteger)state modelID:(NSString *)modleid {
    for (int i = 0; i < self.dataArray.count; i ++) {
        if ([self.dataArray[i] isMemberOfClass:[Home_ShoppingCatr_Settlement_Model class]]) {
            Home_ShoppingCatr_Settlement_Model *model = self.dataArray[i];
            if ([model.merchant_id intValue] == [modleid intValue]) {
                if (state == 1) {//自取
                    model.RunPrice = @"0";
                    model.DeliveryState = YES;
                    self.dataArray[i] = model;
                    [self getSumPrice];
                    [self.tableView reloadData];
                    break;
                } else {//配送
                    if ([self.AddressID intValue]) {
                        [self GetDataSourePrice:modleid];
                    }else {
                        [MBProgressHUD py_showError:@"请选择地址" toView:nil];
                        [MBProgressHUD setAnimationDelay:0.7f];
                    }
                    break;
                }
            }
        }
    }
}

- (void)getSumPrice {
    double price = 0.0f;
    for (int i = 0; i < self.dataArray.count; i ++) {
        if ([self.dataArray[i] isMemberOfClass:[Home_ShoppingCatr_Settlement_Model class]]) {
            Home_ShoppingCatr_Settlement_Model *model = self.dataArray[i];
            for (int j = 0; j < model.goods.count; j ++) {
                Home_ShoppingCatr_Settlement_Branch_Model *MiddleModel = model.goods[j];
                price = price + [MiddleModel.price doubleValue] * [MiddleModel.goods_sum intValue];
            }
            price = price + [model.RunPrice doubleValue];
        }
    }
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:@"合计："];
    [noteStr addAttribute:NSForegroundColorAttributeName value:QFC_Color_333333 range:NSMakeRange(0, noteStr.length)];
    // 改变颜色
    NSMutableAttributedString * redStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%0.2f", price]];
    [redStr addAttribute:NSForegroundColorAttributeName value:QFC_Color_FF492B range:NSMakeRange(0, redStr.length)];
    // 改变字体大小及类型
    //    [noteStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-BoldOblique" size:27] range:range];
    // 为label添加Attributed
  
    [noteStr appendAttributedString:redStr];
    [self.SumPrice_Label setAttributedText:noteStr];
}

- (void)setDataSoureTobacker {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:self.AddressID forKey:@"addressid"];
    
    NSMutableArray *ParmArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.dataArray.count; i ++) {
        if ([self.dataArray[i] isMemberOfClass:[Home_ShoppingCatr_Settlement_Model class]]) {
            Home_ShoppingCatr_Settlement_Model *model = self.dataArray[i];
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setObject:model.merchant_id forKey:@"merchant_id"];
            NSString *disString = @"";
            for (Home_ShoppingCatr_Settlement_Branch_Model *MiddleModel in model.goods) {
                if (disString.length) {
                    disString = [NSString stringWithFormat:@"%@,%@", disString, MiddleModel.Branch_id];
                }else {
                    disString = [NSString stringWithFormat:@"%@", MiddleModel.Branch_id];
                }
            }
            [dic setObject:disString forKey:@"shoppingid"];
            //自取 2 配送1
            [dic setObject:model.DeliveryState ? @"2" : @"1" forKey:@"merchant_errand"];
            [dic setObject:model.Remark forKey:@"remark"];
            [dic setObject:@"0" forKey:@"discount_id"];
            [ParmArray addObject:dic];
        }
    }
//    [parm setObject:[[ParmArray modelToJSONString] stringByReplacingOccurrencesOfString:@"\\" withString:@""] forKey:@"list"];
    [parm setObject:[ParmArray modelToJSONString] forKey:@"list"];
    
    [[HttpRequest sharedInstance] postWithURLString:URL_Shoppings_shoppingOrderAdd parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            Pay_ViewController *payVC = [[Pay_ViewController alloc] init];
            payVC.OrderID = [responseObject objectForKey:@"message"];
            [self.navigationController pushViewController:payVC animated:YES];
        }else {
            [MBProgressHUD py_showError:@"结算失败" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"下单失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}


@end
