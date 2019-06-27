//
//  Square_HT_Details_VC.m
//  QFC
//
//  Created by tiaoxin on 2019/4/10.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Square_HT_Details_VC.h"
#define CellID_SquareHTDetailsFirstCell @"SquareHTDetailsFirstCell"
#define CellID_SquareHTDetailsCommentCell @"SquareHTDetailsCommentCell"
@interface Square_HT_Details_VC ()<UITableViewDelegate, UITableViewDataSource, SquareHTDetailsFirstCellDelegate, SquareHTDetailsCommentCellDelegate>
@property (weak, nonatomic) IBOutlet Basic_TableView *tableView;

@property (strong, nonatomic) IBOutlet UIButton *AddSureButton;

@property (strong, nonatomic) IBOutlet UITextField *Text_Field;



@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) Square_Details_Model *my_Model;

@property (nonatomic, assign) BOOL AddButtonState;

@property (nonatomic, strong) NSMutableDictionary *AdddiscussReplyParm;
@end

@implementation Square_HT_Details_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.AddButtonState = YES;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Square_HT_Details_First_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_SquareHTDetailsFirstCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Square_HT_Details_Comment_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_SquareHTDetailsCommentCell];
    MJWeakSelf;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.tableView.Page = 1;
        [weakSelf.dataArray removeAllObjects];
        [weakSelf LoadingDataSoure];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.tableView.Page += 1;
        [weakSelf getDataSoureList];
    }];
}
- (IBAction)LeftItemClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)RightbuttonClick:(id)sender {
    MJWeakSelf;
    UIAlertController *alertV = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *oneAction = [UIAlertAction actionWithTitle:@"屏蔽此条动态" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //成功返回Block
        [weakSelf PostindexPlazasShieldOne:weakSelf.my_Model.Details_id pid:weakSelf.my_Model.uid];
    }];
    UIAlertAction *TowAction = [UIAlertAction actionWithTitle:@"屏蔽他的动态" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //成功返回Block
        [weakSelf PostindexPlazasBlock:weakSelf.my_Model.uid];
    }];
    UIAlertAction *ThreeAction = [UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        Square_Complaint_ViewController *complaintVC = [[Square_Complaint_ViewController alloc] init];
        [complaintVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:complaintVC animated:YES];
        //成功返回Block
    }];
    [alertV addAction:cancelAction];
    [alertV addAction:oneAction];
    [alertV addAction:TowAction];
    [alertV addAction:ThreeAction];
    
    [self presentViewController:alertV animated:YES completion:nil];
}


- (NSMutableDictionary *)AdddiscussReplyParm {
    if (!_AdddiscussReplyParm) {
        _AdddiscussReplyParm = [[NSMutableDictionary alloc] init];
    }
    return _AdddiscussReplyParm;
}

/**发布信息*/
- (IBAction)AddButtonClick:(id)sender {
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
        Basic_NavigationController *LoginVC = [[Basic_NavigationController alloc] initWithRootViewController:[[Login_PhoneCodeViewControlloer alloc] init]];
        [self.navigationController presentViewController:LoginVC animated:YES completion:Nil];
    }else if (!self.Text_Field.text.length) {
        [MBProgressHUD py_showError:@"请输入评论内容" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
        return;
    }else {
        if (self.AddButtonState) {
            
            [self AddplazaDiscuss];
        }else {
            [self AdddiscussReply];
        }
    }
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView beginFresh];
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
    if ([self.dataArray[indexPath.row] isMemberOfClass:[Square_Details_Model class]]) {
        Square_Details_Model *model = self.dataArray[indexPath.row];
        Square_HT_Details_First_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareHTDetailsFirstCell];
        cell.delegate = self;
        if (self.my_Model.imgurl.count) {
            cell.Image_View.hidden = NO;
        }else {
            cell.Image_View.hidden = YES;
        }
        [cell setModelToCell:model];
        return cell;
    }else {
        Square_detailsDiscuss_Model *model = self.dataArray[indexPath.row];
        Square_HT_Details_Comment_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareHTDetailsCommentCell];
        cell.delegate = self;
        [cell setDataSoureToCell:model];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        self.AddButtonState = YES;
        self.Text_Field.placeholder = @"请输入评论内容...";
    }else {
        self.AddButtonState = NO;
        Square_detailsDiscuss_Model *model = self.dataArray[indexPath.row];
        self.Text_Field.placeholder = [NSString stringWithFormat:@"回复%@", model.nickname];
        [self.AdddiscussReplyParm setObject:model.uid forKey:@"pid"];
        [self.AdddiscussReplyParm setObject:model.detailsDiscuss_id forKey:@"discussid"];
    }
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

#pragma mark----UPData

/**
 社区广场 动态评论回复
 URL : https://www.txkuaiyou.com/index/Plazas/discussReply
 参数 :
 id
 动态ID
 uid
 用户ID
 content
 内容
 pid
 评论ID
 */
