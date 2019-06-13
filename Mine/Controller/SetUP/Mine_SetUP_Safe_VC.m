//
//  Mine_SetUP_Safe_VC.m
//  QFC
//
//  Created by tiaoxin on 2019/4/18.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_SetUP_Safe_VC.h"
#define CellID @"tableViewCell"
@interface Mine_SetUP_Safe_VC ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *TitleArray;
@end

@implementation Mine_SetUP_Safe_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.TitleArray = @[@"设置修改登录密码", @"修改绑定手机号"];
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
    return self.TitleArray.count;
}
// 返回Cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        cell.textLabel.textColor = QFC_Color_333333;
        cell.textLabel.font = [UIFont systemFontOfSize:14.0f weight:UIFontWeightMedium];
    }
    //cell右箭头
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.TitleArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        Mine_SetUP_PassWord_VC *PasswordVC = [[Mine_SetUP_PassWord_VC alloc] init];
        [PasswordVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:PasswordVC animated:YES];
        
    }else {
        Mine_SetUP_Phone_VC *phoneVC = [[Mine_SetUP_Phone_VC alloc] init];
        [phoneVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:phoneVC animated:YES];
        
    }
}

@end
