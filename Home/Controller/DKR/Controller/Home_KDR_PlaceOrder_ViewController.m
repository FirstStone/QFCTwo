//
//  Home_KDR_PlaceOrder_ViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/7/9.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_KDR_PlaceOrder_ViewController.h"

@interface Home_KDR_PlaceOrder_ViewController ()

@property (strong, nonatomic) IBOutlet UIButton *Month_BT;

@property (strong, nonatomic) IBOutlet UIButton *Year_BT;

@property (strong, nonatomic) IBOutlet UIButton *Sum_BT;

@property (strong, nonatomic) IBOutlet UILabel *Tip_Label;

@property (strong, nonatomic) IBOutlet UIButton *Lift_BT;

@property (strong, nonatomic) IBOutlet UIButton *Address_BT;

@property (strong, nonatomic) IBOutlet UIButton *Right_BT;


@property (nonatomic, strong) NSString *Addressid;

@property (nonatomic, strong) NSString *AddressText;
@end

@implementation Home_KDR_PlaceOrder_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.Lift_BT.hidden = !self.LiftBT_State;
    [self POSTWasteAddressDefaultInfo];
}

- (IBAction)LiftBtuuonPOP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)MonthButtonClick:(id)sender {
    self.Year_BT.selected = NO;
    self.Sum_BT.selected = NO;
    self.Month_BT.selected = YES;
    self.Tip_Label.hidden = YES;
    [self buttonStateChange];
}

- (IBAction)YearButtonClick:(id)sender {
    self.Year_BT.selected = YES;
    self.Sum_BT.selected = NO;
    self.Month_BT.selected = NO;
    self.Tip_Label.hidden = NO;
    [self buttonStateChange];
}

- (IBAction)SumButtonClick:(id)sender {
    self.Year_BT.selected = NO;
    self.Sum_BT.selected = YES;
    self.Month_BT.selected = NO;
    self.Tip_Label.hidden = YES;
    [self buttonStateChange];
}

- (void)buttonStateChange {
    if (self.Month_BT.selected) {
        self.Month_BT.backgroundColor = QFC_Color_09D15A;
        self.Year_BT.backgroundColor = QFC_Color_F5F5F5;
        self.Sum_BT.backgroundColor = QFC_Color_F5F5F5;
    }else if (self.Year_BT.selected) {
        self.Month_BT.backgroundColor = QFC_Color_F5F5F5;
        self.Year_BT.backgroundColor = QFC_Color_09D15A;
        self.Sum_BT.backgroundColor = QFC_Color_F5F5F5;
    }else {
        self.Month_BT.backgroundColor = QFC_Color_F5F5F5;
        self.Year_BT.backgroundColor = QFC_Color_F5F5F5;
        self.Sum_BT.backgroundColor = QFC_Color_09D15A;
    }
}

- (IBAction)LiftButtonClick:(id)sender {
    self.Lift_BT.userInteractionEnabled = NO;
    if ([self.Addressid intValue]) {
        [self POSTWasteOrderExperience];
    }else {
        [MBProgressHUD py_showError:@"请选择地址" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }
}

- (IBAction)RightButtonClick:(id)sender {
    if ([self.Addressid intValue]) {
        //      status   1月卡2年卡3单次
        self.Right_BT.userInteractionEnabled = NO;
        if (self.Month_BT.selected) {
            [self POSTWasteOrderOrderAdd:@"1"];
        }else if (self.Year_BT.selected){
            [self POSTWasteOrderOrderAdd:@"2"];
        }else {
            [self POSTWasteOrderOrderAdd:@"3"];
        }
    }else {
        if (self.AddressText.length) {
            UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"是否在（%@）下单",self.AddressText] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"前往" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //成功返回Block
                Home_KDR_Address_ViewController *AddressVC = [[Home_KDR_Address_ViewController alloc] init];
                [AddressVC setHidesBottomBarWhenPushed:YES];
                [self.navigationController pushViewController:AddressVC animated:YES];
            }];
            UIAlertAction *cencal = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //成功返回Block
            }];
            [alertV addAction:cencal];
            [alertV addAction:okAction];
            
            [self presentViewController:alertV animated:YES completion:nil];
        }else {
            UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"提示" message:@"前往选择默认下单地址" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"前往" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //成功返回Block
                Home_KDR_Address_ViewController *AddressVC = [[Home_KDR_Address_ViewController alloc] init];
                [AddressVC setHidesBottomBarWhenPushed:YES];
                [self.navigationController pushViewController:AddressVC animated:YES];
            }];
            UIAlertAction *cencal = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //成功返回Block
            }];
            [alertV addAction:cencal];
            [alertV addAction:okAction];
            
            [self presentViewController:alertV animated:YES completion:nil];
        }
    }
}

