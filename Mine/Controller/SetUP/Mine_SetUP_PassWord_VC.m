//
//  Mine_SetUP_PassWord_VC.m
//  QFC
//
//  Created by tiaoxin on 2019/6/11.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_SetUP_PassWord_VC.h"

@interface Mine_SetUP_PassWord_VC ()

@property (strong, nonatomic) IBOutlet UITextField *Phone_Field;

@property (strong, nonatomic) IBOutlet UITextField *Code_Field;

@property (strong, nonatomic) IBOutlet UIButton *Code_BT;

@property (strong, nonatomic) IBOutlet UITextField *PassWord_Field;

@property (strong, nonatomic) IBOutlet UIButton *Sure_BT;


@end

@implementation Mine_SetUP_PassWord_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self POSTIndexUsersFindPhone];
}

- (IBAction)SureButtonClick:(id)sender {
    if (self.Code_Field.text.length == 0) {
        [MBProgressHUD py_showError:@"请输入验证码" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
        
    }else if (self.PassWord_Field.text.length == 0){
        [MBProgressHUD py_showError:@"请输入密码" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }else {
        [self LoadingDataSoure];
    }
}


- (IBAction)LiftButtonPOP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)CodeButtonClick:(id)sender {
    if (!self.Phone_Field.text.length) {
        [MBProgressHUD py_showError:@"请输入手机号" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
        return;
    }
    /**
     修改信息发送验证码
     URL : https://www.txkuaiyou.com/index/note/UpdateNote
     参数 :
     uid
     用户ID
     */
    NSMutableDictionary * parm = [[NSMutableDictionary alloc]init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    
    [[HttpRequest sharedInstance] postWithURLString:URL_note_UpdateNote parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [self openCountdown];
            [MBProgressHUD py_showError:@"验证码已发送请注意查收" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }else {
            [MBProgressHUD py_showError:@"发送失败" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"发送失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}



- (void)openCountdown{
    
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //self.VerificationCode_button.siz
                //设置按钮的样式
                [self.Code_BT setTitle:@"发送验证码" forState:UIControlStateNormal];
                self.Code_BT.userInteractionEnabled = YES;
            });
            
        }else{
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮显示读秒效果
                [self.Code_BT setTitle:[NSString stringWithFormat:@"%.2d秒", seconds] forState:UIControlStateNormal];
                self.Code_BT.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
    
}

#pragma mark----UPdata
- (void)LoadingDataSoure {
    /**
     密码修改
     URL : https://www.txkuaiyou.com/index/centres/Upassword
     参数 :
     password
     密码
     note
     验证码
     uid
     用户ID
     */
    self.Sure_BT.userInteractionEnabled = NO;
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:self.PassWord_Field.text forKey:@"password"];
    [parm setObject:self.Code_Field.text forKey:@"note"];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_centres_Upassword parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showError:@"修改成功" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [MBProgressHUD py_showError:@"修改失败" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
        self.Sure_BT.userInteractionEnabled = YES;
    } failure:^(NSError * _Nonnull error) {
        self.Sure_BT.userInteractionEnabled = YES;
        [MBProgressHUD py_showError:@"操作失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}


- (void)POSTIndexUsersFindPhone {
    /**
     index/users/findPhone
     uid
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_indexUsersFindPhone parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSDictionary *dataSoure = [responseObject objectForKey:@"info"];
            if (dataSoure) {
                self.Phone_Field.text = [dataSoure objectForKey:@"phone"];
            }
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"获取失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

@end
