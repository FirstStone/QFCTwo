//
//  Home_ShopStore_ViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/6/16.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_ShopStore_ViewController.h"

#define CellID_HomeShopStoreLiftTableViewCell @"HomeShopStoreLiftTableViewCell"

@interface Home_ShopStore_ViewController ()<UITableViewDelegate, UITableViewDataSource>

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

@property (nonatomic, strong) NSMutableArray *Lift_DataArray;

@property (nonatomic, strong) NSMutableArray *Right_DataArray;

@property (nonatomic, strong) NSString *type;

@end

@implementation Home_ShopStore_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.type = @"0";
    self.Lift_TabelView.delegate = self;
    self.Lift_TabelView.dataSource = self;
    [self.Lift_TabelView registerNib:[UINib nibWithNibName:NSStringFromClass([Home_ShopStore_Lift_TableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_HomeShopStoreLiftTableViewCell];
    [self PostMerchantsMerchantInfo];
    [self PostMerchantsMerchantTypeList];
    [self PostMerchantsmerchantGoodsType];
}

- (IBAction)LiftButtonPOP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)FollowButtonClick:(id)sender {
    
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
    if ([tableView isMemberOfClass:[self.Lift_TabelView class]]) {
        return self.Lift_DataArray.count;
    }else {
        return self.Right_DataArray.count;
    }
}
// 返回Cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isMemberOfClass:[Home_ShopStore_Lift_TableViewCell class]]) {
        Home_ShopStoreStyle_Model *model = self.Lift_DataArray[indexPath.row];
        Home_ShopStore_Lift_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeShopStoreLiftTableViewCell];
        [cell SetDataSoureToCell:model];
        return cell;
    }else {
          Home_ShopStore_Right_TableViewCell 
    }
//    Home_ShopStore_Lift_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
//    //cell右箭头
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    XBPlayModel *model = [self.dataArray objectAtIndex:indexPath.row];
//    [cell setupUI:model]; //数据赋值
    
  
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
    [[HttpRequest sharedInstance] postWithURLString:URL_merchants_merchantInfo parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
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
    [parm setObject:@"1" forKey:@"page"];
    [[HttpRequest sharedInstance] postWithURLString:URL_merchants_merchantGoodsType parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSArray *Array = [responseObject objectForKey:@"list"];
            for (NSDictionary *dic in Array) {
                Home_ShopStore_Branch_Model *model = [Home_ShopStore_Branch_Model mj_objectWithKeyValues:dic];
                [self.Right_DataArray addObject:model];
            }
        }
        [self.Right_TableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}



@end
