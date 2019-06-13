//
//  Mine_Wallet_CashOut_TableView.m
//  QFC
//
//  Created by tiaoxin on 2019/4/24.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_Wallet_CashOut_TableView.h"
#define CellID_MineWalletCashOutCell @"MineWalletCashOutCell"
@interface Mine_Wallet_CashOut_TableView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation Mine_Wallet_CashOut_TableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = QFC_BackColor_Gray;
//        [self registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_Wallet_CashOut_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MineWalletCashOutCell];
    }
    return self;
}

#pragma mark - UITableViewDelegate
//返回多少个分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
//返回一个分区里多少数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;//self.dataArray.count;
}
// 返回Cell内容
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    Mine_Wallet_CashOut_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineWalletCashOutCell];
//    if (self.index == 0) {//支付宝
//        cell
//    }
//    return cell;
//}

@end
