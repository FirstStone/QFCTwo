//
//  Home_KDR_idea_ViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/7/23.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_KDR_idea_ViewController.h"

@interface Home_KDR_idea_ViewController ()
@property (strong, nonatomic) IBOutlet UITextView *Text_View;
@property (strong, nonatomic) IBOutlet UITextField *Phone_Field;
@property (strong, nonatomic) IBOutlet UIButton *Sure_BT;


@end

@implementation Home_KDR_idea_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)SureButtonClick:(id)sender {
    if (self.Text_View.text.length) {
        [self POSTWasteUsersFeedback];
    }else{
        [MBProgressHUD py_showError:@"请填写意见" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }
}
- (IBAction)LiftBtuuonPOP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark----UPdata
- (void)POSTWasteUsersFeedback {
    /**
     waste/users/feedback
     uid
     content   内容
     phone  手机号
     回馈
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:self.Text_View.text forKey:@"content"];
    [parm setObject:self.Phone_Field.text forKey:@"phone"];
    [[HttpRequest sharedInstance] postWithURLString:URL_WasteUsersFeedback parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showError:[responseObject objectForKey:@"message"] toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [MBProgressHUD py_showError:[responseObject objectForKey:@"message"] toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:[NSString stringWithFormat:@"加载失败(%ld)", error.code] toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}


@end
