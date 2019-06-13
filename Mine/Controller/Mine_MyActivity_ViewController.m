//
//  Mine_MyActivity_ViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/6/6.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_MyActivity_ViewController.h"
#define CellID_MineMyActivityCell @"MineMyActivityCell"

@interface Mine_MyActivity_ViewController ()<UITableViewDelegate, UITableViewDataSource, MineMyActivityFooterViewDelegate>

@property (strong, nonatomic) IBOutlet Basic_TableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation Mine_MyActivity_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_MyActivity_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MineMyActivityCell];
    
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

- (IBAction)LiftButtonPOP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)AddButtonClick:(id)sender {
    
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    Mine_MyActivity_Model *model = self.dataArray[section];
    return model.goodslist.count;
}
// 返回Cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Mine_MyActivity_Model *model = self.dataArray[indexPath.section];
    Mine_MyActivity_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyActivityCell];
    [cell setModelToCell:model.goodslist[indexPath.row]];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    Mine_MyActivity_Model *model = self.dataArray[section];
    Mine_MyActivity_HeaderView *headerView = [[Mine_MyActivity_HeaderView alloc] init];
    headerView.Title_Label.text = model.activity_name;
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    Mine_MyActivity_Model *model = self.dataArray[section];
    Mine_MyActivity_FooterView *FooterView = [[Mine_MyActivity_FooterView alloc] init];
    FooterView.Text_Label.text = [NSString stringWithFormat:@"消费方式：%@\n适用范围：%@\n活动时间：%@", [model.cate intValue] == 1 ? @"进店消费" : @"线上消费", [model.type intValue] == 1 ? @"全店可用" : @"指定商品可用" , [NSString stringWithFormat:@"%@-%@%@", model.begintime, model.endtime, [model.status intValue] == 1 ? @"(正在进行中...)" : ([model.status intValue] == 2 ? @"(领取完毕...)" : @"活动结束...")]];
    FooterView.Mymodel = model;
    FooterView.delegate = self;
    return FooterView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 110.0f;
}

#pragma mark----UPdata
 /**
 的活动列表
 URL : https://www.txkuaiyou.com/index/activitys/activityLists
 参数 :
 page
 分页
 uid
 用户ID
 */

- (void)LoadingDataSoure {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:@(self.tableView.Page) forKey:@"page"];
    [[HttpRequest sharedInstance] postWithURLString:URL_activitys_activityLists parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        [self.tableView endRefresh];
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSArray *Array = [responseObject objectForKey:@"list"];
            for (NSDictionary *dic in Array) {
                Mine_MyActivity_Model *model = [Mine_MyActivity_Model mj_objectWithKeyValues:dic];
                [self.dataArray addObject:model];
            }
            if (!Array.count) {
                [self.tableView hidenFooterView:NO];
            }
        }
        if (!self.dataArray.count && self.tableView.Page == 1) {
            [self.tableView hidenFooterView:YES];
        }
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

#pragma mark----MineMyActivityFooterViewDelegate
- (void)MineMyActivityFooterViewDelectButtonClick:(Mine_MyActivity_Model *)model {
    [self POSTActivitysActivityDel:model.Activity_id];
}

/**
 店铺发布的活动 删除
 URL : https://www.txkuaiyou.com/index/activitys/activityDel
 参数 :
 activityid
 字符串 1,2,3
 */
- (void)POSTActivitysActivityDel:(NSString *)activityid {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:activityid forKey:@"activityid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_activitys_activityDel parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showError:@"删除成功" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            [self.tableView beginFresh];
        }else {
            [MBProgressHUD py_showError:@"操作失败" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
      
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"请求错误" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

@end
