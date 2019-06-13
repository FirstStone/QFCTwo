//
//  Mine_SetUP_Currency_VC.m
//  QFC
//
//  Created by tiaoxin on 2019/4/18.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_SetUP_Currency_VC.h"
#define CellID_MineSetUPCell @"MineSetUPCell"
#define CellID_MineSetUPTextSwitchBBTCell @"MineSetUPTextSwitchBBTCell"
#define CellID @"tableViewCell"
@interface Mine_SetUP_Currency_VC ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *TitleArray;

@property (nonatomic, strong) UISwitch *UPData_SwitchBT;
@property (nonatomic, strong) UISwitch *Play_SwwitchBT;
@end

@implementation Mine_SetUP_Currency_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.TitleArray = @[@"新消息提醒", @"WLAN环境下自动下载最新安装包", @"WLAN环境下自动播放视频", @"清除本地缓存"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_SetUP_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MineSetUPCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_SetUP_Text_SwitchBBT_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MineSetUPTextSwitchBBTCell];
}
- (IBAction)LiftBittonPOP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark----懒加载
- (UISwitch *)UPData_SwitchBT {
    if (!_UPData_SwitchBT) {
        _UPData_SwitchBT = [[UISwitch alloc] init];
    }
    return _UPData_SwitchBT;
}

- (UISwitch *)Play_SwwitchBT {
    if (!_Play_SwwitchBT) {
        _Play_SwwitchBT = [[UISwitch alloc] init];
    }
    return _Play_SwwitchBT;
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
    if (indexPath.row == 0) {
        Mine_SetUP_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineSetUPCell];
        cell.Title_Label.text = self.TitleArray[indexPath.row];
        return cell;
    }else if (indexPath.row == 3) {
        Mine_SetUP_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineSetUPCell];
        cell.Title_Label.text = self.TitleArray[indexPath.row];
        cell.SubTitle_Label.text = @"66.66M";
        return cell;
    }else {
        Mine_SetUP_Text_SwitchBBT_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineSetUPTextSwitchBBTCell];
        cell.Title_Label.text = self.TitleArray[indexPath.row];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        Mine_SetUP_Currency_NewMessage_VC *newVC = [[Mine_SetUP_Currency_NewMessage_VC alloc] init];
        [self.navigationController pushViewController:newVC animated:YES];
    }
}
 


@end
