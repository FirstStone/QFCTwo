//
//  Mine_WalletViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/4/24.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_WalletViewController.h"

#define CellID @"tabelViewCell"

@interface Mine_WalletViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *Balance_Label;
@property (strong, nonatomic) IBOutlet UILabel *Profit_Label;
@property (strong, nonatomic) IBOutlet UILabel *ProfitBalance_Label;

@property (nonatomic, strong) NSArray *Title_Array;
@property (nonatomic, strong) NSArray *Icon_Array;

@end

@implementation Mine_WalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.Title_Array = @[@"提现", @"充值", @"我的账单"];
    self.Icon_Array = @[@"icon_WDZH_tixian", @"icon_WDZH_chongzhi", @"icon_WDZH_zhangdan"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
}
- (IBAction)LiftButtonPOP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDelegate
//返回多少个分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
//返回一个分区里多少数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
// 返回Cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellID];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0f weight:UIFontWeightBold];
        cell.textLabel.textColor = QFC_Color_333333;
    }
    cell.imageView.image = [UIImage imageNamed:self.Icon_Array[indexPath.row]];
    cell.textLabel.text = self.Title_Array[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {//提现
        Mine_Wallet_CashOut_ViewController *cashOutVC = [[Mine_Wallet_CashOut_ViewController alloc] init];
        [cashOutVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:cashOutVC animated:YES];
    }else if (indexPath.row == 1) {//充值
        Mine_Wallet_Recharge_ViewController *recharge = [[Mine_Wallet_Recharge_ViewController alloc] init];
        [recharge setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:recharge animated:YES];
    }else {
        Mine_Wallet_Bill_ViewController *billVC = [[Mine_Wallet_Bill_ViewController alloc] init];
        [billVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:billVC animated:YES];
    }
}

@end
