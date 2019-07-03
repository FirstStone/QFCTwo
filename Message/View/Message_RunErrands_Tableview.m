//
//  Message_RunErrands_Tableview.m
//  QFC
//
//  Created by tiaoxin on 2019/4/16.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Message_RunErrands_Tableview.h"
#define CellID_MessageRunErrandsTableviewCell @"MessageRunErrandsTableviewCell"
#define CellID_MessageRunErrandsTableViewNoOrderCell @"MessageRunErrandsTableViewNoOrderCell"
@interface Message_RunErrands_Tableview ()<UITableViewDelegate, UITableViewDataSource, MessageRunErrandsTableViewNoOrderCellDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation Message_RunErrands_Tableview

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.separatorStyle = UITableViewCellAccessoryNone;
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = QFC_BackColor_Gray;
        [self registerNib:[UINib nibWithNibName:NSStringFromClass([Message_RunErrands_Tableview_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MessageRunErrandsTableviewCell];
          [self registerNib:[UINib nibWithNibName:NSStringFromClass([Message_RunErrands_TableView_NoOrderCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MessageRunErrandsTableViewNoOrderCell];
    }
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
//    if (self.index == 1) {//待完成
//        Message_RunErrands_Tableview_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MessageRunErrandsTableviewCell];
//        return cell;
//    }else {//待接单
    Message_RunErrands_TableView_NoOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MessageRunErrandsTableViewNoOrderCell];
    cell.delegate = self;
    [cell setDataSoureToCell:self.dataArray[indexPath.row] index:self.index];
    return cell;
//    }
}

#pragma mark----MessageRunErrandsTableViewNoOrderCellDelegate
- (void)MessageRunErrandsTableViewNoOrderCellButtonClick:(Message_RunErrands_Model *)model {
    [self PostIndexErrandOrderReceiving:model];
}

#warning 测试跑腿测试
#pragma mark----UPdata
- (void)LoadingDataSoure {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:@"2" forKey:@"uid"];//[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid]
    [parm setObject:self.index ? @"2" : @"1" forKey:@"status"];
    [parm setObject:@"1" forKey:@"typeid"];//用户的类型：0普通 1 跑腿 2家政 3商家
    [parm setObject:@(self.Page) forKey:@"page"];
    [[HttpRequest sharedInstance] postWithURLString:URL_Informations_joinOrderList parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        [self endRefresh];
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            //获取list
            NSArray *list_Array = [responseObject objectForKey:@"list"];
            for (NSDictionary *dic in list_Array) {
                Message_RunErrands_Model *model = [Message_RunErrands_Model mj_objectWithKeyValues:dic];
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
        [self endRefresh];
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

/**
 index/errand/orderReceiving
 uid
 orderid
 跑腿接单
 */
- (void)PostIndexErrandOrderReceiving:(Message_RunErrands_Model *)model {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:model.RunErrands_id forKey:@"orderid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_errand_orderReceiving parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showError:@"抢单成功" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            [self beginFresh];
        }else {
            [MBProgressHUD py_showError:@"操作失败" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"操作失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}



@end
