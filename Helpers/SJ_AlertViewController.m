//
//  SJ_AlertViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/7/22.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "SJ_AlertViewController.h"

@interface SJ_AlertViewController ()

@property (strong, nonatomic) IBOutlet UILabel *Tip_Label;

@property (strong, nonatomic) IBOutlet UILabel *VillageName_Label;
@property (strong, nonatomic) IBOutlet UILabel *Address_Label;

@property (strong, nonatomic) IBOutlet UIImageView *Top_ImageView;
@property (strong, nonatomic) IBOutlet UIButton *Sure_BT;

@property (strong, nonatomic) IBOutlet UIButton *Address_BT;
@property (strong, nonatomic) IBOutlet UIImageView *icon_TwoiamgeView;

@end

@implementation SJ_AlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    switch (self.SJAlterType) {
        case SJAlterNoAddress:
        {
            self.Top_ImageView.image = [UIImage imageNamed:@"icon_KDR_Alter_Nomel"];
            self.Tip_Label.text = @"暂无默认地址";
            self.VillageName_Label.hidden = YES;
            self.Address_Label.hidden = YES;
            self.Sure_BT.hidden = YES;
        }
            break;
        case SJAlterNomelAddress:
        {
            self.VillageName_Label.text = self.VillageName;
            self.Address_Label.text = self.Address;
        }
            break;
        case SJAlterNotService:{
            self.icon_TwoiamgeView.hidden = NO;
            self.Top_ImageView.hidden = YES;
            self.Tip_Label.text = @"您所在的小区暂无服务人员";
            self.VillageName_Label.hidden = YES;
            self.Address_Label.text = @"邀请服务人员入驻，即可获的邀请大礼包";
            [self.Sure_BT setTitle:@"前往邀请" forState:UIControlStateNormal];
            self.Address_BT.hidden = YES;
        }
            break;
        default:
            break;
    }
}

- (IBAction)PoPButtonClick:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (IBAction)SureButtonClick:(id)sender {
    if (self.SJButtonBlock) {
        self.SJButtonBlock(1);
    }
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)AddressButtonClick:(id)sender {
    if (self.SJButtonBlock) {
        self.SJButtonBlock(2);
    }
    [self dismissViewControllerAnimated:NO completion:nil];
}



@end
