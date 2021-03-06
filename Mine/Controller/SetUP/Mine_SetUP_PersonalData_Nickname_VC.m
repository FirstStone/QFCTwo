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
    if (self.Number == 1) {
        self.Navigation.topItem.title = @"修改店铺名称";
        self.Text_Field.placeholder = @"请输入店铺名称";
    }else if (self.Number == 2) {
        self.Navigation.topItem.title = @"修改联系方式";
        self.Text_Field.placeholder = @"请输电话号";
        self.Text_Field.keyboardType = UIKeyboardTypeNumberPad;
    }else if (self.Number == 3) {
        self.Navigation.topItem.title = @"修改经营范围";
        self.Text_Field.placeholder = @"请输入经营类目逗号隔开";
    }else if (self.Number == 4){
        self.Navigation.topItem.title = @"我的标签";
        self.Text_Field.placeholder = @"请输入标签逗号隔开";
    }else if (self.Number == 5) {
        self.Navigation.topItem.title = @"修改姓名";
        self.Text_Field.placeholder = @"请输入姓名";
    }else if (self.Number == 6){
        self.Navigation.topItem.title = @"修改年龄";
        self.Text_Field.placeholder = @"请输入年龄";
        self.Text_Field.keyboardType = UIKeyboardTypeNumberPad;
    }
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
        [MBProgressHUD py_showError:@"请输入修改信息" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }
}


@end
