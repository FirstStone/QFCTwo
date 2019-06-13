//
//  Message_FansViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/4/16.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Message_FansViewController.h"
#define CellID_MessageFansCell @"MessageFansCell"
@interface Message_FansViewController ()<UITableViewDelegate, UITableViewDataSource, MessageFansCellDelegate>
@property (strong, nonatomic) IBOutlet Basic_TableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation Message_FansViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Message_Fans_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MessageFansCell];
    MJWeakSelf;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.tableView.Page = 1;
        [weakSelf.dataArray removeAllObjects];
        [weakSelf LoadingDataSoure];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.tableView.Page += 1;
        [weakSelf LoadingDataSoure];
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
- (IBAction)LiftButtonClick:(id)sender {
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
    Message_Fans_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MessageFansCell];
    [cell setDataSoureToCell:self.dataArray[indexPath.row]];
    cell.delegate = self;
    return cell;
}

#pragma mark----UPdata
/**
 粉丝列表
 URL : https://www.txkuaiyou.com/index/Users/fansList
 参数 :
 uid
 用户ID
 page
 分页默认1
 */
- (void)LoadingDataSoure {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:@"1" forKey:@"page"];
    [[HttpRequest sharedInstance] postWithURLString:URL_Users_fansList parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        [self.tableView endRefresh];
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSArray *DataArray = [responseObject objectForKey:@"list"];
            for (NSDictionary *dic in DataArray) {
                Message_FansList_Model *model = [Message_FansList_Model mj_objectWithKeyValues:dic];
                [self.dataArray addObject:model];
            }
            if (self.dataArray.count && self.tableView.Page == 1) {
                [self.tableView hidenFooterView:NO];
            }else {
                [self.tableView hidenFooterView:YES];
            }
        }else {
            [self.tableView hidenFooterView:YES];
        }
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

#pragma mark----MessageFansCellDelegate
- (void)MessageFansCellButtonClick:(Message_FansList_Model *)model {
    if ([model.status intValue]) {
        [self setAttentionDataSoure:model.Fans_id type:@"2"];
    }else {
        [self setAttentionDataSoure:model.Fans_id type:@"1"];
    }
}

/**关注*/
/**type=1关注  2取消关注*/
- (void)setAttentionDataSoure:(NSString *)modelID type:(NSString *)type {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:modelID forKey:@"pid"];
    [parm setObject:type forKey:@"type"];
    [[HttpRequest sharedInstance] postWithURLString:URL_Users_attention parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showError:@"操作成功" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            [self.dataArray removeAllObjects];
            [self LoadingDataSoure];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"操作失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

@end
