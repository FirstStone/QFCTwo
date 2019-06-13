//
//  Square_HT_Details_Seach_VC.m
//  QFC
//
//  Created by tiaoxin on 2019/4/12.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Square_HT_Details_Seach_VC.h"

@interface Square_HT_Details_Seach_VC ()

@end

@implementation Square_HT_Details_Seach_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)LeftButtonClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
