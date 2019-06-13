//
//  Home_ShoppingCart_ViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/4/23.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_ShoppingCart_ViewController.h"
#define CellID_HomeShoppingCell @"HomeShoppingCell"
@interface Home_ShoppingCart_ViewController ()<UITableViewDelegate, UITableViewDataSource, HomeShoppingCatrHeaderViewDelegate, HomeShoppingCellDelegate>
@property (strong, nonatomic) IBOutlet UILabel *Tip_Label;
@property (strong, nonatomic) IBOutlet UIButton *Manage_BT;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;


@property (strong, nonatomic) IBOutlet UIButton *All_Button;

@property (strong, nonatomic) IBOutlet UILabel *Sum_PriceLabel;

@property (strong, nonatomic) IBOutlet UIButton *Sure_BT;

@end

@implementation Home_ShoppingCart_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Home_Shopping_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_HomeShoppingCell];
//    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Message_TZ_Default_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MessageTZDefaultCell];
//    [self LoadingDataSoure];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self LoadingDataSoure];
}

- (IBAction)LiftButtonPOP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
    Home_ShoppingCart_Model *model = self.dataArray[section];
    return model.goods.count;
}
// 返回Cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Home_ShoppingCart_Model *model = self.dataArray[indexPath.section];
    Home_Shopping_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeShoppingCell];
    [cell setModelToCell:model.goods[indexPath.row]];
    cell.delegate = self;
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    Home_ShoppingCatr_HeaderView *headerView = [[Home_ShoppingCatr_HeaderView alloc] init];
    Home_ShoppingCart_Model *model = self.dataArray[section];
    [headerView setDataSoureToCell:model];
    headerView.delegate= self;
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0f;
}

- (IBAction)MangeButtonClick:(id)sender {
    self.Manage_BT.selected = !self.Manage_BT.selected;
    if (self.Manage_BT.selected) {
        self.Sum_PriceLabel.hidden = YES;
        self.Sure_BT.selected = YES;
    }else {
        self.Sum_PriceLabel.hidden = NO;
        self.Sure_BT.selected = NO;
    }
}


- (IBAction)CouponButtonClick:(id)sender {
    if (self.Sure_BT.selected) {
        [self ShoppingCarDelect];
    }else {
        if ([[self getShopIDString] length]) {
            Home_ShoppingCatr_Settlement_ViewController *settlementVC = [[Home_ShoppingCatr_Settlement_ViewController alloc] init];
            settlementVC.ShoppingIDString = [self getShopIDString];
            [self.navigationController pushViewController:settlementVC animated:YES];
        }else {
            [MBProgressHUD py_showError:@"请选择商品" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
    }
}

- (IBAction)AllButtonClick:(id)sender {
    self.All_Button.selected = !self.All_Button.selected;
    for (int i = 0; i < self.dataArray.count; i++) {
        Home_ShoppingCart_Model *model = self.dataArray[i];
        model.ButtonState = self.All_Button.selected;
        for (int j = 0; j < model.goods.count; j ++) {
            Home_ShoppingCart_Branch_Model *MiddleModel = model.goods[j];
            MiddleModel.ButtonState = self.All_Button.selected;
            model.goods[j] = MiddleModel;
        }
        self.dataArray[i] = model;
    }
    [self.tableView reloadData];
    [self setSumPriceLabelText];
}

- (NSString *)getShopIDString {
    NSString *shoppingid = @"";
    for (Home_ShoppingCart_Model *model in self.dataArray) {
        for (Home_ShoppingCart_Branch_Model *Middle in model.goods) {
            if (Middle.ButtonState) {
                if (shoppingid.length) {
                    shoppingid = [NSString stringWithFormat:@"%@,%@", shoppingid ,Middle.Branch_id];
                }else {
                    shoppingid = [NSString stringWithFormat:@"%@",Middle.Branch_id];
                }
            }
        }
    }
    return shoppingid;
}

- (void)setSumPriceLabelText {
    double price = 0.0f;
    for (int i = 0; i < self.dataArray.count; i ++) {
        Home_ShoppingCart_Model *model = self.dataArray[i];
        for (int j = 0; j < model.goods.count; j ++) {
            Home_ShoppingCart_Branch_Model *MiddleModel = model.goods[j];
            if (MiddleModel.ButtonState) {
                price = price + [MiddleModel.price doubleValue] * [MiddleModel.goods_sum intValue];
            }
        }
    }
    NSLog(@"%0.2f", price);
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:@"合计："];
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, noteStr.length)];
    // 改变颜色
    NSMutableAttributedString * redStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%0.2f",price]];
    [redStr addAttribute:NSForegroundColorAttributeName value:QFC_Color_FF492B range:NSMakeRange(0, redStr.length)];
    // 改变字体大小及类型
    //    [noteStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-BoldOblique" size:27] range:range];
    // 为label添加Attributed
