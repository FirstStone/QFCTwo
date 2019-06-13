//
//  Mine_SettledIn_ViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/4/24.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_SettledIn_ViewController.h"

@interface Mine_SettledIn_ViewController ()
@property (strong, nonatomic) IBOutlet UIButton *RunErrands_BT;
@property (strong, nonatomic) IBOutlet UIButton *Housekeeping_BT;
@property (strong, nonatomic) IBOutlet UIButton *Shoping_BT;
@property (strong, nonatomic) IBOutlet UIButton *Sure_BT;




@end

@implementation Mine_SettledIn_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)LiftButtonPOP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)RunErrandsButtonClick:(id)sender {
    self.RunErrands_BT.selected = YES;
    self.RunErrands_BT.backgroundColor = QFC_Color_30AC65;
    self.RunErrands_BT.layer.borderWidth = 0.0f;
    
    self.Housekeeping_BT.selected = NO;
    self.Housekeeping_BT.backgroundColor = QFC_Color_F5F5F5;
    self.Housekeeping_BT.layer.borderWidth = 1.0f;
    self.Shoping_BT.selected = NO;
    self.Shoping_BT.backgroundColor = QFC_Color_F5F5F5;
    self.Shoping_BT.layer.borderWidth = 1.0f;
}
- (IBAction)HousekeepingButtonClick:(id)sender {
    self.RunErrands_BT.selected = NO;
    self.RunErrands_BT.backgroundColor = QFC_Color_F5F5F5;
    self.RunErrands_BT.layer.borderWidth = 1.0f;
    
    self.Housekeeping_BT.selected = YES;
    self.Housekeeping_BT.backgroundColor = QFC_Color_30AC65;
    self.Housekeeping_BT.layer.borderWidth = 0.0f;
    self.Shoping_BT.selected = NO;
    self.Shoping_BT.backgroundColor = QFC_Color_F5F5F5;
    self.Shoping_BT.layer.borderWidth = 1.0f;
}
- (IBAction)ShopingButtonClick:(id)sender {
    self.RunErrands_BT.selected = NO;
    self.RunErrands_BT.backgroundColor = QFC_Color_F5F5F5;
    self.RunErrands_BT.layer.borderWidth = 1.0f;
    
    self.Housekeeping_BT.selected = NO;
    self.Housekeeping_BT.backgroundColor = QFC_Color_F5F5F5;
    self.Housekeeping_BT.layer.borderWidth = 1.0f;
    self.Shoping_BT.selected = YES;
    self.Shoping_BT.backgroundColor = QFC_Color_30AC65;
    self.Shoping_BT.layer.borderWidth = 0.0f;
}
- (IBAction)SureButtonClick:(id)sender {
    if (self.Shoping_BT.selected) {
        Mine_SettledIn_Shoping_ViewController * shopingVC= [[Mine_SettledIn_Shoping_ViewController alloc] init];
        [shopingVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:shopingVC animated:YES];
    }else if (self.Housekeeping_BT.selected) {
        Mine_SettledIn_Housekeeping_ViewController * housekeepingVC = [[Mine_SettledIn_Housekeeping_ViewController alloc] init];
        [housekeepingVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:housekeepingVC animated:YES];
    }else {
        Mine_SettledIn_RunErrands_ViewController * runErrandsVC = [[Mine_SettledIn_RunErrands_ViewController alloc] init];
        [runErrandsVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:runErrandsVC animated:YES];
    }
}



@end
