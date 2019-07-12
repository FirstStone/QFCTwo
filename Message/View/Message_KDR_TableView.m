//
//  Message_KDR_TableView.m
//  QFC
//
//  Created by tiaoxin on 2019/7/12.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Message_KDR_TableView.h"
#define Cell_HomeKDROrderCell @"HomeKDROrderCell"
@interface Message_KDR_TableView ()<UITableViewDelegate, UITableViewDataSource>
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
    return 2;//self.dataArray.count;
}
// 返回Cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    if (self.index == 1) {//待完成
    //        Message_RunErrands_Tableview_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MessageRunErrandsTableviewCell];
    //        return cell;
    //    }else {//待接单
    Home_KDROrder_Cell *cell = [tableView dequeueReusableCellWithIdentifier:Cell_HomeKDROrderCell];
//    cell.delegate = self;
//    [cell setDataSoureToCell:self.dataArray[indexPath.row] index:self.index];
    return cell;
    //    }
}

- (void)LoadingDataSoure {
    [self endRefresh];
}


@end
