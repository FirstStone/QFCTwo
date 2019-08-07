//
//  Square_Prsonal_Details_VC.m
//  QFC
//
//  Created by tiaoxin on 2019/4/12.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Square_Prsonal_Details_VC.h"
#define CellID_SquareDefaultCell @"SquareDefaultCell"
#define CellID_SquareShopCell @"SquareShopCell"
#define CellID_SquareTextCell @"SquareTextCell"
#define CellID_SquareESHeaderCell @"SquareESHeaderCell"
#define CellID_SquareHTImageCell @"SquareHTImageCell"
#define CellID_SquareHTTextCell @"SquareHTTextCell"
#define CellID_SquareWDImageCell @"SquareWDImageCell"
#define CellID_SquareWDQuestionCell @"SquareWDQuestionCell"
#define CellID_SquareWDTextCell @"SquareWDTextCell"
#define CellID_SquareWDImageAndTextCell @"SquareWDImageAndTextCell"
#define CellID_SquareWDSDCell @"SquareWDSDCell"
@interface Square_Prsonal_Details_VC ()<UITableViewDelegate, UITableViewDataSource, SquareDefaultCellDelegate>
@property (strong, nonatomic) IBOutlet Basic_TableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) Square_information_Model *Mymodel;

@property (strong, nonatomic) IBOutlet UIImageView *icon_imageView;

@property (strong, nonatomic) IBOutlet UILabel *Name_Label;

@property (strong, nonatomic) IBOutlet UILabel *Sex_LAbel;

@property (strong, nonatomic) IBOutlet UIImageView *Mark_Label;

@property (strong, nonatomic) IBOutlet UILabel *Address_Label;

@property (strong, nonatomic) IBOutlet UILabel *Age_Label;

@property (strong, nonatomic) IBOutlet UILabel *Sub_Label;

@property (strong, nonatomic) IBOutlet UILabel *Fansi_Label;

@property (strong, nonatomic) IBOutlet UILabel *Guanzhu_Label;

@property (strong, nonatomic) IBOutlet UILabel *FaBu_Label;

@property (strong, nonatomic) IBOutlet UILabel *Time_Label;

@property (strong, nonatomic) IBOutlet UIButton *Follow_BT;

@property (strong, nonatomic) IBOutlet UIButton *Chat_BT;

@property (strong, nonatomic) IBOutlet UIButton *Store_BT;

@property (strong, nonatomic) IBOutlet UIView *Down_View;

@end

@implementation Square_Prsonal_Details_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue] != [self.uid intValue]) {
        self.Down_View.hidden = NO;
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Square_Default_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_SquareDefaultCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Square_Shop_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_SquareShopCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Square_TextCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_SquareTextCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Square_ES_Header_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_SquareESHeaderCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Square_HT_ImageCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_SquareHTImageCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Square_HT_Text_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_SquareHTTextCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Square_WD_ImageCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_SquareWDImageCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Square_WD_Question_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_SquareWDQuestionCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Square_WD_Text_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_SquareWDTextCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Square_WD_ImageAndText_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_SquareWDImageAndTextCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Square_WD_SD_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_SquareWDSDCell];
    [self LoadingDataSoure];
    [self getDataSoureList];
}
- (IBAction)RightBTPoP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (IBAction)MoreButtonClick:(id)sender {
    UIAlertController *alertV = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *TowAction = [UIAlertAction actionWithTitle:@"屏蔽他的动态" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //成功返回Block
        [self PostindexPlazasBlock:self.uid];
    }];
    UIAlertAction *ThreeAction = [UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        Square_Complaint_ViewController *complaintVC = [[Square_Complaint_ViewController alloc] init];
        [complaintVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:complaintVC animated:YES];
        //成功返回Block
    }];
    [alertV addAction:cancelAction];
    [alertV addAction:TowAction];
    [alertV addAction:ThreeAction];
    
    [self presentViewController:alertV animated:YES completion:nil];
}

- (IBAction)FollowButtonClick:(id)sender {
    [self setAttentionDataSoure:self.uid type:@"1"];
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
        [cell setDataSoureToCell:model];
        return cell;
    }else if ([model.type intValue] == 2 ) {//2普通动态图文
        Square_HT_ImageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareHTImageCell];
