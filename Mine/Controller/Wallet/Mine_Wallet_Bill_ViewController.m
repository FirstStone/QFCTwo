//
//  Mine_Wallet_Bill_ViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/4/24.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_Wallet_Bill_ViewController.h"
#define CellID_Mine_Wallet_Bill_Cell @"Mine_Wallet_Bill_Cell"

@interface Mine_Wallet_Bill_ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation Mine_Wallet_Bill_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_Wallet_Bill_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_Mine_Wallet_Bill_Cell];
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
    return 5;//self.dataArray.count;
}
// 返回Cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Mine_Wallet_Bill_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_Mine_Wallet_Bill_Cell];
   
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Mine_Wallet_BillDetails_ViewController *detailsVC = [[Mine_Wallet_BillDetails_ViewController alloc] init];
    [detailsVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:detailsVC animated:YES];
}

@end
