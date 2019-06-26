//
//  Mine_SetUP_Feedback_VC.m
//  QFC
//
//  Created by tiaoxin on 2019/4/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_SetUP_Feedback_VC.h"

@interface Mine_SetUP_Feedback_VC ()
@property (strong, nonatomic) IBOutlet YMTextView *Text_View;

@end

@implementation Mine_SetUP_Feedback_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.Text_View.placeholder = @"请输入问题描述，帮助我们更快处理您的反馈~";
    self.Text_View.placeholderColor = QFC_Color_Six;
}
- (IBAction)LiftButtonPOP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)SureButtonclick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
