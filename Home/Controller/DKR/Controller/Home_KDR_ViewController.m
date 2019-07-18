//
//  Home_KDR_ViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/7/8.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_KDR_ViewController.h"

@interface Home_KDR_ViewController ()
@property (strong, nonatomic) IBOutlet UIButton *Lift_BT;
@property (strong, nonatomic) IBOutlet UIButton *Middle_BT;
@property (strong, nonatomic) IBOutlet UIButton *Right_BT;
@property (strong, nonatomic) IBOutlet UILabel *Lift_LAbel;

@end

@implementation Home_KDR_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSLog(@"%@", [Singleton sharedSingleton].type_id);
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Type] intValue] == 4) {
        self.Lift_LAbel.text = @"新手指南";
    }else {
        self.Lift_LAbel.text = @"快速入驻";
    }
}

- (IBAction)LiftBtuuonPOP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)LiftButtonClick:(id)sender {
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    if ([[userdefaults objectForKey:User_Type] intValue] == 4) {//快代扔
        Home_KDR_Novice_ViewController *KDRVC = [[Home_KDR_Novice_ViewController alloc] init];
        [KDRVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:KDRVC animated:YES];
//        Home_KDR_OrderState_ViewController *KDRVC = [[Home_KDR_OrderState_ViewController alloc] init];
//         [KDRVC setHidesBottomBarWhenPushed:YES];
//         [self.navigationController pushViewController:KDRVC animated:YES];
    }else {
        if ([[userdefaults objectForKey:User_Type] intValue] == 0) {//普通用户
            if ([[userdefaults objectForKey:User_Audit] intValue] == 2) {//待审核
                Examine_State_ViewController *examineVC = [[Examine_State_ViewController alloc] init];
                [examineVC setHidesBottomBarWhenPushed:YES];
                [self.navigationController pushViewController:examineVC animated:YES];
            }else {
                Home_KDR_SettledIn_ViewController *setVC = [[Home_KDR_SettledIn_ViewController alloc] init];
                [setVC setHidesBottomBarWhenPushed:YES];
                [self.navigationController pushViewController:setVC animated:YES];
            }
        }else {//其他角色
            
        }
    }
}

- (IBAction)MiddleButtonClick:(id)sender {
    self.Middle_BT.userInteractionEnabled = NO;
    [self POSTWasteOrderGiveFindOrder];
//    Home_KDR_PlaceOrder_ViewController *KDRVC = [[Home_KDR_PlaceOrder_ViewController alloc] init];
//    [KDRVC setHidesBottomBarWhenPushed:YES];
//    [self.navigationController pushViewController:KDRVC animated:YES];
}

- (IBAction)RightButtonClick:(id)sender {
    Home_KDR_Personal_ViewController *KDRVC = [[Home_KDR_Personal_ViewController alloc] init];
    [KDRVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:KDRVC animated:YES];
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
            self.Middle_BT.userInteractionEnabled = YES;
            NSDictionary *DataSoure = [responseObject objectForKey:@"info"];
            if ([[DataSoure objectForKey:@"type"] intValue] == 0) {//没卡
                Home_KDR_PlaceOrder_ViewController *KDRVC = [[Home_KDR_PlaceOrder_ViewController alloc] init];
                KDRVC.LiftBT_State = [[DataSoure objectForKey:@"experience"] intValue] ? YES : NO;
                [KDRVC setHidesBottomBarWhenPushed:YES];
                [self.navigationController pushViewController:KDRVC animated:YES];
            }else {
                [self POSTWasteAddressDefaultInfo];
            }
        }else {
            self.Middle_BT.userInteractionEnabled = YES;
            [MBProgressHUD py_showError:@"获取失败" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
    } failure:^(NSError * _Nonnull error) {
        self.Middle_BT.userInteractionEnabled = YES;
        [MBProgressHUD py_showError:[NSString stringWithFormat:@"加载失败(%ld)", error.code] toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

- (void)POSTWasteOrderGiveFindOrder {
    /**
     waste/order/GiveFindOrder
     uid
     判断有没有订单
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    
    [[HttpRequest sharedInstance] postWithURLString:URL_WasteOrderGiveFindOrder parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            self.Middle_BT.userInteractionEnabled = YES;
            Home_KDR_OrderState_ViewController *KDRVC = [[Home_KDR_OrderState_ViewController alloc] init];
            KDRVC.orderid = [responseObject objectForKey:@"orderid"];
            if ([[responseObject objectForKey:@"type"] intValue] == 0) {//代接单
                KDRVC.State = 0;
            }else if ([[responseObject objectForKey:@"type"] intValue] == 1) {//代服务
                KDRVC.State = 1;
            }else if ([[responseObject objectForKey:@"type"] intValue] == 2) {//已完成
                KDRVC.State = 2;
            }
            [KDRVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:KDRVC animated:YES];
            
        }else {
            [self POSTWasteUsersUidUser];
        }
    } failure:^(NSError * _Nonnull error) {
        self.Middle_BT.userInteractionEnabled = YES;
        [MBProgressHUD py_showError:[NSString stringWithFormat:@"加载失败(%ld)", error.code] toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
    
}


- (void)POSTWasteAddressDefaultInfo {
    /**
     判断有没有下单地址
     waste/address/defaultInfo
     uid
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    
    [[HttpRequest sharedInstance] postWithURLString:URL_WasteAddressDefaultInfo parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            self.Middle_BT.userInteractionEnabled = YES;
            NSDictionary *DataSoure = [responseObject objectForKey:@"info"];
            if ([[DataSoure objectForKey:@"type"] intValue] == 0) {//没卡
                Home_KDR_PlaceOrder_ViewController *KDRVC = [[Home_KDR_PlaceOrder_ViewController alloc] init];
                [KDRVC setHidesBottomBarWhenPushed:YES];
                [self.navigationController pushViewController:KDRVC animated:YES];
            }else {
                UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"提示" message:@"无服务地址" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    //成功返回Block
                }];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    //成功返回Block
                }];
                [alertV addAction:cancel];
                [alertV addAction:okAction];
                
                [self presentViewController:alertV animated:YES completion:nil];
            }
  
        }else {
            self.Middle_BT.userInteractionEnabled = YES;
            [MBProgressHUD py_showError:@"获取失败" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
    } failure:^(NSError * _Nonnull error) {
        self.Middle_BT.userInteractionEnabled = YES;
        [MBProgressHUD py_showError:[NSString stringWithFormat:@"加载失败(%ld)", error.code] toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
    
}



@end
