//
//  Mine_Wallet_Recharge_ViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/4/24.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_Wallet_Recharge_ViewController.h"

@interface Mine_Wallet_Recharge_ViewController ()
@property (strong, nonatomic) IBOutlet UITextField *Price_Label;

@property (strong, nonatomic) IBOutlet UIView *Apliay_View;

@property (strong, nonatomic) IBOutlet UIView *WXPay_View;

@property (strong, nonatomic) IBOutlet UIButton *Sure_BT;

@property (strong, nonatomic) IBOutlet UIButton *Apliay_BT;

@property (strong, nonatomic) IBOutlet UIButton *WXPay_BT;

@end

@implementation Mine_Wallet_Recharge_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *ApliayZer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ApliayZer:)];
    [self.Apliay_View addGestureRecognizer:ApliayZer];
    UITapGestureRecognizer *WXpayZer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(WXpayZer:)];
    [self.WXPay_View addGestureRecognizer:WXpayZer];
}
- (IBAction)LiftButtonPOP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)ApliayZer:(UIGestureRecognizer *)zer {
    self.Apliay_BT.selected = YES;;
    self.WXPay_BT.selected = NO;
}

- (void)WXpayZer:(UIGestureRecognizer *)zer {
    self.Apliay_BT.selected = NO;;
    self.WXPay_BT.selected = YES;
}



@end
