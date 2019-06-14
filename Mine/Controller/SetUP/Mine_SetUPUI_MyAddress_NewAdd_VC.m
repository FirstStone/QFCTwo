//
//  Mine_SetUPUI_MyAddress_NewAdd_VC.m
//  QFC
//
//  Created by tiaoxin on 2019/4/18.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_SetUPUI_MyAddress_NewAdd_VC.h"

@interface Mine_SetUPUI_MyAddress_NewAdd_VC ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIButton *Man_BT;
@property (strong, nonatomic) IBOutlet UIButton *Woman_BT;
@property (strong, nonatomic) IBOutlet UITextField *Address_Field;
@property (strong, nonatomic) IBOutlet UITextField *AddressDetails_Field;
@property (strong, nonatomic) IBOutlet UITextField *Liaison_Field;
@property (strong, nonatomic) IBOutlet UITextField *PhoneNumber_Field;
@property (strong, nonatomic) IBOutlet UIButton *Soure_BT;

@property (nonatomic, assign) NSInteger SureBTStyle;

@property (nonatomic, strong) Mine_SetUP_MyAddress_Model *My_Model;

@property (nonatomic, strong) NSMutableDictionary *Sure_parm;

@end

@implementation Mine_SetUPUI_MyAddress_NewAdd_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.SureBTStyle = 0;
    self.Address_Field.delegate = self ;
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

- (NSMutableDictionary *)Sure_parm {
    if (!_Sure_parm) {
        _Sure_parm = [[NSMutableDictionary alloc] init];
    }
    return _Sure_parm;
}
/**
 //收货地址添加
 Route::rule('addressadd/:uid/:longitude/:latitude/:address/:details/:sex/:phone/:realname','index/UserAddresss/addressAdd');
 */
#pragma mark----UPdata
- (void)setDataSoureToBacker {
    [self.Sure_parm setObject:self.AddressDetails_Field.text forKey:@"details"];
    if (self.Woman_BT.selected) {
        [self.Sure_parm setObject:@"2" forKey:@"sex"];
    }else {
        [self.Sure_parm setObject:@"1" forKey:@"sex"];
    }
    [self.Sure_parm setObject:self.PhoneNumber_Field.text forKey:@"phone"];
    [self.Sure_parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [self.Sure_parm setObject:self.Liaison_Field.text forKey:@"realname"];
    [[HttpRequest sharedInstance] postWithURLString:URL_addressAdd parameters:self.Sure_parm success:^(NSDictionary * _Nonnull responseObject) {
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
    [self.Sure_parm setObject:self.My_Model.MyAddress_id forKey:@"id"];
    [self.Sure_parm setObject:self.AddressDetails_Field.text forKey:@"details"];
    if (self.Woman_BT.selected) {
        [self.Sure_parm setObject:@"2" forKey:@"sex"];
    }else {
        [self.Sure_parm setObject:@"1" forKey:@"sex"];
    }
    [self.Sure_parm setObject:self.PhoneNumber_Field.text forKey:@"phone"];
    [self.Sure_parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [self.Sure_parm setObject:self.Liaison_Field.text forKey:@"realname"];
    [[HttpRequest sharedInstance] postWithURLString:URL_findUpd parameters:self.Sure_parm success:^(NSDictionary * _Nonnull responseObject) {
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
#pragma mark----UITextFieldDelegate
/** ('addressadd/:uid/:longitude/:latitude/:address/:details/:sex/:phone/:realname','index/UserAddresss/addressAdd');
 */
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    Publish_Location_VC *LocationVC = [[Publish_Location_VC alloc] init];
    MJWeakSelf;
    LocationVC.PublishLocationVCBlock = ^(NSString * _Nonnull Address, NSString * _Nonnull lat, NSString * _Nonnull longStr) {
        [weakSelf.Sure_parm setObject:Address forKey:@"address"];
        [weakSelf.Sure_parm setObject:longStr forKey:@"longitude"];
        [weakSelf.Sure_parm setObject:lat forKey:@"latitude"];
        textField.text = Address;
    };
    [self.navigationController pushViewController:LocationVC animated:YES];
    return NO;
}


@end
