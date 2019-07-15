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
    if ([[Singleton sharedSingleton].type_id intValue] == 4) {
        self.Lift_LAbel.text = @"新手指南";
    }else {
        self.Lift_LAbel.text = @"快速入驻";
    }
}

- (IBAction)LiftBtuuonPOP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)LiftButtonClick:(id)sender {
    if ([[Singleton sharedSingleton].type_id intValue] == 4) {
        Home_KDR_OrderState_ViewController *KDRVC = [[Home_KDR_OrderState_ViewController alloc] init];
         [KDRVC setHidesBottomBarWhenPushed:YES];
         [self.navigationController pushViewController:KDRVC animated:YES];
    }else {
        Home_KDR_SettledIn_ViewController *setVC = [[Home_KDR_SettledIn_ViewController alloc] init];
        [setVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:setVC animated:YES];
    }
}

- (IBAction)MiddleButtonClick:(id)sender {
    Home_KDR_PlaceOrder_ViewController *KDRVC = [[Home_KDR_PlaceOrder_ViewController alloc] init];
    [KDRVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:KDRVC animated:YES];
}

- (IBAction)RightButtonClick:(id)sender {
    Home_KDR_Personal_ViewController *KDRVC = [[Home_KDR_Personal_ViewController alloc] init];
    [KDRVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:KDRVC animated:YES];
}





@end
