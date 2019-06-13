//
//  Mine_SetUP_Privacy_System_VC.m
//  QFC
//
//  Created by tiaoxin on 2019/4/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_SetUP_Privacy_System_VC.h"
#define CellID_MineSetUPCell @"MineSetUPCell"
@interface Mine_SetUP_Privacy_System_VC ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *title_Array;

@end

@implementation Mine_SetUP_Privacy_System_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title_Array = @[@"为向您提供更好的用户体验，快友社区在特定场景可能需要向您申请以下手机系统权限。 ",@"允许地址位置定位",@"根据您位置提供更契合您需求的页面展示",@"允许快友社区访问通讯录",@"方便您购物时取用您的联系人信息",@"允许快友社区访问相册",@"实现您图片或视频的取用与上传",@"允许快友社区访问相机",@"实现您扫码、拍摄"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_SetUP_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MineSetUPCell];
}
- (IBAction)LiftbuttonPOP:(id)sender {
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
    if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 4 || indexPath.row == 6||indexPath.row == 8) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableviewcell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableviewcell"];
            cell.textLabel.numberOfLines = 0;
            cell.textLabel.font = [UIFont systemFontOfSize:14.0f weight:UIFontWeightMedium];
            cell.textLabel.textColor = QFC_Color_Six;
            cell.contentView.backgroundColor = QFC_Color_F5F5F5;
        }
        cell.textLabel.text = self.title_Array[indexPath.row];
        return cell;
    } else {
        Mine_SetUP_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineSetUPCell];
        cell.Title_Label.text = self.title_Array[indexPath.row];
        cell.SubTitle_Label.text = @"去设置";
        return cell;
    }
}


@end