//    self.Text_View.font = [UIFont systemFontOfSize:16.0f weight:UIFontWeightMedium];
    [noteStr appendAttributedString:redStr];
    [self.Sum_PriceLabel setAttributedText:noteStr];
}



#pragma mark----UPdata
- (void)LoadingDataSoure {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_Shoppings_shoppingList parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSArray *Array = [responseObject objectForKey:@"list"];
            [self.dataArray removeAllObjects];
            int Sum = 0;
            for (NSDictionary *dic in Array) {
                Home_ShoppingCart_Model *model = [Home_ShoppingCart_Model  mj_objectWithKeyValues:dic];
                model.ButtonState = NO;
                for (int i = 0; i < model.goods.count; i++) {
                    Home_ShoppingCart_Branch_Model *Branchmodel = model.goods[i];
                    Branchmodel.ButtonState = NO;
                    model.goods[i] = Branchmodel;
                    ++Sum;
                }
                [self.dataArray addObject:model];
            }
            self.Tip_Label.text = [NSString stringWithFormat:@"共%d件商品", Sum];
            [self.tableView reloadData];
        }else {
            [MBProgressHUD py_showError:@"暂无数据" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"数据加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

/**
 购物车删除
 URL : https://www.txkuaiyou.com/index/Shoppings/shoppingDel
 参数 :
 uid
 用户ID
 shoppingid
 购物车ID  字符串  1,2,3  删除一条 1
 */
- (void)ShoppingCarDelect {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[self getShopIDString] forKey:@"shoppingid"];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_Shoppings_shoppingDel parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showError:@"操作成功" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            [self LoadingDataSoure];
        }else {
            [MBProgressHUD py_showError:@"操作异常" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"操作失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

/**
 购物车加一
 URL : https://www.txkuaiyou.com/index/Shoppings/addOne
 参数 :
 uid
 用户ID
 shoppingid
 购物车ID
 */
- (void)setAddOneDataSoureToBacker:(NSString *)shoppingid {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:shoppingid forKey:@"shoppingid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_Shoppings_addOne parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
//            [MBProgressHUD py_showError:@"操作成功" toView:nil];
//            [MBProgressHUD setAnimationDelay:0.7f];
            NSLog(@"%@", responseObject);
        }else {
            [MBProgressHUD py_showError:@"操作异常" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"操作失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

/**
 购物车减一
 URL : https://www.txkuaiyou.com/index/Shoppings/delOne
 参数 :
 uid
 用户ID
 shoppingid
 购物车ID
 */
- (void)setDelOneDataSoureToBacker:(NSString *)shoppingid {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:shoppingid forKey:@"shoppingid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_Shoppings_delOne parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            //            [MBProgressHUD py_showError:@"操作成功" toView:nil];
            //            [MBProgressHUD setAnimationDelay:0.7f];
            NSLog(@"%@", responseObject);
        }else {
            [MBProgressHUD py_showError:@"操作异常" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"操作失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}


#pragma mark----HomeShoppingCatrHeaderViewDelegate
- (void)HomeShoppingCatrHeaderViewButton:(Home_ShoppingCart_Model *)model {
    BOOL ALLbuttonState = YES;
    for (int i = 0; i < self.dataArray.count; i++) {
        Home_ShoppingCart_Model *MiddleModel = self.dataArray[i];
        if ([MiddleModel isEqual:model]) {
            MiddleModel.ButtonState = !MiddleModel.ButtonState;
            for (int j = 0; j < MiddleModel.goods.count; j++) {
                Home_ShoppingCart_Branch_Model *branchModel = MiddleModel.goods[j];
                branchModel.ButtonState = MiddleModel.ButtonState;
                MiddleModel.goods[j] = branchModel;
            }
            self.dataArray[i] = MiddleModel;
        }
        if (MiddleModel.ButtonState == NO) {
            ALLbuttonState = NO;
            self.All_Button.selected = NO;
        }
        if (ALLbuttonState) {
            self.All_Button.selected = YES;
        }
    }
    [self.tableView reloadData];
    [self setSumPriceLabelText];
}

#pragma mark----HomeShoppingCellDelegate
- (void)HomeShoppingCellButtonClick:(NSString *)modelid {
    BOOL ALLbuttonState = YES;
    for (int i = 0; i < self.dataArray.count; i++) {
        Home_ShoppingCart_Model *Model = self.dataArray[i];
        BOOL ShopState = YES;
        for (int j = 0; j < Model.goods.count; j++) {
            Home_ShoppingCart_Branch_Model *MiddleModel = Model.goods[j];
            if ([MiddleModel.Branch_id intValue] == [modelid intValue]) {
                MiddleModel.ButtonState = !MiddleModel.ButtonState;
                Model.goods[j] = MiddleModel;
            }
            if (MiddleModel.ButtonState == NO) {
                Model.ButtonState = NO;
                self.All_Button.selected = NO;
                ShopState = NO;
            }
            if (ShopState) {
                Model.ButtonState = YES;
            }
        }
        if (Model.ButtonState == NO) {
            ALLbuttonState = NO;
        }
        if (ALLbuttonState == YES && ShopState == YES) {
            self.All_Button.selected = YES;
        }
        self.dataArray[i] = Model;
    }
    [self.tableView reloadData];
    [self setSumPriceLabelText];
}

- (void)HomeShoppingCellSum:(NSString *)modelid State:(NSInteger)state {
    if (state == 1) {//减
        BOOL ReturnState = NO;
        for (int i = 0; i < self.dataArray.count; i ++) {
            Home_ShoppingCart_Model *model = self.dataArray[i];
            for (int j = 0; j < model.goods.count; j++) {
                Home_ShoppingCart_Branch_Model *MiddleModel = model.goods[j];
                if ([MiddleModel.Branch_id intValue] == [modelid intValue]) {
                    int Sum = [MiddleModel.goods_sum intValue];
                    if (Sum == 1) {
                        return;
                    }
                    MiddleModel.goods_sum = [NSString stringWithFormat:@"%d", --Sum];
                    ReturnState = YES;
                }
                if (ReturnState) {
                    model.goods[j] = MiddleModel;
                    break;
                }
            }
            if (ReturnState) {
                self.dataArray[i] = model;
                break;
            }
        }
        [self setDelOneDataSoureToBacker:modelid];
        [self.tableView reloadData];
        [self setSumPriceLabelText];
    } else {//加
        BOOL ReturnState = NO;
        for (int i = 0; i < self.dataArray.count; i ++) {
            Home_ShoppingCart_Model *model = self.dataArray[i];
            for (int j = 0; j < model.goods.count; j++) {
                Home_ShoppingCart_Branch_Model *MiddleModel = model.goods[j];
                if ([MiddleModel.Branch_id intValue] == [modelid intValue]) {
                    int Sum = [MiddleModel.goods_sum intValue];
                    MiddleModel.goods_sum = [NSString stringWithFormat:@"%d", ++Sum];
                    ReturnState = YES;
                }
                if (ReturnState) {
                    model.goods[j] = MiddleModel;
                    break;
                }
            }
            if (ReturnState) {
                self.dataArray[i] = model;
                break;
            }
        }
        [self setAddOneDataSoureToBacker:modelid];
        [self.tableView reloadData];
        [self setSumPriceLabelText];
    }
}







@end
