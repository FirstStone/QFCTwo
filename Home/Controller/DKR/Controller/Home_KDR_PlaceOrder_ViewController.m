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

@property (nonatomic, strong) NSString *Addressid;

@end

@implementation Home_KDR_PlaceOrder_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.Lift_BT.hidden = !self.LiftBT_State;
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
    
}

- (IBAction)RightButtonClick:(id)sender {
    
}

- (IBAction)AddressButtonClick:(id)sender {
    
}

- (void)POSTWasteOrderExperience {
    /**
     waste/order/experience
     uid
     addressid
     免费预约
     */
    
    
    
}



@end
