//
//  Mine_SetUP_Privacy_VC.m
//  QFC
//
//  Created by tiaoxin on 2019/4/18.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_SetUP_Privacy_VC.h"
#define CellIDMineSetUPCell @"Mine_SetUP_Cell"
@interface Mine_SetUP_Privacy_VC ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *title_Array;
@end

@implementation Mine_SetUP_Privacy_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title_Array = @[@"系统权限", @"黑名单"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_SetUP_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellIDMineSetUPCell];
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
    return self.title_Array.count;
}
// 返回Cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Mine_SetUP_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellIDMineSetUPCell];
    cell.Title_Label.text = self.title_Array[indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {//系统权限
        Mine_SetUP_Privacy_System_VC *systemVC = [[Mine_SetUP_Privacy_System_VC alloc] init];
        [self.navigationController pushViewController:systemVC animated:YES];
    }else {
        Mine_SetUP_Privacy_Blacklist_VC *backListVC = [[Mine_SetUP_Privacy_Blacklist_VC alloc] init];
        [self.navigationController pushViewController:backListVC animated:YES];
    }
}

@end
