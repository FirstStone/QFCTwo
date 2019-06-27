//
//  Mine_SetUP_Privacy_Blacklist_VC.m
//  QFC
//
//  Created by tiaoxin on 2019/4/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_SetUP_Privacy_Blacklist_VC.h"
#define CellID_MineSetUPPrivacyBlacklistCell @"MineSetUPPrivacyBlacklistCell"
@interface Mine_SetUP_Privacy_Blacklist_VC ()<UITableViewDelegate, UITableViewDataSource, MineSetUPPrivacyBlacklistCellDelegate>

@property (strong, nonatomic) IBOutlet Basic_TableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation Mine_SetUP_Privacy_Blacklist_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_SetUP_Privacy_Blacklist_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MineSetUPPrivacyBlacklistCell];
    MJWeakSelf;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.tableView.Page = 1;
        [weakSelf.dataArray removeAllObjects];
        [weakSelf LoadingDataSoure];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.tableView.Page += 1;
        [weakSelf LoadingDataSoure];
    }];
    [self.tableView beginFresh];
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (IBAction)LiftButtonPOP:(id)sender {
    [self.navigationController  popViewControllerAnimated:YES];
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
    
    Mine_SetUP_Privacy_Blacklist_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineSetUPPrivacyBlacklistCell];
    cell.delegate = self;
    [cell setDataSoureToVell:self.dataArray[indexPath.row]];
    return cell;
}


#pragma mark----UPdata
- (void)LoadingDataSoure {
    /**
     index/plazas/blockList
     uid
     page
     拉黑列表
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:@(self.tableView.Page) forKey:@"page"];
    [[HttpRequest sharedInstance] postWithURLString:URL_plazas_blockList parameters:parm success:^(NSDictionary * _Nonnull responseObject) {//
        [self.tableView endRefresh];
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSArray *DataArray = [responseObject objectForKey:@"list"];
            for (NSDictionary *dic in DataArray) {
                Mine_BlackUser_Model *model = [Mine_BlackUser_Model mj_objectWithKeyValues:dic];
                [self.dataArray addObject:model];
            }
            if (!DataArray.count) {
                [self.tableView hidenFooterView:NO];
            }else if (!self.dataArray.count){
                [self.tableView hidenFooterView:YES];
            }
            [self.tableView reloadData];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"获取失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}


#pragma mark----MineSetUPPrivacyBlacklistCellDelegate

- (void)MineSetUPPrivacyBlacklistCellButtonClick:(Mine_BlackUser_Model *)model {
    [self PostIndexPlazasDelBlock:model.userID];
}

- (void)PostIndexPlazasDelBlock:(NSString *)pid {
    /**
     index/plazas/delBlock
     uid
     pid
     取消拉黑
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:pid forKey:@"pid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_plazas_delBlock parameters:parm success:^(NSDictionary * _Nonnull responseObject) {//
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [self.tableView beginFresh];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"操作失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
    
}

@end