- (void)AdddiscussReply {
    [self.AdddiscussReplyParm setObject:self.item_id forKey:@"id"];
    [self.AdddiscussReplyParm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [self.AdddiscussReplyParm setObject:self.Text_Field.text forKey:@"content"];
//      [self.AdddiscussReplyParm setObject:self.detailsDiscuss_id.text forKey:@"discussid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_Plazas_discussReply parameters:self.AdddiscussReplyParm success:^(NSDictionary * _Nonnull responseObject) {
        
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showError:@"评论成功" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            self.Text_Field.text = @"";
            [self.tableView beginFresh];
        }else {
            [MBProgressHUD py_showError:@"评论失败" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"评论失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}


/**
 URL : https://www.txkuaiyou.com/index/Plazas/plazaDiscuss
 参数 :
 id
 动态ID
 uid
 用户ID
 content
 内容
 */
- (void)AddplazaDiscuss {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:self.item_id forKey:@"id"];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
        [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    }else {
        [parm setObject:@"0" forKey:@"uid"];
    }
    [parm setObject:self.Text_Field.text forKey:@"content"];
    [[HttpRequest sharedInstance] postWithURLString:URL_Plazas_plazaDiscuss parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showError:@"评论成功" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            self.Text_Field.text = @"";
            [self.tableView beginFresh];
        }else {
            [MBProgressHUD py_showError:@"评论失败" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"评论失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

- (void)LoadingDataSoure {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:self.item_id forKey:@"id"];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
        [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    }else {
        [parm setObject:@"0" forKey:@"uid"];
    }
    [[HttpRequest sharedInstance] postWithURLString:URL_Plazas_plazaDetails parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSArray *DataArray = [responseObject objectForKey:@"info"];
            for (NSDictionary *dic in DataArray) {
                Square_Details_Model *model = [Square_Details_Model mj_objectWithKeyValues:dic];
                self.my_Model = model;
                [self.dataArray addObject:model];
            }
            [self getDataSoureList];
        }else {
            [MBProgressHUD py_showError:@"数据加载失败" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

- (void)getDataSoureList {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:self.item_id forKey:@"id"];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
        [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    }else {
        [parm setObject:@"0" forKey:@"uid"];
    }
    [parm setObject:@(self.tableView.Page) forKey:@"page"];
    [[HttpRequest sharedInstance] postWithURLString:URL_Plazas_detailsDiscuss parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        [self.tableView endRefresh];
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSArray *DataArray = [responseObject objectForKey:@"list"];
            for (NSDictionary *dic in DataArray) {
                Square_detailsDiscuss_Model *model = [Square_detailsDiscuss_Model mj_objectWithKeyValues:dic];
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

/**收藏*/
- (void)setplazaCollectDataSoure:(NSString *)modelID {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:modelID forKey:@"id"];
    [[HttpRequest sharedInstance] postWithURLString:URL_Plazas_plazaCollect parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
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

/**顶*/
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
            [self.dataArray removeAllObjects];
            [self LoadingDataSoure];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"操作失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

/**分享*/
- (void)setPlazaShareToBacker:(NSString *)state {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:state forKey:@"id"];
    [[HttpRequest sharedInstance] postWithURLString:URL_Plazas_plazaShare parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
//        if ([[responseObject objectForKey:@"status"] intValue]) {
//            [MBProgressHUD py_showError:@"操作成功" toView:nil];
//            [MBProgressHUD setAnimationDelay:0.7f];
        [self.dataArray removeAllObjects];
        [self LoadingDataSoure];
//        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"操作失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}
/**评论区点赞*/
- (void)setSquareHTDetailsCommentTobackeer:(NSString *)modelID peopleID:(NSString *)pid{
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:User_Mid]) {
        [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    }else {
        [parm setObject:@"0" forKey:@"uid"];
    }
    [parm setObject:modelID forKey:@"id"];
    [parm setObject:pid forKey:@"pid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_Plazas_discussGive parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
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


#pragma mark----SquareHTDetailsFirstCellDelegate
/**1 为关注按钮  2为收藏  3 顶   4为分享*/
- (void)SquareHTDetailsFirstCellButton:(NSInteger)index model:(Square_Details_Model *)model {
    if (index == 1) {
        [self setAttentionDataSoure:model.uid type:[model.attention intValue] ? @"2" : @"1"];
    }else if (index == 2) {
        [self setplazaCollectDataSoure:model.Details_id];
    }else if (index == 3) {
        [self setPraiseToBacker:model.Details_id];
    }else if (index == 4) {
        [self setPlazaShareToBacker:model.Details_id];
    }
}

#pragma mark----SquareHTDetailsCommentCellDelegate

- (void)SquareHTDetailsCommentCell:(NSInteger)index model:(Square_detailsDiscuss_Model *)model {
    if (index == 2) {//评论点赞
        [self setSquareHTDetailsCommentTobackeer:model.detailsDiscuss_id peopleID:model.uid];
    }else {
        
    }
}

- (void)SquareHTDetailsCommentCellMoreButton:(Square_detailsDiscuss_Model *)model {
    UIAlertController *alertV = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *ThreeAction = [UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        Square_Complaint_ViewController *complaintVC = [[Square_Complaint_ViewController alloc] init];
        [complaintVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:complaintVC animated:YES];
        //成功返回Block
    }];
    [alertV addAction:cancelAction];
    [alertV addAction:ThreeAction];
    
    [self presentViewController:alertV animated:YES completion:nil];
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
            if (self.backBlock) {
                self.backBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];
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
            if (self.backBlock) {
                self.backBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"操作失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}


@end
