//
//  Home_KDR_Personal_ViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/7/9.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_KDR_Personal_ViewController.h"
#define CellID @"UITableViewCell"
@interface Home_KDR_Personal_ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UILabel *Name_Label;

@property (strong, nonatomic) IBOutlet UIImageView *icon_View;

@property (strong, nonatomic) IBOutlet UIImageView *Tap_View;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIButton *Sure_Bt;
@property (strong, nonatomic) IBOutlet UILabel *Day_Label;

@property (strong, nonatomic) IBOutlet UIButton *DayTip_BT;

@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSMutableArray *icon_Array;

@property (nonatomic, strong) Home_KDR_Card_Model *Mymodel;
@end

@implementation Home_KDR_Personal_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.Name_Label.text = [[NSUserDefaults standardUserDefaults] objectForKey:User_Nickname];
//    [self.icon_View sd_setImageWithURL:[NSURL URLWithString:[[NSUserDefaults standardUserDefaults] objectForKey:User_Avatar]]];
    self.titleArray = [NSMutableArray arrayWithArray:@[@"我的订单", @"我的地址", @"我的卡包", @"邀请有礼", @"意见反馈", @"联系客服"]];
    self.icon_Array = [NSMutableArray arrayWithArray:@[@"icon_KDR_wodedingdan", @"icon_KDR_Wodedizhi", @"icon_KDR_WDKB", @"icon_KDR_Yaoqingyouli", @"icon_KDR_Yijianfankui", @"icon_KDR_Lianxikefu"]];
    /// 添加四边阴影效果
        // 阴影颜色
//    self.Tap_View.layer.shadowColor = QFC_Color_Six.CGColor;
    // 阴影偏移，默认(0, -3)
//    self.Tap_View.layer.shadowOffset = CGSizeMake(0,0);
    // 阴影透明度，默认0
//    self.Tap_View.layer.shadowOpacity = 0.5;
    // 阴影半径，默认3
//    self.Tap_View.layer.shadowRadius = 5;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self POSTWasteUsersUidUser];
}

- (IBAction)LiftBtuuonPOP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)SureButtonClick:(id)sender {
    Home_KDR_PlaceOrder_ViewController *placeVC = [[Home_KDR_PlaceOrder_ViewController alloc] init];
    [placeVC setAccessibilityElementsHidden:YES];
    [self.navigationController pushViewController:placeVC animated:YES];
}


#pragma mark - UITableViewDelegate
//返回多少个分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
//返回一个分区里多少数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
}
// 返回Cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.imageView.image = [UIImage imageNamed:self.icon_Array[indexPath.row]];
    cell.textLabel.text = self.titleArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        Home_KDR_Order_ViewController *KDRVC = [[Home_KDR_Order_ViewController alloc] init];
        [KDRVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:KDRVC animated:YES];
    }else if (indexPath.row == 1) {
        Home_KDR_Address_ViewController *KDRVC = [[Home_KDR_Address_ViewController alloc] init];
        [KDRVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:KDRVC animated:YES];
    }else if (indexPath.row == 2){//我的卡包
        Home_KDR_MyCard_ViewController *KDRVC = [[Home_KDR_MyCard_ViewController alloc] init];
        [KDRVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:KDRVC animated:YES];
    }else if (indexPath.row == 3) {//邀请有礼
        Home_KDR_InvitationViewController *invitationVC = [[Home_KDR_InvitationViewController alloc] init];
        [invitationVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:invitationVC animated:YES];
    }else if (indexPath.row == 4){//意见反馈
        Home_KDR_idea_ViewController *KDRVC = [[Home_KDR_idea_ViewController alloc] init];
        [KDRVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:KDRVC animated:YES];
    }else if (indexPath.row == 5) {//联系客服
        Home_KDR_BackService_ViewController *KDRVC = [[Home_KDR_BackService_ViewController alloc] init];
        [KDRVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:KDRVC animated:YES];
    }
}


- (void)POSTWasteUsersUidUser {
    /**
     判断是否有下单权限
     waste/users/uidUser
     uid
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    
    [[HttpRequest sharedInstance] postWithURLString:URL_WasteUsersUidUser parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            self.DayTip_BT.userInteractionEnabled = NO;
//            self.Middle_BT.userInteractionEnabled = YES;
            NSDictionary *DataSoure = [responseObject objectForKey:@"info"];
            self.Mymodel = [Home_KDR_Card_Model mj_objectWithKeyValues:DataSoure];
            self.Day_Label.text = [self.Mymodel.endtime intValue] > 0 ? [NSString stringWithFormat:@"剩余%@天", self.Mymodel.endtime] : @"代扔垃圾卡";
            [self.DayTip_BT setTitle:[self.Mymodel.type intValue] == 1 ? @"  代扔月卡  " : ([self.Mymodel.type intValue] == 2 ? @"  代扔年卡  " : @"  立即购买  ") forState:UIControlStateNormal];
            self.Name_Label.text = self.Mymodel.nickname;
            [self.icon_View sd_setImageWithURL:[NSURL URLWithString:self.Mymodel.avatar]];
        }else {
            self.DayTip_BT.userInteractionEnabled = YES;
        }
    } failure:^(NSError * _Nonnull error) {
//        self.Middle_BT.userInteractionEnabled = YES;
        [MBProgressHUD py_showError:[NSString stringWithFormat:@"加载失败(%ld)", error.code] toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}


@end
