//
//  Home_KDR_Order_ViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/7/10.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_KDR_Order_ViewController.h"
#define Cell_HomeKDROrderCell @"HomeKDROrderCell"
@interface Home_KDR_Order_ViewController ()<UITableViewDelegate, UITableViewDataSource, HomeKDROrderCellDelegate>
@property (strong, nonatomic) IBOutlet Basic_TableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) NSInteger Page;

@end

@implementation Home_KDR_Order_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Home_KDROrder_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:Cell_HomeKDROrderCell];
    MJWeakSelf;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.Page = 1;
        [weakSelf.dataArray removeAllObjects];
        [weakSelf POSTWasteOrderOrderLists];
        
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.Page += 1;
        [weakSelf POSTWasteOrderOrderLists];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView beginFresh];
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
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
    return self.dataArray.count;
}
// 返回Cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Home_KDROrder_Cell *cell = [tableView dequeueReusableCellWithIdentifier:Cell_HomeKDROrderCell];
    cell.delegate = self;
    [cell setDataSoureToCell:self.dataArray[indexPath.row]];
    return cell;
}

- (void)POSTWasteOrderOrderLists {
    /**
     waste/order/OrderLists
     uid
     page
     用户订单列表
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:@(self.Page) forKey:@"page"];
    [[HttpRequest sharedInstance] postWithURLString:URL_wasteOrderOrderLists parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        [self.tableView endRefresh];
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSArray *Array = [responseObject objectForKey:@"list"];
            for (NSDictionary *dic in Array) {
                NSLog(@"------------------------------%@", [dic objectForKey:@"type"]);
                Home_KDR_Order_Model *model = [Home_KDR_Order_Model  mj_objectWithKeyValues:dic];
                [self.dataArray addObject:model];
            }
            if (!Array.count) {
                [self.tableView hidenFooterView:NO];
            }
        }
        if (!self.dataArray.count){
            [self.tableView hidenFooterView:YES];
        }
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        [self.tableView endRefresh];
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
    
}

#pragma mark----HomeKDROrderCellDelegate
- (void)HomeKDROrderCellButtonClick:(Home_KDR_Order_Model *)model {
    if ([model.status intValue] == 2) {
        [self POSTWasteOrderOrderAffirm:model.Orderid];
    }
}


- (void)POSTWasteOrderOrderAffirm:(NSString *)orderid {
    /**
     waste/order/orderAffirm
     uid
     orderid
     确认完成 用户
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:orderid forKey:@"orderid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_wasteOrderOrderAffirm parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
//        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showSuccess:@"操作成功" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            [self.tableView beginFresh];
//        }else {
//            [MBProgressHUD py_showError:@"操作失败" toView:nil];
//            [MBProgressHUD setAnimationDelay:0.7f];
//        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

@end
