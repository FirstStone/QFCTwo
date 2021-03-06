//
//  Mine_CollectionViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/4/15.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_CollectionViewController.h"
#define CellID_SquareTextCell @"SquareTextCell"
#define CellID_SquareHTImageCell @"SquareHTImageCell"
#define CellID_SquareWDTextCell @"SquareWDTextCell"
#define CellID_SquareWDImageAndTextCell @"SquareWDImageAndTextCell"
#define CellID_SquareWDTextCell @"SquareWDTextCell"
@interface Mine_CollectionViewController ()<UITableViewDataSource, UITableViewDelegate, SquareTextCellDelegate, SquareHTImageCellDelegate, SquareWDTextCellDelegate, SquareWDImageAndTextCellDelegate>

@property (strong, nonatomic) IBOutlet Basic_TableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation Mine_CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Square_TextCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_SquareTextCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Square_HT_ImageCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_SquareHTImageCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Square_WD_Text_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_SquareWDTextCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Square_WD_ImageAndText_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_SquareWDImageAndTextCell];
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
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (IBAction)LiftButtonPOP:(id)sender {
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
    
    SquareRecommend_Model *model = self.dataArray[indexPath.row];

    if ([model.type intValue] == 1) {//1普通动态文字
        Square_TextCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareTextCell];
        cell.delegate = self;
        [cell setDataSoureToCell:model];
        return cell;
    }else if ([model.type intValue] == 2 ) {//2普通动态图文
        Square_HT_ImageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareHTImageCell];
        cell.delegate = self;
        [cell setDataSoureToCell:model];
        return cell;
        
    }else if ([model.type intValue] == 3 ) {//3回答文字
        Square_WD_Text_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareWDTextCell];
        cell.delegate = self;
        [cell setDataSoureToCell:model];
        return cell;
    }else if ([model.type intValue] == 4 ) {//4回答图文
        Square_WD_ImageAndText_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareWDImageAndTextCell];
        cell.delegate = self;
        [cell setDataSoureToCell:model];
        return cell;
    }else {// 5问题
        Square_WD_Text_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareWDTextCell];
        cell.delegate = self;
        [cell setDataSoureToCell:model];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.dataArray[indexPath.row] isMemberOfClass:[SquareRecommend_Model class]]) {
        SquareRecommend_Model *model = self.dataArray[indexPath.row];
        if ([model.status intValue] == 3) {//问答
            Square_QuestionsAndAnswersVC *QAVC = [[Square_QuestionsAndAnswersVC alloc] init];
            [QAVC setHidesBottomBarWhenPushed:YES];
            QAVC.item_id = model.SquareRecommend_ID;
            QAVC.uid = model.uid;
            [self.navigationController pushViewController:QAVC animated:YES];
        }else {
            Square_HT_Details_VC *detailsVC = [[Square_HT_Details_VC alloc] init];
            MJWeakSelf;
            detailsVC.backBlock = ^{
                [weakSelf.tableView beginFresh];
            };
            detailsVC.item_id = model.SquareRecommend_ID;
            [detailsVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:detailsVC animated:YES];
        }
    }
//    else {
//        if ([self.SquareRecommend_Array[indexPath.row] isMemberOfClass:[Square_info_Model class]]) {//头部第一个
//            Square_info_Model *model = self.SquareRecommend_Array[indexPath.row];
//            Square_QuestionsAndAnswersVC *QAVC = [[Square_QuestionsAndAnswersVC alloc] init];
//            [QAVC setHidesBottomBarWhenPushed:YES];
//            QAVC.item_id = model.info_id;
//            QAVC.uid = @"0";
//            [self.My_NAVC pushViewController:QAVC animated:YES];
//        }else if ([self.SquareRecommend_Array[indexPath.row] isMemberOfClass:[Square_address_Model class]]) {//地址
//            Square_address_Model *model = self.SquareRecommend_Array[indexPath.row];
//            Square_QuestionsAndAnswersVC *QAVC = [[Square_QuestionsAndAnswersVC alloc] init];
//            [QAVC setHidesBottomBarWhenPushed:YES];
//            QAVC.item_id = model.address_id;
//            QAVC.uid = model.uid;
//            [self.My_NAVC pushViewController:QAVC animated:YES];
//        }else if ([self.SquareRecommend_Array[indexPath.row] isMemberOfClass:[Square_WD_Model class]]) {//普通
//            Square_WD_Model *model = self.SquareRecommend_Array[indexPath.row];
//            Square_QuestionsAndAnswersVC *QAVC = [[Square_QuestionsAndAnswersVC alloc] init];
//            [QAVC setHidesBottomBarWhenPushed:YES];
//            QAVC.item_id = model.WD_id;
//            QAVC.uid = model.uid;
//            [self.My_NAVC pushViewController:QAVC animated:YES];
//        }
//    }
}


#pragma mark----UPdata

/**
 我的中心 我发布的动态列表
 URL : https://www.txkuaiyou.com/index/plazas/MyplzazHomepageList
 参数 :
 uid
 用户ID
 page
 分页
 type
 0全部 1话题2二手3租房4问答
 */
