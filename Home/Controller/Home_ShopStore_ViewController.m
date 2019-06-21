//
//  Home_ShopStore_ViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/6/16.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_ShopStore_ViewController.h"

#define CellID_HomeShopStoreLiftTableViewCell @"HomeShopStoreLiftTableViewCell"
#define CellID_HomeShopStoreRightTableViewCell @"HomeShopStoreRightTableViewCell"
@interface Home_ShopStore_ViewController ()<UITableViewDelegate, UITableViewDataSource, HomeShopStoreRightTableViewCellDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *Shop_imageView;
@property (strong, nonatomic) IBOutlet UILabel *ShopName_Label;
@property (strong, nonatomic) IBOutlet UILabel *Score_Label;
@property (strong, nonatomic) IBOutlet UILabel *Distance_Label;
@property (strong, nonatomic) IBOutlet UIButton *Follow_BT;
@property (strong, nonatomic) IBOutlet UILabel *Time_Label;
@property (strong, nonatomic) IBOutlet UITableView *Lift_TabelView;
@property (strong, nonatomic) IBOutlet UITableView *Right_TableView;
@property (strong, nonatomic) IBOutlet UIButton *Cart_BT;
@property (strong, nonatomic) IBOutlet UIButton *Tatal_BT;

@property (strong, nonatomic) IBOutlet UILabel *Price_Label;

@property (strong, nonatomic) IBOutlet UILabel *Tip_Label;

@property (nonatomic, strong) NSMutableArray *Lift_DataArray;

@property (nonatomic, strong) NSMutableArray *Right_DataArray;

@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) Home_ShopStore_Total_Model *TotalModel;

@end

@implementation Home_ShopStore_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.type = @"0";
    self.Lift_TabelView.delegate = self;
    self.Lift_TabelView.dataSource = self;
    self.Right_TableView.delegate = self;
    self.Right_TableView.dataSource = self;
    [self.Lift_TabelView registerNib:[UINib nibWithNibName:NSStringFromClass([Home_ShopStore_Lift_TableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_HomeShopStoreLiftTableViewCell];
    [self.Right_TableView registerNib:[UINib nibWithNibName:NSStringFromClass([Home_ShopStore_Right_TableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_HomeShopStoreRightTableViewCell];
    [self PostMerchantsMerchantInfo];
    [self PostMerchantsMerchantTypeList];
    [self PostMerchantsmerchantGoodsType];
    [self POSTShoppingsMerchantShopping];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self POSTShoppingsMerchantShopping];
    [self PostMerchantsmerchantGoodsType];
}

- (IBAction)LiftButtonPOP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)CartButtonClick:(id)sender {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
        Home_ShoppingCart_ViewController *shoppingVC = [[Home_ShoppingCart_ViewController alloc] init];
        [shoppingVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:shoppingVC animated:YES];
    }else {
        Basic_NavigationController *LoginVC = [[Basic_NavigationController alloc] initWithRootViewController:[[Login_PhoneCodeViewControlloer alloc] init]];
        [self.navigationController presentViewController:LoginVC animated:YES completion:Nil];
    }
}


- (IBAction)FollowButtonClick:(id)sender {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
        [self POSTIndexMerchantsAttention];
    }else {
        Basic_NavigationController *LoginVC = [[Basic_NavigationController alloc] initWithRootViewController:[[Login_PhoneCodeViewControlloer alloc] init]];
        [self.navigationController presentViewController:LoginVC animated:YES completion:Nil];
    }
}

- (IBAction)BalanceButtonClick:(id)sender {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
        [self PostPayAlipliy];
    }else {
        Basic_NavigationController *LoginVC = [[Basic_NavigationController alloc] initWithRootViewController:[[Login_PhoneCodeViewControlloer alloc] init]];
        [self.navigationController presentViewController:LoginVC animated:YES completion:Nil];
    }
}


- (NSMutableArray *)Lift_DataArray {
    if (!_Lift_DataArray) {
        _Lift_DataArray = [[NSMutableArray alloc] init];
    }
    return _Lift_DataArray;
}

