//
//  Message_ViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/4/2.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Message_ViewController.h"

#define CellID_MessageTZCell @"MessageTZCell"
#define CellID_MessageTZDefaultCell @"MessageTZDefaultCell"

@interface Message_ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet Basic_TableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *iconArray;
@property (nonatomic, strong) NSMutableArray *subheadingArray;

@end

@implementation Message_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.titleArray = [NSMutableArray arrayWithArray:@[@"通知中心", @"跑腿抢单中心", @"商家接单中心", @"家政接单中心"]];
//    self.iconArray = [NSMutableArray arrayWithArray:@[@"icon_XX_Tongzhi", @"icon_XX_paotui", @"icon_XX_shangjia", @"icon_XX_jiazheng"]];
//    self.subheadingArray = @[@"订单订单订单订单订单订单订单订单", @"订单订单订单订单订单订单订单订单", @"订单订单订单订单订单订单订单订单", @"订单订单订单订单订单订单订单订单"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Message_TZ_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MessageTZCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Message_TZ_Default_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MessageTZDefaultCell];
    MJWeakSelf;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.tableView.Page = 1;
        [weakSelf.dataArray removeAllObjects];
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Type] intValue] == 3) {//商家
            weakSelf.dataArray = [NSMutableArray arrayWithArray:@[@"通知中心", @"商家接单中心"]];
            weakSelf.iconArray = [NSMutableArray arrayWithArray:@[@"icon_XX_Tongzhi", @"icon_XX_shangjia"]];
        }else if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Type] intValue] == 1) {//跑腿
            weakSelf.dataArray = [NSMutableArray arrayWithArray:@[@"通知中心", @"跑腿抢单中心"]];
            weakSelf.iconArray = [NSMutableArray arrayWithArray:@[@"icon_XX_Tongzhi", @"icon_XX_paotui"]];
        } else if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Type] intValue] == 2) {//家政
            weakSelf.dataArray = [NSMutableArray arrayWithArray:@[@"通知中心", @"家政接单中心"]];
            weakSelf.iconArray = [NSMutableArray arrayWithArray:@[@"icon_XX_Tongzhi", @"icon_XX_jiazheng"]];
        }else {//普通
            weakSelf.dataArray = [NSMutableArray arrayWithArray:@[@"通知中心"]];
            weakSelf.iconArray = [NSMutableArray arrayWithArray:@[@"icon_XX_Tongzhi"]];
        }
        [weakSelf LoadingDataSoure];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.tableView.Page += 1;
        [weakSelf LoadingDataSoure];
    }];
    [self.tableView beginFresh];
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (NSMutableArray *)iconArray {
    if (!_iconArray) {
        _iconArray = [[NSMutableArray alloc] init];
    }
    return _iconArray;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.tableView beginFresh];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO];
}


