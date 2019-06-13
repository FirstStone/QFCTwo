//
//  Mine_SetUP_Privacy_Blacklist_VC.m
//  QFC
//
//  Created by tiaoxin on 2019/4/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_SetUP_Privacy_Blacklist_VC.h"
#define CellID_MineSetUPPrivacyBlacklistCell @"MineSetUPPrivacyBlacklistCell"
@interface Mine_SetUP_Privacy_Blacklist_VC ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation Mine_SetUP_Privacy_Blacklist_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_SetUP_Privacy_Blacklist_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MineSetUPPrivacyBlacklistCell];
}
- (IBAction)LiftButtonPOP:(id)sender {
    [self.navigationController  popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDelegate
//返回多少个分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
//返回一个分区里多少数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;//self.dataArray.count;
}
// 返回Cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Mine_SetUP_Privacy_Blacklist_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineSetUPPrivacyBlacklistCell];
  
    return cell;
}


@end
