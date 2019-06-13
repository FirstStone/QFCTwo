//
//  Mine_MyOrder_User_Service_ViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/4/22.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_MyOrder_User_Service_ViewController.h"
#define CellID_MineMyOrderShopCell @"MineMyOrderShopCell"
#define CellID_MineMyOrderRunErrandsCell @"MineMyOrderRunErrandsCell."
#define CellID_MineMyOrderHouseKeepingCell @"MineMyOrderHouseKeepingCell"

@interface Mine_MyOrder_User_Service_ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation Mine_MyOrder_User_Service_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_MyOrder_Shop_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MineMyOrderShopCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_MyOrder_RunErrands_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MineMyOrderRunErrandsCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_MyOrder_HouseKeeping_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MineMyOrderHouseKeepingCell];
}
- (IBAction)LiftButtonPOP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - UITableViewDelegate
//返回多少个分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}
//返回一个分区里多少数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return 2;//self.dataArray.count;
    }else {
        return 1;//self.dataArray.count;
    }
}
// 返回Cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        Mine_MyOrder_Shop_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyOrderShopCell];
        return cell;
    }else if (indexPath.section == 1) {
        Mine_MyOrder_Shop_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyOrderShopCell];
//        cell.Title_Label.text = @"越南贵妃芒果香芒新鲜香甜";
//        cell.Sub_Label.text = @"500g/份";
//        cell.Discount_Label.hidden = YES;
        return cell;
    }else if(indexPath.section == 2) {
        Mine_MyOrder_RunErrands_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyOrderRunErrandsCell];
        return cell;
    }else {
        Mine_MyOrder_HouseKeeping_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyOrderHouseKeepingCell];
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    Mine_MyOrder_TableView_HeaderView *headerView = [[Mine_MyOrder_TableView_HeaderView alloc] init];
    if (section == 2 || section == 3) {
        headerView.Title_Label.text = @"订单号：12345678910";
        headerView.Right_imageView.hidden = YES;
        headerView.Right_Label.hidden = YES;
        return headerView;
    }else {
        headerView.Icon_imageView.image = [UIImage imageNamed:@"icon_WD_Order_Dianpu_hui"];
        headerView.Title_Label.text = @"臻品果园";
        headerView.Right_imageView.image = [UIImage imageNamed:@"icon_WD_Order_Dianpu_ziqu"];
        headerView.Right_Label.text = @"自取";
        return headerView;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    Mine_MyOrder_TableView_FooterView *footerView = [[Mine_MyOrder_TableView_FooterView alloc] init];
    footerView.Right_BT.hidden = YES;
    footerView.Lift_BT.hidden = YES;
    footerView.Total_Label.hidden = YES;
    footerView.image_View.hidden = NO;
    return footerView;
//    if (section == 2 || section == 3) {
//        [footerView setToTotalLabel:@"预约费用：" redText:@"10"];
//        return footerView;
//    }else {
//        [footerView setToTotalLabel:@"共1件商品  合计：" redText:@"120"];
//        return footerView;
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 60.0f;
}


@end
