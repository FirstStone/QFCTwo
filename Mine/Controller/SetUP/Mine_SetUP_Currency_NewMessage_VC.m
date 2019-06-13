//
//  Mine_SetUP_Currency_NewMessage_VC.m
//  QFC
//
//  Created by tiaoxin on 2019/4/18.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_SetUP_Currency_NewMessage_VC.h"
#define CellID_MineSetUPTextSwitchBBTCell @"MineSetUPTextSwitchBBTCell"
@interface Mine_SetUP_Currency_NewMessage_VC ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *title_Array;

@end

@implementation Mine_SetUP_Currency_NewMessage_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title_Array = @[@"接收的消息类型", @"通知消息", @"互动通知", @"服务提醒", @"社区活动", @"关注更新提醒", @"广场聊天消息提醒", @"提醒模式", @"声音", @"震动"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_SetUP_Text_SwitchBBT_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MineSetUPTextSwitchBBTCell];
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
    
    if (indexPath.row == 0 || indexPath.row == 7) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewcell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableViewcell"];
            cell.contentView.backgroundColor = QFC_BackColor_Gray;
            cell.textLabel.font = [UIFont systemFontOfSize:14.0f weight:UIFontWeightMedium];
            cell.textLabel.textColor = QFC_Color_Six;
        }
        cell.textLabel.text = self.title_Array[indexPath.row];
        return cell;
    }else {
        Mine_SetUP_Text_SwitchBBT_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineSetUPTextSwitchBBTCell];
        cell.Title_Label.text = self.title_Array[indexPath.row];
        return cell;
    }
}


@end
