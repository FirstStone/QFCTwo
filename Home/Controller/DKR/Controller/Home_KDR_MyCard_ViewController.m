//
//  Home_KDR_MyCard_ViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/7/23.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_KDR_MyCard_ViewController.h"

@interface Home_KDR_MyCard_ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *Name_Label;

@property (strong, nonatomic) IBOutlet UIImageView *icon_View;

@property (strong, nonatomic) IBOutlet UIButton *Sure_Bt;
@property (strong, nonatomic) IBOutlet UILabel *Day_Label;
@property (strong, nonatomic) IBOutlet UIButton *DayTip_BT;
@property (nonatomic, strong) Home_KDR_Card_Model *Mymodel;
@end

@implementation Home_KDR_MyCard_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
            self.DayTip_BT.userInteractionEnabled = YES;
            //            self.Middle_BT.userInteractionEnabled = YES;
            NSDictionary *DataSoure = [responseObject objectForKey:@"info"];
            self.Mymodel = [Home_KDR_Card_Model mj_objectWithKeyValues:DataSoure];
            self.Day_Label.text = [self.Mymodel.endtime intValue] > 0 ? [NSString stringWithFormat:@"剩余%@天", self.Mymodel.endtime] : @"代扔垃圾卡";
//            [self.DayTip_BT setTitle:[self.Mymodel.type intValue] == 1 ? @"  代扔月卡  " : ([self.Mymodel.type intValue] == 2 ? @"  代扔年卡  " : @"  立即购买  ") forState:UIControlStateNormal];
            self.Name_Label.text = self.Mymodel.nickname;
            [self.icon_View sd_setImageWithURL:[NSURL URLWithString:self.Mymodel.avatar]];
        }else {
//            self.DayTip_BT.userInteractionEnabled = YES;
        }
    } failure:^(NSError * _Nonnull error) {
        //        self.Middle_BT.userInteractionEnabled = YES;
        [MBProgressHUD py_showError:[NSString stringWithFormat:@"加载失败(%ld)", error.code] toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

@end
