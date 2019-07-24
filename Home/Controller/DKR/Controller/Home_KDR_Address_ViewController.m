//
//  Home_KDR_Address_ViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/7/10.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_KDR_Address_ViewController.h"
#define CellID_MineSetUPMyAddressCell @"MineSetUPMyAddressCell"
@interface Home_KDR_Address_ViewController ()<UITableViewDelegate, UITableViewDataSource, MineSetUPMyAddressCellDelegate>

@property (strong, nonatomic) IBOutlet Basic_TableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation Home_KDR_Address_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_SetUP_MyAddress_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MineSetUPMyAddressCell];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    MJWeakSelf;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.dataArray removeAllObjects];
        [weakSelf POSTWasteAddressAddressList];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView beginFresh];
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (IBAction)LiftBtuuonPOP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)AddressButtonClick:(id)sender {
    Home_KDR_Address_New_ViewController *KDRVC = [[Home_KDR_Address_New_ViewController alloc] init];
    [KDRVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:KDRVC animated:YES];
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
    
    Mine_SetUP_MyAddress_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineSetUPMyAddressCell];
    cell.delegate = self;
    [cell setModelToCell:self.dataArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.addressBlock) {
        self.addressBlock(self.dataArray[indexPath.row]);
        [self.navigationController popViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:QFC_KDRHomeAlterView_NSNotification object:nil];
    }
}

- (void)POSTWasteAddressAddressList {
    /**
     1.KDR我的地址列表
     URL : https://www.txkuaiyou.com/waste/address/addressList
     参数 :
     uid 用户ID
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_WasteAddressAddressList parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        [self.tableView endRefresh];
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSArray *dataSoure = [responseObject objectForKey:@"list"];
            for (NSDictionary *dic in dataSoure) {
                Mine_SetUP_MyAddress_Model *model = [Mine_SetUP_MyAddress_Model mj_objectWithKeyValues:dic];
                [self.dataArray addObject:model];
            }
            if (!dataSoure.count) {
                [self.tableView hidenFooterView:NO];
            }
        }
        if (!self.dataArray.count){
            [self.tableView hidenFooterView:YES];
        }
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        [self.tableView endRefresh];
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
    
}

#pragma mark----MineSetUPMyAddressCellDelegate

- (void)MineSetUPMyAddressCellDefaltButtonClick:(nonnull Mine_SetUP_MyAddress_Model *)modle button:(nonnull UIButton *)BT {
    [self POSTWasteAddressDefaultFind:modle.MyAddress_id];
}

- (void)MineSetUPMyAddressCellDelectButtonClick:(nonnull Mine_SetUP_MyAddress_Model *)modle button:(nonnull UIButton *)BT {
    [self POSTWasteAddressDelFind:modle.MyAddress_id];
}

- (void)MineSetUPMyAddressCellEditButtonClick:(nonnull Mine_SetUP_MyAddress_Model *)modle button:(nonnull UIButton *)BT {
    Home_KDR_Address_New_ViewController *KDRVC = [[Home_KDR_Address_New_ViewController alloc] init];
    [KDRVC setDataSouerToMyaddress:modle];
    [KDRVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:KDRVC animated:YES];
}


- (void)POSTWasteAddressDefaultFind:(NSString *)addressid {
    /**
     3.KDR地址列表 设置默认地址
     URL : https://www.txkuaiyou.com/waste/address/defaultFind
     参数 :
     uid 用户ID
     id 地址ID
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:addressid forKey:@"id"];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_wasteAddressDefaultFind parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [self.tableView beginFresh];
            [MBProgressHUD py_showSuccess:@"设置成功" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }else {
            [MBProgressHUD py_showError:@"设置失败" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"操作失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

- (void)POSTWasteAddressDelFind:(NSString *)addressid {
    /**
     4.KDR地址列表 地址删除
     URL : https://www.txkuaiyou.com/waste/address/delFind
     参数 :
     uid 用户ID
     id 地址ID
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:addressid forKey:@"id"];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_wasteAddressDelFind parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [self.tableView beginFresh];
            [MBProgressHUD py_showSuccess:@"删除成功" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }else {
            [MBProgressHUD py_showError:@"删除失败" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"操作失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}




@end
