//
//  Mine_SetUP_Feedback_VC.m
//  QFC
//
//  Created by tiaoxin on 2019/4/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_SetUP_Feedback_VC.h"

@interface Mine_SetUP_Feedback_VC ()

@end

@implementation Mine_SetUP_Feedback_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)LiftButtonPOP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)SureButtonclick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