//        cell.delegate = self;
        [cell setDataSoureToCell:model];
        return cell;
        
    }else if ([model.type intValue] == 3 ) {//3回答文字
        Square_WD_Text_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareWDTextCell];
        [cell setDataSoureToCell:model];
        return cell;
    }else if ([model.type intValue] == 4 ) {//4回答图文
        Square_WD_ImageAndText_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareWDImageAndTextCell];
        [cell setDataSoureToCell:model];
        return cell;
    }else {// 5问题
        Square_WD_Text_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareWDTextCell];
        [cell setDataSoureToCell:model];
        return cell;
    }
    
    /*if (indexPath.row == 3) {
        Square_Shop_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareShopCell];
        if (!cell) {
        }
        return cell;
    }else if (indexPath.row == 2) {
        Square_TextCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareTextCell];
        if (!cell) {
        }
        return cell;
    } else {
        Square_Default_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareDefaultCell];
        cell.delegate = self;
        return cell;
    }*/
}

#pragma mark----SquareDefaultCellDelegate
- (void)iconViewClick:(NSString *)mid {
    NSLog(@"++++++++++++++++++++");
}


#pragma mark----UPdata
- (void)LoadingDataSoure {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:self.uid forKey:@"uid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_Plazas_plazaHomepage parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSDictionary *dic = [responseObject objectForKey:@"info"];
            self.Mymodel = [Square_information_Model mj_objectWithKeyValues:dic];
            [self.icon_imageView sd_setImageWithURL:[NSURL URLWithString:self.Mymodel.avatar]];
            self.Name_Label.text = self.Mymodel.nickname;
            if ([self.Mymodel.sex intValue] == 1) {
                self.Sex_LAbel.text = @" ♀ ";
            }else {
                self.Sex_LAbel.text = @" ♂ ";
            }
            if ([self.Mymodel.type_id intValue] == 3) {
                self.Store_BT.enabled = YES;
            }
            self.Address_Label.text = [NSString stringWithFormat:@"  %@-%@  ", self.Mymodel.country, self.Mymodel.province];
            self.Age_Label.text = [NSString stringWithFormat:@"  %@后  ", self.Mymodel.year];
            self.Fansi_Label.text = [NSString stringWithFormat:@"粉丝 %@",self.Mymodel.fans_sum];
            self.Guanzhu_Label.text = [NSString stringWithFormat:@"关注 %@",self.Mymodel.attention_sum];
            self.FaBu_Label.text = [NSString stringWithFormat:@"发布 %@",self.Mymodel.plaza_sum];
            self.Time_Label.text = [NSString stringWithFormat:@"天数 %@", self.Mymodel.createtime];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

/**
 社区广场 个人主页 发布的动态列表
 URL : https://www.txkuaiyou.com/index/Plazas/plzazHomepageList
 参数 :
 id
 用户ID
 page
 分页
 */
- (void)getDataSoureList {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:self.uid forKey:@"uid"];
    [parm setObject:@"1" forKey:@"page"];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"pid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_Plazas_plzazHomepageList parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        [self.tableView endRefresh];
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            //获取list
            NSArray *Array = [responseObject objectForKey:@"list"];
            for (NSDictionary *dic in Array) {
                SquareRecommend_Model *model = [SquareRecommend_Model mj_objectWithKeyValues:dic];
                [self.dataArray addObject:model];
            }
            if (!Array.count) {
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




- (IBAction)MyShopStoreButtonClick:(id)sender {
    H5_Mine_MyShopStoreViewController *MyShopVC = [[H5_Mine_MyShopStoreViewController alloc] init];
    MyShopVC.merchant_id = self.Mymodel.merchant_id;
    [self.navigationController pushViewController:MyShopVC animated:YES];
}

- (IBAction)ChatButtonClick:(id)sender {
    [self TakeChatDataSoure];
//    EaseMessageViewController *chatController = [[EaseMessageViewController alloc] initWithConversationChatter:[NSString stringWithFormat:@"%@ky",self.uid] conversationType:EMConversationTypeChat];
    ChatViewController *chatController = [[ChatViewController alloc] initWithConversationChatter:[NSString stringWithFormat:@"%@ky",self.uid] conversationType:EMConversationTypeChat];
    chatController.idStr = self.Mymodel.nickname;
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:chatController animated:YES];
}

#pragma mark----UPdata
- (void)TakeChatDataSoure {
    /**
     创建聊天链接
     URL : https://www.txkuaiyou.com/index/Informations/infromAdd
     参数 :
     uid
     用户ID
     pid
     用户ID  对方的
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:self.uid forKey:@"pid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_Informations_infromAdd parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"创建失败" toView:nil];
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
//            [self.dataArray removeAllObjects];
//            [self LoadingDataSoure];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"操作失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

@end
