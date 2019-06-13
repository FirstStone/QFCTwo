//
//  Message_ForwardViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/4/16.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Message_ForwardViewController.h"
#define CellID_MessageApexCell @"MessageApexCell"
@interface Message_ForwardViewController ()<UITableViewDelegate, UITableViewDataSource, MessageApexCellDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation Message_ForwardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Message_ApexCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MessageApexCell];
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
    
    Message_ApexCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MessageApexCell];
    [cell.RightButton setTitle:@"评论" forState:UIControlStateNormal];
    cell.delegate = self;
    return cell;
}

#pragma mark----MessageApexCellDelegate
- (void)MessageApexCellRightButtonClick {
    Message_AnswerViewController *anVC = [[Message_AnswerViewController alloc] init];
    [self.navigationController pushViewController:anVC animated:YES];
}

@end
