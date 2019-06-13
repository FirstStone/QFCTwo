//
//  Mine_SetUP_PersonalData_Nickname_VC.m
//  QFC
//
//  Created by tiaoxin on 2019/6/10.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_SetUP_PersonalData_Nickname_VC.h"

@interface Mine_SetUP_PersonalData_Nickname_VC ()

@property (strong, nonatomic) IBOutlet UIBarButtonItem *Sure_BT;

@property (strong, nonatomic) IBOutlet UITextField *Text_Field;

@end

@implementation Mine_SetUP_PersonalData_Nickname_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.Text_Field.text = self.textStr;
}
- (IBAction)LiftButtonPOP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)SureButtonClick:(id)sender {
    if (self.Text_Field.text.length) {
        if (self.MineSetUPPersonaBlack) {
            self.MineSetUPPersonaBlack(self.Text_Field.text);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else {
        [MBProgressHUD py_showError:@"请输入昵称" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }
}


@end
