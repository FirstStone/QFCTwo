//
//  Mine_SetUP_MyLabel_VC.m
//  QFC
//
//  Created by tiaoxin on 2019/6/10.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_SetUP_MyLabel_VC.h"

@interface Mine_SetUP_MyLabel_VC ()

@property (strong, nonatomic) IBOutlet UIBarButtonItem *Sure_BT;

@property (strong, nonatomic) IBOutlet UITextField *Text_Field;

@end

@implementation Mine_SetUP_MyLabel_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)LiftButtonPOP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)SureButtonClick:(id)sender {
    if (self.Text_Field.text.length) {
        if (self.MineSetUPBlack) {
            self.MineSetUPBlack(self.Text_Field.text);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else {
        [MBProgressHUD py_showError:@"请输入标签" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }
}

@end
