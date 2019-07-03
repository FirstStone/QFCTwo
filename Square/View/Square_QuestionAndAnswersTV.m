//
//  Square_QuestionAndAnswersTV.m
//  QFC
//
//  Created by tiaoxin on 2019/4/15.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Square_QuestionAndAnswersTV.h"

#define CellID_SquareHTImageCell @"SquareHTImageCell"
#define CellID_SquareTextCell @"SquareTextCell"

@interface Square_QuestionAndAnswersTV ()<UITableViewDelegate, UITableViewDataSource, SquareHTImageCellDelegate, SquareTextCellDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation Square_QuestionAndAnswersTV

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSelectionStyleNone;
        [self registerNib:[UINib nibWithNibName:NSStringFromClass([Square_HT_ImageCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_SquareHTImageCell];
        [self registerNib:[UINib nibWithNibName:NSStringFromClass([Square_TextCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_SquareTextCell];
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
    
    return 1;
}
//返回一个分区里多少数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
// 返回Cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XNLog(@"===========================%ld", (long)self.index);
    if (self.index == 0) {//默认
        Square_QuestionsAndAnswers_List_Model *model = self.dataArray[indexPath.row];
        if ([model.status intValue] == 1) {//图，文字
            Square_HT_ImageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareHTImageCell];
            [cell setSquareQuestionsAndAnswersListModelToCell:self.dataArray[indexPath.row]];
            cell.delegate = self;
            return cell;
        }else {
            Square_TextCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareTextCell];
            [cell setSquareQuestionsAndAnswersListModelToCell:self.dataArray[indexPath.row]];
            cell.delegate = self;
            return cell;
        }
    }else {//置顶
        Square_QuestionsAndAnswers_List_Model *model = self.dataArray[indexPath.row];
        if ([model.status intValue] == 1) {//图，文字
            Square_HT_ImageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareHTImageCell];
            [cell setSquareQuestionsAndAnswersListModelToCell:self.dataArray[indexPath.row]];
            cell.delegate = self;
            return cell;
        }else {
            Square_TextCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareTextCell];
            [cell setSquareQuestionsAndAnswersListModelToCell:self.dataArray[indexPath.row]];
            cell.delegate = self;
            return cell;
        }
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        Square_HT_Details_VC *detailsVC = [[Square_HT_Details_VC alloc] init];
    detailsVC.item_id = [self.dataArray[indexPath.row] item_id];
    [detailsVC setHidesBottomBarWhenPushed:YES];
        [self.My_NAVC pushViewController:detailsVC animated:YES];
}

#pragma mark----SquareTextCellDelegate
- (void)SquareTextCellIconViewClick:(NSString *)mid {
    Square_Prsonal_Details_VC *preVC  = [[Square_Prsonal_Details_VC alloc] init];
    preVC.backBlock = ^{
        [self beginFresh];
    };
    preVC.uid = mid;
    [preVC setHidesBottomBarWhenPushed:YES];
    [self.My_NAVC pushViewController:preVC animated:YES];
}

- (void)SquareTextCellMoreButtonClick:(SquareRecommend_Model *)model QuestionsAndAnswersModel:(Square_QuestionsAndAnswers_List_Model *)ListModel Style:(NSInteger)index {
    UIAlertController *alertV = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *oneAction = [UIAlertAction actionWithTitle:@"屏蔽此条动态" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //成功返回Block
        if (index == 1) {
            [self PostindexPlazasShieldOne:model.SquareRecommend_ID pid:model.uid];
        } else {
            [self PostindexPlazasShieldOne:ListModel.item_id pid:ListModel.uid];
        }
    }];
    UIAlertAction *TowAction = [UIAlertAction actionWithTitle:@"屏蔽他的动态" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //成功返回Block
        if (index == 1) {
            [self PostindexPlazasBlock:model.uid];
        } else {
            [self PostindexPlazasBlock:ListModel.uid];
        }
    }];
    UIAlertAction *ThreeAction = [UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        Square_Complaint_ViewController *complaintVC = [[Square_Complaint_ViewController alloc] init];
        [complaintVC setHidesBottomBarWhenPushed:YES];
        [self.My_NAVC pushViewController:complaintVC animated:YES];
        //成功返回Block
    }];
    [alertV addAction:cancelAction];
    [alertV addAction:oneAction];
    [alertV addAction:TowAction];
    [alertV addAction:ThreeAction];
    
    [self.My_NAVC presentViewController:alertV animated:YES completion:nil];
}