#pragma mark - UITableViewDelegate
//返回多少个分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
//返回一个分区里多少数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
// 返回Cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.dataArray[indexPath.row] isMemberOfClass:[Message_infromLists_Model class]]) {
        Message_infromLists_Model *model = self.dataArray[indexPath.row];
        Message_TZ_Default_Cell *Cell = [tableView dequeueReusableCellWithIdentifier:CellID_MessageTZDefaultCell];
        [Cell.icon_ImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
        Cell.Title_Label.text = model.nickname;
        Cell.Subheading_Label.text = model.createtime;
        Cell.Subheading_Label.hidden = NO;
        return Cell;
        
    }else {
        if (indexPath.row == 0) {
            Message_TZ_Cell *Cell = [tableView dequeueReusableCellWithIdentifier:CellID_MessageTZCell];
            Cell.icon_imageView.image = [UIImage imageNamed:self.iconArray[indexPath.row]];
            Cell.title_Label.text = self.dataArray[indexPath.row];
            //        Cell.subheading_Label.text = self.subheadingArray[indexPath.row];
            return Cell;
        }else {
            Message_TZ_Default_Cell *Cell = [tableView dequeueReusableCellWithIdentifier:CellID_MessageTZDefaultCell];
            Cell.icon_ImageView.image = [UIImage imageNamed:self.iconArray[indexPath.row]];
            Cell.Title_Label.text = self.dataArray[indexPath.row];
            //        Cell.Subheading_Label.text = self.subheadingArray[indexPath.row];
            return Cell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
        if ([self.dataArray[indexPath.row] isMemberOfClass:[Message_infromLists_Model class]]) {
//            [self.navigationController setNavigationBarHidden:NO];
//            Message_infromLists_Model *model = self.dataArray[indexPath.row];
//            
//            Message_Conversation_ViewController *EMVC = [[Message_Conversation_ViewController alloc] initWithConversationChatter:model.userid conversationType:EMConversationTypeChat];
//            EMVC.title = model.nickname;
////            EMVC.money = model.image_text_price;
//            [EMVC setHidesBottomBarWhenPushed:YES];
//            [self.navigationController pushViewController:EMVC animated:YES];
            
        }else {
            if (indexPath.row == 0) {//通知中心
                Message_NotificationCenter_VC *notificationVC = [[Message_NotificationCenter_VC alloc] init];
                [notificationVC setHidesBottomBarWhenPushed:YES];
                [self.navigationController pushViewController:notificationVC animated:YES];
            }else if (indexPath.row == 1){
                if ([[[Singleton sharedSingleton] type_id] intValue] == 1) {//跑腿
                    Message_RunErrands_VC *RunErrandsVC = [[Message_RunErrands_VC alloc] init];
                    [RunErrandsVC setHidesBottomBarWhenPushed:YES];
                    [self.navigationController pushViewController:RunErrandsVC animated:YES];
                    
                } else if ([[[Singleton sharedSingleton] type_id] intValue] == 2) {//家政
                    Message_Housekeeping_VC *houseVC = [[Message_Housekeeping_VC alloc] init];
                    [houseVC setHidesBottomBarWhenPushed:YES];
                    [self.navigationController pushViewController:houseVC animated:YES];
                    
                }else {//商家
                    Messag_Shoping_VC *shopVC = [[Messag_Shoping_VC alloc] init];
                    [shopVC setHidesBottomBarWhenPushed:YES];
                    [self.navigationController pushViewController:shopVC animated:YES];
                    
                }
            }
        }
    }else {
        Basic_NavigationController *LoginVC = [[Basic_NavigationController alloc] initWithRootViewController:[[Login_PhoneCodeViewControlloer alloc] init]];
        [self.navigationController presentViewController:LoginVC animated:YES completion:Nil];
    }
}

#pragma mark----TopbuttonClick
//粉丝
- (IBAction)FansButtonClick:(id)sender {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
        Message_FansViewController *fanVC = [[Message_FansViewController alloc] init];
        [fanVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:fanVC animated:YES];
    }else {
        Basic_NavigationController *LoginVC = [[Basic_NavigationController alloc] initWithRootViewController:[[Login_PhoneCodeViewControlloer alloc] init]];
        [self.navigationController presentViewController:LoginVC animated:YES completion:Nil];
    }
}
//获顶
- (IBAction)ApexButtonClick:(id)sender {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
        Message_ApexViewController *fanVC = [[Message_ApexViewController alloc] init];
        [fanVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:fanVC animated:YES];
    }else {
        Basic_NavigationController *LoginVC = [[Basic_NavigationController alloc] initWithRootViewController:[[Login_PhoneCodeViewControlloer alloc] init]];
        [self.navigationController presentViewController:LoginVC animated:YES completion:Nil];
    }
}
//评论
- (IBAction)CommentButtonClick:(id)sender {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
        Message_CommentViewController *fanVC = [[Message_CommentViewController alloc] init];
        [fanVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:fanVC animated:YES];
    }else {
        Basic_NavigationController *LoginVC = [[Basic_NavigationController alloc] initWithRootViewController:[[Login_PhoneCodeViewControlloer alloc] init]];
        [self.navigationController presentViewController:LoginVC animated:YES completion:Nil];
    }
}
//转发
- (IBAction)ForwardButtonClick:(id)sender {
    [MBProgressHUD py_showError:@"暂未开通，敬请期待" toView:nil];
    [MBProgressHUD setAnimationDelay:0.7f];
//    Message_ForwardViewController *fanVC = [[Message_ForwardViewController alloc] init];
//    [fanVC setHidesBottomBarWhenPushed:YES];
//    [self.navigationController pushViewController:fanVC animated:YES];
}

#pragma mark----UPdata
- (void)LoadingDataSoure {
    /**
     1.    获取聊天列表
     URL : https://www.txkuaiyou.com/index/Informations/infromLists
     参数 :
     uid    用户ID
     page    分页
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:@(self.tableView.Page) forKey:@"page"];
    [[HttpRequest sharedInstance] postWithURLString:URL_Informations_infromLists parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        [self.tableView endRefresh];
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSArray *Array = [responseObject objectForKey:@"list"];
            for (NSDictionary *dic in Array) {
                Message_infromLists_Model *model = [Message_infromLists_Model  mj_objectWithKeyValues:dic];
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


@end
