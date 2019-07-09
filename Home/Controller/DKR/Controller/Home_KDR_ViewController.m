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

@end

@implementation Home_KDR_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)LiftBtuuonPOP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)LiftButtonClick:(id)sender {
    
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
