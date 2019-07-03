//
//  Mine_Follow_Publish_Collection_Tableview.m
//  QFC
//
//  Created by tiaoxin on 2019/4/17.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_Follow_Publish_Collection_Tableview.h"
#define CellID_MineFollowViewTableViewCell @"MineFollowViewTableViewCell"
#define CellID_SquareTextCell @"SquareTextCell"
#define CellID_SquareHTImageCell @"SquareHTImageCell"
@interface Mine_Follow_Publish_Collection_Tableview ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation Mine_Follow_Publish_Collection_Tableview

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TabelViewBeginDataSoure) name:@"TabelViewBeginDataSoure" object:nil];
        self.separatorStyle = UITableViewCellAccessoryNone;
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = QFC_BackColor_Gray;
        [self registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_FollowView_TableView_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MineFollowViewTableViewCell];
        [self registerNib:[UINib nibWithNibName:NSStringFromClass([Square_TextCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_SquareTextCell];
        [self registerNib:[UINib nibWithNibName:NSStringFromClass([Square_HT_ImageCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_SquareHTImageCell];
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

- (void)TabelViewBeginDataSoure {
    [self beginFresh];
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
//    if (self.MineStyle == MineTableViewFollow) {//关注
    Mine_FollowView_TableView_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineFollowViewTableViewCell];
    [cell setModelToCell:self.dataArray[indexPath.row]];
    return cell;
    /*} else if (self.MineStyle == MineTableViewPublish){//发布
        if (indexPath.row == 0) {
            Square_TextCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareTextCell];
            return cell;
        }else {
            Square_HT_ImageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareHTImageCell];
            return cell;
        }
    } else {//收藏
        if (indexPath.row == 0) {
            Square_TextCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareTextCell];
            return cell;
        }else {
            Square_HT_ImageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareHTImageCell];
            return cell;
        }
    }*/
}


#pragma mark----UPdata
/**
 URL : https://www.txkuaiyou.com/index/Centres/attentionList
 参数 :
 uid 用户ID
 page 分页 默认1
 type 1关注普通2店铺关注
 */
- (void)LoadingDataSoure {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:@(self.Page) forKey:@"page"];
    [parm setObject:(self.index ? @"2" : @"1" ) forKey:@"type"];
    [[HttpRequest sharedInstance] postWithURLString:URL_Centres_attentionList parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        [self endRefresh];
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSArray *Array = [responseObject objectForKey:@"list"];
            for (NSDictionary *dic in Array) {
                Mine_Follow_Model *model = [Mine_Follow_Model  mj_objectWithKeyValues:dic];
                [self.dataArray addObject:model];
            }
            if (!Array.count) {
                [self hidenFooterView:NO];
            }
        }
        if (!self.dataArray.count && self.Page == 1) {
            [self hidenFooterView:YES];
        }
        [self reloadData];
    } failure:^(NSError * _Nonnull error) {
        [self endRefresh];
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}




@end
