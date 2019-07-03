//
//  Mine_MyCard_ViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/6/6.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_MyCard_ViewController.h"
#define CellID_MineMyCardViewCell @"MineMyCardViewCell"
@interface Mine_MyCard_ViewController ()<UITableViewDelegate, UITableViewDataSource, MineMyCardViewCellDelegate>

@property (strong, nonatomic) IBOutlet Basic_TableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation Mine_MyCard_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_MyCardView_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MineMyCardViewCell];
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
    H5_MyCard_ViewController *cardVC = [[H5_MyCard_ViewController alloc] init];
    [cardVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:cardVC animated:YES];
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

    Mine_MyCardView_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyCardViewCell];
    cell.delegate = self;
    [cell setModelToCell:self.dataArray[indexPath.row]];
    return cell;
}

#pragma mark----UPdata
/**
 店铺发布的优惠卷列表
 URL : https://www.txkuaiyou.com/index/discounts/discountlist
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
    [[HttpRequest sharedInstance] postWithURLString:URL_discounts_discountlist parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        [self.tableView endRefresh];
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSArray *Array = [responseObject objectForKey:@"list"];
            for (NSDictionary *dic in Array) {
                Mine_MyCard_Model *model = [Mine_MyCard_Model mj_objectWithKeyValues:dic];
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
        [self.tableView endRefresh];
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

#pragma mark----MineMyCardViewCellDelegate

- (void)MineMyCardViewCellButtonClick:(Mine_MyCard_Model *)model {
    [self POSTDiscountsDiscountDel:model.MyCard_id];
}

/**
 店铺发布的优惠卷 删除
 URL : https://www.txkuaiyou.com/index/discounts/discountDel
 参数 :
 discountid
 优惠卷ID字符串 1,2,3
 */
- (void)POSTDiscountsDiscountDel:(NSString *)modeleid {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:modeleid forKey:@"discountid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_discounts_discountDel parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
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
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

@end