- (IBAction)AddressButtonClick:(id)sender {
    Home_KDR_Address_ViewController *AddressVC = [[Home_KDR_Address_ViewController alloc] init];
    MJWeakSelf;
    AddressVC.addressBlock = ^(Mine_SetUP_MyAddress_Model * _Nonnull model) {
        weakSelf.Addressid = model.MyAddress_id;
        [weakSelf.Address_BT setTitle:[NSString stringWithFormat:@"%@%@", model.village, model.details] forState:UIControlStateNormal];
    };
    [AddressVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:AddressVC animated:YES];
}

- (void)POSTWasteOrderExperience {
    /**
     waste/order/experiences
     uid
     addressid
     免费预约
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:self.Addressid forKey:@"addressid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_WasteOrderExperiences parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            self.Lift_BT.userInteractionEnabled = YES;
            Home_KDR_OrderState_ViewController *KDRVC = [[Home_KDR_OrderState_ViewController alloc] init];
            KDRVC.Number = 1;
            [KDRVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:KDRVC animated:YES];
        }else {
            self.Lift_BT.userInteractionEnabled = YES;
            [MBProgressHUD py_showError:@"操作失败" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
    } failure:^(NSError * _Nonnull error) {
        self.Lift_BT.userInteractionEnabled = YES;
        [MBProgressHUD py_showError:[NSString stringWithFormat:@"预约失败(%ld)", error.code] toView:nil];
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
            //            self.Middle_BT.userInteractionEnabled = YES;
            NSDictionary *DataSoure = [responseObject objectForKey:@"info"];
            self.Addressid = [DataSoure objectForKey:@"id"];
            self.AddressText = [NSString stringWithFormat:@"%@%@", [DataSoure objectForKey:@"village"], [DataSoure objectForKey:@"details"]];
            [self.Address_BT setTitle:[NSString stringWithFormat:@"%@%@", [DataSoure objectForKey:@"village"], [DataSoure objectForKey:@"details"]] forState:UIControlStateNormal];
        }else {
            //            self.Middle_BT.userInteractionEnabled = YES;
//            [MBProgressHUD py_showError:@"获取失败" toView:nil];
//            [MBProgressHUD setAnimationDelay:0.7f];
        }
    } failure:^(NSError * _Nonnull error) {
        //        self.Middle_BT.userInteractionEnabled = YES;
        [MBProgressHUD py_showError:[NSString stringWithFormat:@"加载失败(%ld)", error.code] toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
    
}


- (void)POSTWasteOrderOrderAdd:(NSString *)Type {
    /**
     快代扔
     waste/order/orderAdd
     status   1月卡2年卡3单次
     uid
     addressid   地址ID
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:Type forKey:@"status"];
    [parm setObject:self.Addressid forKey:@"addressid"];
    
    [[HttpRequest sharedInstance] postWithURLString:URL_wasteOrderOrderAdd parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            self.Right_BT.userInteractionEnabled = YES;
            Pay_ViewController *payVC = [[Pay_ViewController alloc] init];
            payVC.OrderID = [responseObject objectForKey:@"orderid"];
            payVC.PayStyle = PayViewControllerKDR;
            [payVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:payVC animated:YES];
        }else {
            self.Right_BT.userInteractionEnabled = YES;
            [MBProgressHUD py_showError:@"操作失败" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
    } failure:^(NSError * _Nonnull error) {
        self.Right_BT.userInteractionEnabled = YES;
        [MBProgressHUD py_showError:[NSString stringWithFormat:@"下单失败(%ld)", error.code] toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
    
}

@end
