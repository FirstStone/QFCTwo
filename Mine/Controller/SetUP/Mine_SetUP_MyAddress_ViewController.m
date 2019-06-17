//
//  Mine_SetUP_MyAddress_ViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/4/18.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_SetUP_MyAddress_ViewController.h"
#define CellID_MineSetUPMyAddressCell @"MineSetUPMyAddressCell"
@interface Mine_SetUP_MyAddress_ViewController ()<UITableViewDelegate, UITableViewDataSource,MineSetUPMyAddressCellDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation Mine_SetUP_MyAddress_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_SetUP_MyAddress_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MineSetUPMyAddressCell];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.dataArray removeAllObjects];
    [self setDataSoureToBacker];
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


- (IBAction)AddAddressbuttonClick:(id)sender {
    Mine_SetUPUI_MyAddress_NewAdd_VC *addVC = [[Mine_SetUPUI_MyAddress_NewAdd_VC alloc] init];
    [self.navigationController pushViewController:addVC animated:YES];
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
    if (self.MineSetUPMyAddressBlock) {
        self.MineSetUPMyAddressBlock(self.dataArray[indexPath.row]);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/**
 //收货地址列表
 Route::rule('addresslist/:uid','index/UserAddresss/addressList');
 */
#pragma mark----UPdata
- (void)setDataSoureToBacker {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_addressList parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSArray *Array = [responseObject objectForKey:@"list"];
            for (NSDictionary *dic in Array) {
                Mine_SetUP_MyAddress_Model *model = [Mine_SetUP_MyAddress_Model mj_objectWithKeyValues:dic];
                [self.dataArray addObject:model];
            }
            [self.tableView reloadData];
//            [MBProgressHUD py_showSuccess:@"地址添加成功" toView:nil];
//            [MBProgressHUD setAnimationDelay:0.7f];
        }else {
            [MBProgressHUD py_showError:@"暂无数据" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"信息获取失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

 /**
 //收货地址删除
 Route::rule('addressdel/:uid','index/UserAddress/addressDel')
 */




#pragma mark----MineSetUPMyAddressCellDelegate

- (void)MineSetUPMyAddressCellDelectButtonClick:(Mine_SetUP_MyAddress_Model *)modle button:(UIButton *)BT {
    BT.userInteractionEnabled = NO;
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:modle.MyAddress_id forKey:@"id"];
    [[HttpRequest sharedInstance] postWithURLString:URL_addressDel parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showSuccess:@"地址删除成功" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            [self.dataArray removeAllObjects];
            [self setDataSoureToBacker];
        }else {
            [MBProgressHUD py_showError:@"添加失败" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
        BT.userInteractionEnabled = YES;
    } failure:^(NSError * _Nonnull error) {
        BT.userInteractionEnabled = YES;
        [MBProgressHUD py_showError:@"删除失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

- (void)MineSetUPMyAddressCellEditButtonClick:(Mine_SetUP_MyAddress_Model *)modle button:(UIButton *)BT {
    Mine_SetUPUI_MyAddress_NewAdd_VC *edit = [[Mine_SetUPUI_MyAddress_NewAdd_VC alloc] init];
    [edit setDataSouerToMyaddress:modle];
    [self.navigationController pushViewController:edit animated:YES];
}

 /**
 默认地址选项
 index/address/installAddress
 uid
 id
 */
- (void)MineSetUPMyAddressCellDefaltButtonClick:(Mine_SetUP_MyAddress_Model *)modle button:(UIButton *)BT {
    BT.userInteractionEnabled = NO;
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:modle.MyAddress_id forKey:@"id"];
    [[HttpRequest sharedInstance] postWithURLString:URL_installAddress parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showSuccess:@"设置成功" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            [self.dataArray removeAllObjects];
            [self setDataSoureToBacker];
        }else {
            [MBProgressHUD py_showError:@"设置失败" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
        BT.userInteractionEnabled = YES;
    } failure:^(NSError * _Nonnull error) {
        BT.userInteractionEnabled = YES;
        [MBProgressHUD py_showError:@"设置失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}





@end