#pragma mark----SquareDefaultCellDelegate
- (void)iconViewClick:(NSString *)mid {
    Square_Prsonal_Details_VC *preVC  = [[Square_Prsonal_Details_VC alloc] init];
    preVC.backBlock = ^{
        [self beginFresh];
    };
    preVC.uid = mid;
    [preVC setHidesBottomBarWhenPushed:YES];
    [self.My_NAVC pushViewController:preVC animated:YES];
}

#pragma mark----SquareHTImageCellDelegate
- (void)SquareHTImageCellButtonClick:(NSInteger)index SquareQuestionsAndAnswersListModel:(Square_QuestionsAndAnswers_List_Model *)model {
    if (index == 1) {//顶
        [self setPraiseToBacker:model.item_id];
    }
}

- (void)SquareHTImageCellMoreButtonClick:(SquareRecommend_Model *)model QuestionsAndAnswersModel:(Square_QuestionsAndAnswers_List_Model *)ListModel Style:(NSInteger)index {
    UIAlertController *alertV = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *oneAction = [UIAlertAction actionWithTitle:@"屏蔽此条动态" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //成功返回Block
        if (index == 1) {
            [self PostindexPlazasShieldOne:model.SquareRecommend_ID pid:model.uid];
        } else {
            [self PostindexPlazasShieldOne:ListModel.item_id pid:ListModel.uid];
        }
    }];
    UIAlertAction *TowAction = [UIAlertAction actionWithTitle:@"屏蔽他的动态" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //成功返回Block
        if (index == 1) {
            [self PostindexPlazasBlock:model.uid];
        } else {
            [self PostindexPlazasBlock:ListModel.uid];
        }
    }];
    UIAlertAction *ThreeAction = [UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        Square_Complaint_ViewController *complaintVC = [[Square_Complaint_ViewController alloc] init];
        [complaintVC setHidesBottomBarWhenPushed:YES];
        [self.My_NAVC pushViewController:complaintVC animated:YES];
        //成功返回Block
    }];
    [alertV addAction:cancelAction];
    [alertV addAction:oneAction];
    [alertV addAction:TowAction];
    [alertV addAction:ThreeAction];
    
    [self.My_NAVC presentViewController:alertV animated:YES completion:nil];
}

#pragma mark----UPdata
/**
 社区广场 获取问答动态详情 获取回答的列表
 URL : https://www.txkuaiyou.com/index/Plazas/answerList
 参数 :
 id
 问题ID
 uid
 用户ID
 page
 分页默认 1
 type
 0表示时间排序1表示点赞排序
 */
- (void)LoadingDataSoure {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:self.item_ID forKey:@"id"];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
        [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    }else {
        [parm setObject:@"0" forKey:@"uid"];
    }
    [parm setObject:@(self.Page) forKey:@"page"];
    [parm setObject:@(self.index) forKey:@"type"];
    [[HttpRequest sharedInstance] postWithURLString:URL_Plazas_answerList parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        [self endRefresh];
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSArray *DataArray = [responseObject objectForKey:@"list"];
            for (NSDictionary *dic in DataArray) {
                Square_QuestionsAndAnswers_List_Model *model = [Square_QuestionsAndAnswers_List_Model mj_objectWithKeyValues:dic];
                [self.dataArray addObject:model];
            }
            if (!DataArray.count) {
                [self hidenFooterView:NO];
            }else if (!self.dataArray.count){
                [self hidenFooterView:YES];
            }
            [self reloadData];
        }else {
            [MBProgressHUD py_showError:@"数据加载失败" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
    } failure:^(NSError * _Nonnull error) {
        [self endRefresh];
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

- (void)setPraiseToBacker:(NSString *)state {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:User_Mid]) {
        [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    }else {
        [parm setObject:@"0" forKey:@"uid"];
    }
    [parm setObject:state forKey:@"plazaid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_Plazas_plazaLike parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showError:@"操作成功" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            [self LoadingDataSoure];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"操作失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}


- (void)PostindexPlazasShieldOne:(NSString *)plazaid pid:(NSString *)pid{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue] == [pid intValue]) {
        [MBProgressHUD py_showError:@"不能屏蔽自己的动态哦" toView:nil];
        return;
    }
    /**
     index/plazas/shieldOne
     uid
     plazaid
     屏蔽单条
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:plazaid forKey:@"plazaid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_plazas_shieldOne parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [self beginFresh];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"操作失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

- (void)PostindexPlazasBlock:(NSString *)pid {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue] == [pid intValue]) {
        [MBProgressHUD py_showError:@"不能屏蔽自己哦" toView:nil];
        return;
    }
    /**
     index/plazas/block
     uid
     pid
     拉黑  屏蔽此人
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:pid forKey:@"pid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_plazas_block parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [self beginFresh];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"操作失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

@end