- (NSMutableArray *)Right_DataArray {
    if (!_Right_DataArray) {
        _Right_DataArray = [[NSMutableArray alloc] init];
    }
    return _Right_DataArray;
}


#pragma mark - UITableViewDelegate
//返回多少个分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//返回一个分区里多少数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:self.Lift_TabelView]) {
        return self.Lift_DataArray.count;
    }else {
        return self.Right_DataArray.count;
    }
}
// 返回Cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.Lift_TabelView]) {
        Home_ShopStoreStyle_Model *model = self.Lift_DataArray[indexPath.row];
        Home_ShopStore_Lift_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeShopStoreLiftTableViewCell];
        [cell SetDataSoureToCell:model];
        return cell;
    }else {
        Home_ShopStore_Branch_Model *model = self.Right_DataArray[indexPath.row];
        Home_ShopStore_Right_TableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeShopStoreRightTableViewCell];
        Cell.delegate = self;
        [Cell SetDataSoureToRightCell:model];
        return Cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.Lift_TabelView]) {
        Home_ShopStoreStyle_Model *model = self.Lift_DataArray[indexPath.row];
        self.type = model.Style_id;
        [self PostMerchantsmerchantGoodsType];
    }else {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
            Home_ShopStore_Branch_Model *model = self.Right_DataArray[indexPath.row];
            Home_CommunityNearby_Branch_Details_VC *VC = [[Home_CommunityNearby_Branch_Details_VC alloc] init];
            VC.goodid = model.Goods_id;
            [VC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:VC animated:YES];
        }else {
            Basic_NavigationController *LoginVC = [[Basic_NavigationController alloc] initWithRootViewController:[[Login_PhoneCodeViewControlloer alloc] init]];
            [self.navigationController presentViewController:LoginVC animated:YES completion:Nil];
        }
    }
}

- (void)setTipLabelAndTotalPriceLabel {
    self.Price_Label.text = [NSString stringWithFormat:@"¥%@", self.TotalModel.price];
    if ([self.TotalModel.sum intValue]) {
        self.Tip_Label.hidden = NO;
        self.Tip_Label.text = [NSString stringWithFormat:@" %@ ", self.TotalModel.sum];
    }else {
        self.Tip_Label.hidden = YES;
    }
}

#pragma mark----HomeShopStoreRightTableViewCellDelegate
/**点击减号按钮*/
- (void)HomeShopStoreRightTableViewCellSubtractButtonClick:(Home_ShopStore_Branch_Model *)model {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
        [self POSTShoppingsShoppingDels:model.Goods_id SelectModel:model];
    }else {
        Basic_NavigationController *LoginVC = [[Basic_NavigationController alloc] initWithRootViewController:[[Login_PhoneCodeViewControlloer alloc] init]];
        [self.navigationController presentViewController:LoginVC animated:YES completion:Nil];
    }
}
/**点击加号按钮*/
- (void)HomeShopStoreRightTableViewCellAddButtonClick:(Home_ShopStore_Branch_Model *)model {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
        [self POSTShoppingsShoppingAdds:model.Goods_id SelectModel:model];
    }else {
        Basic_NavigationController *LoginVC = [[Basic_NavigationController alloc] initWithRootViewController:[[Login_PhoneCodeViewControlloer alloc] init]];
        [self.navigationController presentViewController:LoginVC animated:YES completion:Nil];
    }
}
/**购物车按钮点击*/
- (void)HomeShopStoreRightTableViewCellCartButtonClick:(Home_ShopStore_Branch_Model *)model {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
        [self POSTShoppingsShoppingAdds:model.Goods_id SelectModel:model];
    }else {
        Basic_NavigationController *LoginVC = [[Basic_NavigationController alloc] initWithRootViewController:[[Login_PhoneCodeViewControlloer alloc] init]];
        [self.navigationController presentViewController:LoginVC animated:YES completion:Nil];
    }
}

