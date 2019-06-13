//
//  Message_NotificationCenter_VC.m
//  QFC
//
//  Created by tiaoxin on 2019/4/16.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Message_NotificationCenter_VC.h"
#define CellID_MessageNotificationConterCell @"MessageNotificationConterCell"
@interface Message_NotificationCenter_VC ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tabelView;

@end

@implementation Message_NotificationCenter_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabelView.delegate = self;
    self.tabelView.dataSource = self;
    [self.tabelView registerNib:[UINib nibWithNibName:NSStringFromClass([Message_NotificationConter_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MessageNotificationConterCell];
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
    return 2;//self.dataArray.count;
}
// 返回Cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Message_NotificationConter_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MessageNotificationConterCell];
    
    return cell;
}


@end