- (void)LoadingDataSoure {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:@(self.tableView.Page) forKey:@"page"];
    [parm setObject:@"0" forKey:@"type"];
    [[HttpRequest sharedInstance] postWithURLString:URL_Centres_userCollect parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        [self.tableView endRefresh];
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSArray *Array = [responseObject objectForKey:@"list"];
            for (NSDictionary *dic in Array) {
                SquareRecommend_Model *model = [SquareRecommend_Model mj_objectWithKeyValues:dic];
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


#pragma mark----SquareTextCellDelegate
- (void)SquareTextCellMoreButtonClick:(SquareRecommend_Model *)model QuestionsAndAnswersModel:(Square_QuestionsAndAnswers_List_Model *)ListModel Style:(NSInteger)index {
    UIAlertController *alertV = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"取消收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //成功返回Block
        if (model.SquareRecommend_ID) {
            [self setplazaCollectDataSoure:model.SquareRecommend_ID];
        }else {
            [self setplazaCollectDataSoure:ListModel.item_id];
        }
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertV addAction:okAction];
    [alertV addAction:cancelAction];
    
    [self presentViewController:alertV animated:YES completion:nil];
}

- (void)SquareTextCellIconViewClick:(NSString *)mid {
    Square_Prsonal_Details_VC *preVC  = [[Square_Prsonal_Details_VC alloc] init];
    preVC.backBlock = ^{
        [self.tableView beginFresh];
    };
    preVC.uid = mid;
    [preVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:preVC animated:YES];
}

#pragma mark----SquareHTImageCellDelegate
- (void)SquareHTImageCellMoreButtonClick:(SquareRecommend_Model *)model QuestionsAndAnswersModel:(Square_QuestionsAndAnswers_List_Model *)ListModel Style:(NSInteger)index {
    UIAlertController *alertV = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"取消收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //成功返回Block
        if (model.SquareRecommend_ID) {
            [self setplazaCollectDataSoure:model.SquareRecommend_ID];
        }else {
            [self setplazaCollectDataSoure:ListModel.item_id];
        }
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertV addAction:okAction];
    [alertV addAction:cancelAction];
    
    [self presentViewController:alertV animated:YES completion:nil];
}

- (void)iconViewClick:(NSString *)mid {
    Square_Prsonal_Details_VC *preVC  = [[Square_Prsonal_Details_VC alloc] init];
    preVC.backBlock = ^{
        [self.tableView beginFresh];
    };
    preVC.uid = mid;
    [preVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:preVC animated:YES];
}

#pragma mark----SquareWDTextCellDelegate
- (void)SquareWDTextCellMoreButtonClick:(SquareRecommend_Model *)model QuestionsAndAnswersModel:(Square_WD_Model *)WDModel Style:(NSInteger)index {
    UIAlertController *alertV = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"取消收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //成功返回Block
        if (model.SquareRecommend_ID) {
            [self setplazaCollectDataSoure:model.SquareRecommend_ID];
        }else {
            [self setplazaCollectDataSoure:WDModel.WD_id];
        }
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertV addAction:okAction];
    [alertV addAction:cancelAction];
    
    [self presentViewController:alertV animated:YES completion:nil];
}

- (void)SquareWDTextCellIconView:(NSString *)mid {
    Square_Prsonal_Details_VC *preVC  = [[Square_Prsonal_Details_VC alloc] init];
    preVC.backBlock = ^{
        [self.tableView beginFresh];
    };
    preVC.uid = mid;
    [preVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:preVC animated:YES];
}

#pragma mark----SquareWDImageAndTextCellDelegate
- (void)SquareWDImageAndTextCellMoreButtonClick:(SquareRecommend_Model *)model SquareWDModel:(Square_WD_Model *)ListModel Style:(NSInteger)index {
    UIAlertController *alertV = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"取消收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //成功返回Block
        if (model.SquareRecommend_ID) {
            [self setplazaCollectDataSoure:model.SquareRecommend_ID];
        }else {
            [self setplazaCollectDataSoure:ListModel.WD_id];
        }
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertV addAction:okAction];
    [alertV addAction:cancelAction];
    
    [self presentViewController:alertV animated:YES completion:nil];
}

- (void)SquareWDImageAndTextCellIconimage:(NSString *)mid {
    Square_Prsonal_Details_VC *preVC  = [[Square_Prsonal_Details_VC alloc] init];
    preVC.backBlock = ^{
        [self.tableView beginFresh];
    };
    preVC.uid = mid;
    [preVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:preVC animated:YES];
}

- (void)setplazaCollectDataSoure:(NSString *)modelID {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:modelID forKey:@"id"];
    [[HttpRequest sharedInstance] postWithURLString:URL_Plazas_plazaCollect parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showError:@"操作成功" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            [self.tableView beginFresh];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:[NSString stringWithFormat:@"操作失败(d%)", error.code] toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

@end