#pragma mark----UPdata
- (void)PostMerchantsMerchantInfo {
    /**
     index/merchants/merchantInfo
     uid
     merchantid
     获取店铺信息
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:self.Shopid forKey:@"merchantid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_Merchants_merchantInfo parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSDictionary *infoDic = [responseObject objectForKey:@"info"];
            if (infoDic) {
                [self.Shop_imageView sd_setImageWithURL:[NSURL URLWithString:[infoDic objectForKey:@"avatar"]]];
                self.ShopName_Label.text = [infoDic objectForKey:@"merchant"];
                self.Score_Label.text = [infoDic objectForKey:@"grade"];
                self.Time_Label.text = [NSString stringWithFormat:@"营业时间：%@ - %@", [infoDic objectForKey:@"beginbusiness"], [infoDic objectForKey:@"endbusiness"]];
                self.Follow_BT.selected = [[infoDic objectForKey:@"status"] intValue] ? YES : NO;

            }
            NSDictionary *addressDic = [responseObject objectForKey:@"address"];
            if (addressDic) {
                self.Distance_Label.text = [addressDic objectForKey:@"distance"];
            }
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

/**获取店铺分类*/
- (void)PostMerchantsMerchantTypeList {
    /**
     index/merchants/merchantTypeList
     merchantid
     获取店铺分类
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:self.Shopid forKey:@"merchantid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_merchants_merchantTypeList parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSArray *Array = [responseObject objectForKey:@"list"];
            for (NSDictionary *dic in Array) {
                Home_ShopStoreStyle_Model *model = [Home_ShopStoreStyle_Model mj_objectWithKeyValues:dic];
                [self.Lift_DataArray addObject:model];
            }
        }
        [self.Lift_TabelView reloadData];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}


/**获取店铺右边数据*/
- (void)PostMerchantsmerchantGoodsType {
    /**
     index/merchants/merchantGoodsType
     merchantid
     type
     根据商家分类获取商品列表
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:self.Shopid forKey:@"merchantid"];
    [parm setObject:self.type forKey:@"type"];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_merchants_merchantGoodsType parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSArray *Array = [responseObject objectForKey:@"list"];
            [self.Right_DataArray removeAllObjects];
            for (NSDictionary *dic in Array) {
                Home_ShopStore_Branch_Model *model = [Home_ShopStore_Branch_Model mj_objectWithKeyValues:dic];
                if ([model.sum intValue]) {
                    model.Cart_Sate = YES;
                }else {
                    model.Cart_Sate = NO;
                }
                [self.Right_DataArray addObject:model];
            }
        }
        [self.Right_TableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

/**购物车数量加1*/
- (void)POSTShoppingsShoppingAdds:(NSString *)goodsid SelectModel:(Home_ShopStore_Branch_Model *)model {
    /**
     1. 商家店铺商品加入购物车 加一
     URL : https://www.txkuaiyou.com/index/shoppings/shoppingAdds
     参数 :
     goodsid 商品ID
     uid 用户ID
     sum 传1
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:goodsid forKey:@"goodsid"];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:@"1" forKey:@"sum"];
    [[HttpRequest sharedInstance] postWithURLString:URL_shoppings_shoppingAdds parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            for (int i = 0; i < self.Right_DataArray.count; i++) {
                if ([self.Right_DataArray[i] isEqual:model]) {
                    if (!model.Cart_Sate) {//购物车透明
                        model.Cart_Sate = !model.Cart_Sate;
                    }
                    int Number = [model.sum intValue];
                    model.sum = [NSString stringWithFormat:@"%d", ++Number];
                    self.Right_DataArray[i] = model;
                    int TotalModelSum = [self.TotalModel.sum intValue];
                    self.TotalModel.sum = [NSString stringWithFormat:@"%d", ++TotalModelSum];
                    double SumPrice = [self.TotalModel.price doubleValue] + [model.price doubleValue];
                    self.TotalModel.price = [NSString stringWithFormat:@"%0.2f", SumPrice];
                    [self setTipLabelAndTotalPriceLabel];
                    break;
                }
            }
            [self.Right_TableView reloadData];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

/**购物车数量减1*/
- (void)POSTShoppingsShoppingDels:(NSString *)goodsid SelectModel:(Home_ShopStore_Branch_Model *)model {
    /**
     2. 商家店铺商品加入购物车 减一
     URL : https://www.txkuaiyou.com/index/shoppings/shoppingDels
     参数 :
     goodsid 商品ID
     uid 用户ID
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:goodsid forKey:@"goodsid"];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_shoppings_shoppingDels parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            for (int i = 0; i < self.Right_DataArray.count; i++) {
                if ([self.Right_DataArray[i] isEqual:model]) {
                    if (model.Cart_Sate && [model.sum intValue] == 1) {
                        model.Cart_Sate = !model.Cart_Sate;
                    }
                    int Number = [model.sum intValue];
                    model.sum = [NSString stringWithFormat:@"%d", --Number];
                    self.Right_DataArray[i] = model;
                    int TotalModelSum = [self.TotalModel.sum intValue];
                    self.TotalModel.sum = [NSString stringWithFormat:@"%d", --TotalModelSum];
                    double SumPrice = [self.TotalModel.price doubleValue] - [model.price doubleValue];
                    self.TotalModel.price = [NSString stringWithFormat:@"%0.2f", SumPrice];
                    [self setTipLabelAndTotalPriceLabel];
                    break;
                }
            }
            [self.Right_TableView reloadData];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

/**获取初始化数据*/
- (void)POSTShoppingsMerchantShopping{
    /**
     index/shoppings/merchantShopping
     uid
     merchantid
     获取店铺 购物车的数量  总价
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:self.Shopid forKey:@"merchantid"];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_shoppings_merchantShopping parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSDictionary *dataSoureDic = [responseObject objectForKey:@"info"];
            if (dataSoureDic) {
                self.TotalModel = [Home_ShopStore_Total_Model mj_objectWithKeyValues:dataSoureDic];
                self.Price_Label.text = [NSString stringWithFormat:@"¥%0.2f", [self.TotalModel.price doubleValue]];
                if ([self.TotalModel.sum intValue]) {
                    self.Tip_Label.hidden = NO;
                    self.Tip_Label.text = [NSString stringWithFormat:@" %@ ", self.TotalModel.sum];
                }
            }
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

- (void)PostPayAlipliy {
    /**
     index/shoppings/merchantShopping
     uid
     merchantid
     获取店铺 购物车的数量  总价
     */
    self.Tatal_BT.userInteractionEnabled = NO;
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:self.Shopid forKey:@"merchantid"];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_shoppings_merchantShopping parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        self.Tatal_BT.userInteractionEnabled = YES;
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSDictionary *dataSoureDic = [responseObject objectForKey:@"info"];
            if (dataSoureDic) {
                Home_ShopStore_Total_Model *model = [Home_ShopStore_Total_Model mj_objectWithKeyValues:dataSoureDic];
                Home_ShoppingCatr_Settlement_ViewController *settlementVC = [[Home_ShoppingCatr_Settlement_ViewController alloc] init];
                settlementVC.ShoppingIDString = model.shoppingid;
                [self.navigationController pushViewController:settlementVC animated:YES];
            }
        }
    } failure:^(NSError * _Nonnull error) {
        self.Tatal_BT.userInteractionEnabled = YES;
        [MBProgressHUD py_showError:@"下单失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}


- (void)POSTIndexMerchantsAttention {
    /**关注店铺
     index/merchants/attention
     merchantid
     uid
     */
    self.Follow_BT.userInteractionEnabled = NO;
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:self.Shopid forKey:@"merchantid"];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_merchants_attention parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        self.Follow_BT.userInteractionEnabled = YES;
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showError:@"操作成功" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            [self PostMerchantsMerchantInfo];
        }
    } failure:^(NSError * _Nonnull error) {
        self.Follow_BT.userInteractionEnabled = YES;
        [MBProgressHUD py_showError:@"操作失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

@end
