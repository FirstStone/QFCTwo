//
//  Mine_SetUPUI_MyAddress_NewAdd_VC.m
//  QFC
//
//  Created by tiaoxin on 2019/4/18.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_SetUPUI_MyAddress_NewAdd_VC.h"

@interface Mine_SetUPUI_MyAddress_NewAdd_VC ()
@property (strong, nonatomic) IBOutlet UIButton *Man_BT;
@property (strong, nonatomic) IBOutlet UIButton *Woman_BT;
@property (strong, nonatomic) IBOutlet UITextField *Address_Field;
@property (strong, nonatomic) IBOutlet UITextField *AddressDetails_Field;
@property (strong, nonatomic) IBOutlet UITextField *Liaison_Field;
@property (strong, nonatomic) IBOutlet UITextField *PhoneNumber_Field;
@property (strong, nonatomic) IBOutlet UIButton *Soure_BT;

@property (nonatomic, assign) NSInteger SureBTStyle;

@property (nonatomic, strong) Mine_SetUP_MyAddress_Model *My_Model;

@end

@implementation Mine_SetUPUI_MyAddress_NewAdd_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.SureBTStyle = 0;
}
- (IBAction)LiftButtonPOP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)manButtonClick:(id)sender {
    self.Man_BT.selected = YES;
    self.Woman_BT.selected = NO;
}
- (IBAction)WomanButtonClick:(id)sender {
    self.Man_BT.selected = NO;
    self.Woman_BT.selected = YES;
}
- (IBAction)AddressToBacker:(id)sender {
    if (!self.Address_Field.text.length) {
        [MBProgressHUD py_showError:@"请输入收获地址" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }else if (!self.AddressDetails_Field.text.length) {
        [MBProgressHUD py_showError:@"请输入详细地址" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }else if (!self.Liaison_Field.text.length) {
        [MBProgressHUD py_showError:@"请输入联系人" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }else if (!self.PhoneNumber_Field.text.length) {
        [MBProgressHUD py_showError:@"请输入手机号" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }else {
        self.Soure_BT.userInteractionEnabled = NO;
        if (self.SureBTStyle == 1) {//地址编辑
            [self EditDataSoureToBacker];
        }else {//新增地址
         [self setDataSoureToBacker];
        }
    }
}
/**
 //收货地址添加
 Route::rule('addressadd/:uid/:longitude/:latitude/:address/:details/:sex/:phone/:realname','index/UserAddresss/addressAdd');
 */
#pragma mark----UPdata
- (void)setDataSoureToBacker {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    
    [parm setObject:self.Address_Field.text forKey:@"address"];
    [parm setObject:self.AddressDetails_Field.text forKey:@"details"];
    if (self.Woman_BT.selected) {
        [parm setObject:@"2" forKey:@"sex"];
    }else {
        [parm setObject:@"1" forKey:@"sex"];
    }
    [parm setObject:self.PhoneNumber_Field.text forKey:@"phone"];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:self.Liaison_Field.text forKey:@"realname"];
    [[HttpRequest sharedInstance] postWithURLString:URL_addressAdd parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showSuccess:@"地址添加成功" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [MBProgressHUD py_showError:@"添加失败" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
        self.Soure_BT.userInteractionEnabled = YES;
    } failure:^(NSError * _Nonnull error) {
        self.Soure_BT.userInteractionEnabled = YES;
        [MBProgressHUD py_showError:@"信息提交失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

/* ('addressup/:id/:uid/:longitude/:latitude/:address/:details/:sex/:phone/:realname','index/UserAddresss/findUpd');
 */
- (void)EditDataSoureToBacker {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:self.My_Model.MyAddress_id forKey:@"id"];
    [parm setObject:self.Address_Field.text forKey:@"address"];
    [parm setObject:self.AddressDetails_Field.text forKey:@"details"];
    if (self.Woman_BT.selected) {
        [parm setObject:@"2" forKey:@"sex"];
    }else {
        [parm setObject:@"1" forKey:@"sex"];
    }
    [parm setObject:self.PhoneNumber_Field.text forKey:@"phone"];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:self.Liaison_Field.text forKey:@"realname"];
    [[HttpRequest sharedInstance] postWithURLString:URL_findUpd parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showSuccess:@"地址修改成功" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [MBProgressHUD py_showError:@"修改失败" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
        self.Soure_BT.userInteractionEnabled = YES;
    } failure:^(NSError * _Nonnull error) {
        self.Soure_BT.userInteractionEnabled = YES;
        [MBProgressHUD py_showError:@"信息提交失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

- (void)setDataSouerToMyaddress:(Mine_SetUP_MyAddress_Model *)model {
    [self loadViewIfNeeded];
    self.Navigation.topItem.title = @"编辑地址";
    self.SureBTStyle = 1;
    self.My_Model = model;
    self.Address_Field.text = model.address;
    self.AddressDetails_Field.text = model.details;
    self.Liaison_Field.text = model.realname;
    self.PhoneNumber_Field.text = model.phone;
    if ([self.My_Model.sex intValue] == 1) {
        self.Man_BT.selected = YES;
        self.Woman_BT.selected = NO;
    } else {
        self.Man_BT.selected = NO;
        self.Woman_BT.selected = YES;
    }
}



@end
