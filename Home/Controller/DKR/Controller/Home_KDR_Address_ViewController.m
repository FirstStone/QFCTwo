//
//  Home_KDR_Address_ViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/7/10.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_KDR_Address_ViewController.h"
#define CellID_MineSetUPMyAddressCell @"MineSetUPMyAddressCell"
@interface Home_KDR_Address_ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet Basic_TableView *tableView;

@end

@implementation Home_KDR_Address_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_SetUP_MyAddress_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MineSetUPMyAddressCell];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (IBAction)LiftBtuuonPOP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)AddressButtonClick:(id)sender {
    Home_KDR_Address_New_ViewController *KDRVC = [[Home_KDR_Address_New_ViewController alloc] init];
    [KDRVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:KDRVC animated:YES];
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
    
    Mine_SetUP_MyAddress_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineSetUPMyAddressCell];
    
    return cell;
}


@end
