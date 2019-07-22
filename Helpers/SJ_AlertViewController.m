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
