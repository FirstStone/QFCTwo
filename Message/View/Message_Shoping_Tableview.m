//
//  Message_Shopinag_Tableview.m
//  QFC
//
//  Created by tiaoxin on 2019/4/17.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Message_Shoping_Tableview.h"
#define CellID_MessageShopingTableviewCell @"MessageShopingTableviewCell"
#define TableViewHederViewidentifier @"MessagetableViewHeaderView"
#define TableViewFooterViewidentifier @"MessagetableViewFooterView"

@interface Message_Shoping_Tableview ()<UITableViewDelegate, UITableViewDataSource, MessagetableViewFooterViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation Message_Shoping_Tableview

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.separatorStyle = UITableViewCellAccessoryNone;
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = QFC_BackColor_Gray;
        [self registerNib:[UINib nibWithNibName:NSStringFromClass([Message_Shoping_Tableview_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MessageShopingTableviewCell];
        [self registerClass:[Message_tableView_HeaderView class] forHeaderFooterViewReuseIdentifier:TableViewHederViewidentifier];
         [self registerClass:[Message_tableView_FooterView class] forHeaderFooterViewReuseIdentifier:TableViewFooterViewidentifier];
        MJWeakSelf;
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakSelf.Page = 1;
            [weakSelf.dataArray removeAllObjects];
            [weakSelf LoadingDataSoure];
        }];
        self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            weakSelf.Page += 1;
            [weakSelf LoadingDataSoure];
        }];
    }
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
    
    return self.dataArray.count;
}
//返回一个分区里多少数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    Message_Shoping_Model *model = self.dataArray[section];
    return model.goods.count;
}
// 返回Cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Message_Shoping_Tableview_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MessageShopingTableviewCell];
    Message_Shoping_Model *model = self.dataArray[indexPath.section];
    [cell setDataSoureToCell:model.goods[indexPath.row]];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    Message_tableView_HeaderView *headerView = [[Message_tableView_HeaderView alloc] init];
    [headerView setDataSoureToCell:self.dataArray[section]];
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    Message_tableView_FooterView *footerView = [[Message_tableView_FooterView alloc] init];
    [footerView setDataSoureToCell:self.dataArray[section] style:self.index];
    footerView.delegate = self;
    return footerView;
}

#warning 测试商家测试
#pragma mark----UPdata
- (void)LoadingDataSoure {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:@"1" forKey:@"uid"];//商家1 家政 [[NSUserDefaults standardUserDefaults] objectForKey:User_Mid]
    [parm setObject:self.index ? @"2" : @"1" forKey:@"status"];
    [parm setObject:@"3" forKey:@"typeid"];//用户的类型：0普通 1 跑腿 2家政 3商家
    [parm setObject:@(self.Page) forKey:@"page"];
    [[HttpRequest sharedInstance] postWithURLString:URL_Informations_joinOrderList parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        [self endRefresh];
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            //获取list
            NSArray *list_Array = [responseObject objectForKey:@"list"];
            for (NSDictionary *dic in list_Array) {
                Message_Shoping_Model *model = [Message_Shoping_Model mj_objectWithKeyValues:dic];
                [self.dataArray addObject:model];
            }
            if (self.dataArray.count && self.Page == 1) {
                [self hidenFooterView:NO];
            }else {
                [self hidenFooterView:YES];
            }
            [self reloadData];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

#pragma mark----MessagetableViewFooterViewDelegate

- (void)MessagetableViewFooterViewButtonClick:(Message_Shoping_Model *)model index:(NSInteger)index {
    if ([model.merchant_errand intValue] == 1) {//配送+自送
        
    } else {//立即接单
        [self PostindexMerchantsMySildJoinOrder:model];
    }
}


#pragma mark----自取接单
/**
 index/merchants/MySildJoinOrder
 uid
 orderid
 自取接单
 */
- (void)PostindexMerchantsMySildJoinOrder:(Message_Shoping_Model *)model {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:model.Shoping_id forKey:@"orderid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_merchants_MySildJoinOrder parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showError:@"接单成功" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            [self beginFresh];
        }else {
            [MBProgressHUD py_showError:@"接单失败" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"操作失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

@end
