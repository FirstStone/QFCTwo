
//
//  Mine_SetUP_ViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/4/18.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_SetUP_ViewController.h"
#define CellID @"tableviewCell"
@interface Mine_SetUP_ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *Title_Array;

@end

@implementation Mine_SetUP_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.Title_Array = @[@"个人信息", @"地址管理", @"账号安全", @"通用", @"隐私", @"问题反馈", @"关于我们"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_SetUP_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID];
}

#pragma mark - UITableViewDelegate
//返回多少个分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
//返回一个分区里多少数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.Title_Array.count;
}
// 返回Cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Mine_SetUP_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    
    cell.Title_Label.text = self.Title_Array[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {//个人信息
        Mine_SetUP_PersonalData_VC *personalVC = [[Mine_SetUP_PersonalData_VC alloc] init];
        [self.navigationController pushViewController:personalVC animated:YES];
    } else if (indexPath.row == 1) {//地址管理
        Mine_SetUP_MyAddress_ViewController *MyaddressVC = [[Mine_SetUP_MyAddress_ViewController alloc] init];
        [self.navigationController pushViewController:MyaddressVC animated:YES];
    }else if (indexPath.row == 2) {//账号安全
        Mine_SetUP_Safe_VC *safeVC = [[Mine_SetUP_Safe_VC alloc] init];
        [self.navigationController pushViewController:safeVC animated:YES];
    }else if (indexPath.row == 3) {//通用
        Mine_SetUP_Currency_VC *currencyVC = [[Mine_SetUP_Currency_VC alloc] init];
        [self.navigationController pushViewController:currencyVC animated:YES];
    }else if (indexPath.row == 4) {//隐私
        Mine_SetUP_Privacy_VC *privacyVC = [[Mine_SetUP_Privacy_VC alloc] init];
        [self.navigationController pushViewController:privacyVC animated:YES];
    }else if (indexPath.row == 5) {//问题反馈
        Mine_SetUP_Feedback_VC *feedbackVC = [[Mine_SetUP_Feedback_VC alloc] init];
        [self.navigationController pushViewController:feedbackVC animated:YES];
    }else if (indexPath.row == 6) {//关于我们
        Mine_SetUP_About_Me_VC *aboutVC = [[Mine_SetUP_About_Me_VC alloc] init];
        [self.navigationController pushViewController:aboutVC animated:YES];
    }
}


- (IBAction)LiftButtonPOP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)GoOutButtonClick:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:User_Mid];
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:User_Type];
    EMError *error = [[EMClient sharedClient] logout:YES];
    if (!error) {
        NSLog(@"------------------------------------------退出成功");
    }
    [MBProgressHUD py_showError:@"退出成功" toView:nil];
    [MBProgressHUD setAnimationDelay:0.7f];
    [[NSNotificationCenter defaultCenter] postNotificationName:QFC_UpDataSoureToSelfView_NSNotification object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
