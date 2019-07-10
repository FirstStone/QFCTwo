//
//  Home_KDR_Order_ViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/7/10.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_KDR_Order_ViewController.h"
#define Cell_HomeKDROrderCell @"HomeKDROrderCell"
@interface Home_KDR_Order_ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet Basic_TableView *tableView;

@end

@implementation Home_KDR_Order_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Home_KDROrder_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:Cell_HomeKDROrderCell];
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
    
    Home_KDROrder_Cell *cell = [tableView dequeueReusableCellWithIdentifier:Cell_HomeKDROrderCell];
    
    return cell;
}


@end
