//
//  Message_CommentViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/4/16.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Message_CommentViewController.h"
#define CellID_MessageApexCell @"MessageApexCell"

@interface Message_CommentViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet Basic_TableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation Message_CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Message_ApexCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MessageApexCell];
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
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView beginFresh];
}

- (IBAction)LiftButtonPOP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
    
    Message_ApexCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MessageApexCell];
    [cell.RightButton setTitle:@"回复" forState:UIControlStateNormal];
    [cell setCommentDataSoureToCell:self.dataArray[indexPath.row]];
    return cell;
}

#pragma mark----UPdata
/**
 消息页面 获取评论列表
 URL : https://www.txkuaiyou.com/index/Informations/discussList
 参数 :
 uid
 用户ID
 page
 分页
 */

- (void)LoadingDataSoure {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:@(self.tableView.Page) forKey:@"page"];
    [[HttpRequest sharedInstance] postWithURLString:URL_Informations_discussList parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        [self.tableView endRefresh];
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            //获取list
            NSArray *list_Array = [responseObject objectForKey:@"list"];
            for (NSDictionary *dic in list_Array) {
                Message_Comment_Model *model = [Message_Comment_Model mj_objectWithKeyValues:dic];
                [self.dataArray addObject:model];
            }
            if (!list_Array.count) {
                [self.tableView hidenFooterView:NO];
            }else if (!self.dataArray.count){
                [self.tableView hidenFooterView:YES];
            }
            [self.tableView reloadData];
        }
    } failure:^(NSError * _Nonnull error) {
        [self.tableView endRefresh];
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}



@end
