//
//  Message_KDR_TableView.m
//  QFC
//
//  Created by tiaoxin on 2019/7/12.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Message_KDR_TableView.h"
#define Cell_HomeKDROrderCell @"HomeKDROrderCell"
@interface Message_KDR_TableView ()<UITableViewDelegate, UITableViewDataSource, HomeKDROrderCellDelegate>
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation Message_KDR_TableView


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.separatorStyle = UITableViewCellAccessoryNone;
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = QFC_BackColor_Gray;
//        [self registerNib:[UINib nibWithNibName:NSStringFromClass([Message_RunErrands_Tableview_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MessageRunErrandsTableviewCell];
        [self registerNib:[UINib nibWithNibName:NSStringFromClass([Home_KDROrder_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:Cell_HomeKDROrderCell];
    }
    MJWeakSelf;
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.Page = 1;
        [weakSelf.dataArray removeAllObjects];
        [weakSelf POSTwasteOrderMyOrderLists];
    }];
    self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.Page += 1;
        [weakSelf POSTwasteOrderMyOrderLists];
        
    }];
    return self;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
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
    [cell setDataSoureTocell:self.dataArray[indexPath.row] style:self.index];
    return cell;
}

- (void)POSTwasteOrderMyOrderLists {
    /**
     waste/order/MyOrderLists
     uid
     page
     type  1待接单2待完成
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:@(self.Page) forKey:@"page"];
    [parm setObject:(self.index ? @"2" : @"1") forKey:@"type"];
    [[HttpRequest sharedInstance] postWithURLString:URL_wasteOrderMyOrderLists parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        [self endRefresh];
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSArray *Array = [responseObject objectForKey:@"list"];
            for (NSDictionary *dic in Array) {
                Home_KDR_Order_Model *model = [Home_KDR_Order_Model  mj_objectWithKeyValues:dic];
                [self.dataArray addObject:model];
            }
            if (!Array.count) {
                [self hidenFooterView:NO];
            }
        }
        if (!self.dataArray.count && self.Page == 1) {
            [self hidenFooterView:YES];
        }else {
            [self.emptyPlaceView hide];
        }
        [self reloadData];
    } failure:^(NSError * _Nonnull error) {
        [self endRefresh];
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
    
}

#pragma mark----HomeKDROrderCellDelegate
- (void)HomeKDROrderCellButtonClick:(Home_KDR_Order_Model *)model {
    if (self.index){//待完成
        [self POSTWasteOrderOrderFulfill:model];
    }else {
        [self POSTWasteOrderOrderJoin:model];
    }
}


- (void)POSTWasteOrderOrderJoin:(Home_KDR_Order_Model *)model {
    /**
     waste/order/orderJoins
     uid
     orderid
     接单
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:model.Orderid forKey:@"orderid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_wasteOrderOrderJoins parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue] == 0) {
            [MBProgressHUD py_showError:@"接单失败" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }else {
            [self beginFresh];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

- (void)POSTWasteOrderOrderFulfill:(Home_KDR_Order_Model *)model {
    /**
     waste/order/orderFulfills
     uid
     orderid
     确认完成
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:model.Orderid forKey:@"orderid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_wasteOrderOrderFulfills parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue] == 0) {
            [MBProgressHUD py_showError:@"操作失败" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }else {
            [self beginFresh];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

@end
