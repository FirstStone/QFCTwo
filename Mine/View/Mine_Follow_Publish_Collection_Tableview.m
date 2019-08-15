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
@interface Mine_Follow_Publish_Collection_Tableview ()<UITableViewDelegate, UITableViewDataSource, MineFollowViewTableViewCellDelegate>

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
    cell.Style = self.index;
    [cell setModelToCell:self.dataArray[indexPath.row]];
    cell.delegate = self;
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     Mine_Follow_Model *model = self.dataArray[indexPath.row];
    if (self.index) {
        Home_ShopStore_ViewController *ShopStoreVC = [[Home_ShopStore_ViewController alloc] init];
        ShopStoreVC.Shopid = model.Follow_id;
        [ShopStoreVC setHidesBottomBarWhenPushed:YES];
        [self.My_NAVC pushViewController:ShopStoreVC animated:YES];
    } else {
        Square_Prsonal_Details_VC *preVC  = [[Square_Prsonal_Details_VC alloc] init];
        preVC.backBlock = ^{
            [self beginFresh];
        };
        preVC.uid = model.Follow_id;
        [preVC setHidesBottomBarWhenPushed:YES];
        [self.My_NAVC pushViewController:preVC animated:YES];
    }
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

#pragma mark----MineFollowViewTableViewCellDelegate
- (void)MineFollowViewTableViewCellButtonClick:(Mine_Follow_Model *)model {
    
    UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"提示" message:@"要取消关注吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cacen = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //成功返回Block
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (self.index) {
            [self POSTIndexMerchantsAttention:model.Follow_id];
        }else {
            [self setAttentionDataSoure:model.Follow_id type:@"1"];
        }
    }];
    [alertV addAction:cacen];
    [alertV addAction:okAction];
    
    [self.My_NAVC presentViewController:alertV animated:YES completion:nil];
}

/**关注*/
/**type=1关注  2取消关注*/
- (void)setAttentionDataSoure:(NSString *)modelID type:(NSString *)type {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:modelID forKey:@"pid"];
//    [parm setObject:type forKey:@"type"];
    [[HttpRequest sharedInstance] postWithURLString:URL_Users_attention parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showError:@"操作成功" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            [self beginFresh];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"操作失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

- (void)POSTIndexMerchantsAttention:(NSString *)merchantid {
    /**关注店铺
     index/merchants/attention
     merchantid
     uid
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:merchantid forKey:@"merchantid"];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_merchants_attention parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showError:@"操作成功" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            [self beginFresh];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"操作失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

@end
