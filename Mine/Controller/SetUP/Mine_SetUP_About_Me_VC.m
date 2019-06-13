//
//  Mine_SetUP_About_Me_VC.m
//  QFC
//
//  Created by tiaoxin on 2019/4/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_SetUP_About_Me_VC.h"
#define CellID_MineSetUPCell @"MineSetUPCell"
@interface Mine_SetUP_About_Me_VC ()<UITableViewDataSource , UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *title_Array;

@end

@implementation Mine_SetUP_About_Me_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title_Array = @[@"版权信息", @"软件使用许可证", @"快友社区平台服务协议", @"隐私权政策", @"证照信息", @"说明"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_SetUP_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MineSetUPCell];
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
    
    Mine_SetUP_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineSetUPCell];
    cell.Title_Label.text = self.title_Array[indexPath.row];
    
    return cell;
}


@end
