//
//  Home_KDR_Address_New_ViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/7/10.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_KDR_Address_New_ViewController.h"

@interface Home_KDR_Address_New_ViewController ()<UITextFieldDelegate, PickerViewResultDelegate>

@property (strong, nonatomic) IBOutlet UITextField *Name_Field;

@property (strong, nonatomic) IBOutlet UITextField *Phone_Field;

@property (strong, nonatomic) IBOutlet UITextField *Village_Field;

@property (strong, nonatomic) IBOutlet UITextField *Detailed_Field;

@property (strong, nonatomic) IBOutlet UITextField *Floor_Field;


@property (strong, nonatomic) IBOutlet UIButton *Sure_BT;

@property (strong, nonatomic) IBOutlet UINavigationBar *navigationBar;

@property (nonatomic, strong) NSMutableDictionary *parm;

@property (nonatomic, assign) NSInteger SureBTStyle;

@property (nonatomic, strong) Mine_SetUP_MyAddress_Model *My_Model;

@property (strong, nonatomic) IBOutlet UIButton *LT_BT;
@property (strong, nonatomic) IBOutlet UIButton *DT_BT;
@property (strong, nonatomic) IBOutlet UIView *LC_View;


@end

@implementation Home_KDR_Address_New_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.Floor_Field.delegate = self;
    self.SureBTStyle = 0;
    self.Village_Field.delegate = self;
}

- (IBAction)LiftBtuuonPOP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)AddressToBacker:(id)sender {
    if (!self.Name_Field.text.length) {
        [MBProgressHUD py_showError:@"请填写姓名" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
        return;
    }else if (!self.Name_Field.text.length) {
        [MBProgressHUD py_showError:@"请填写电话" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
        return;
    }else if (!self.Village_Field.text.length) {
        [MBProgressHUD py_showError:@"请选择小区" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
        return;
    }else if (!self.Detailed_Field.text.length) {
        [MBProgressHUD py_showError:@"请填写详细地址" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
        return;
    }
    if (self.SureBTStyle) {
        if (self.LT_BT.isSelected) {
            [self.parm setObject:@"1" forKey:@"elevator"];
        }else {
            if ([self.Floor_Field.text intValue]) {
                [self.parm setObject:self.Floor_Field.text forKey:@"floor"];
            }else {
                [MBProgressHUD py_showError:@"请填写楼层" toView:nil];
                [MBProgressHUD setAnimationDelay:0.7f];
                return;
            }
            [self.parm setObject:@"2" forKey:@"elevator"];
        }
        self.Sure_BT.userInteractionEnabled = NO;
        [self POSTWasteAddressAddressUps];
    }else {
        if (self.LT_BT.isSelected) {
            [self.parm setObject:@"1" forKey:@"elevator"];
        }else {
            if ([self.Floor_Field.text intValue]) {
                [self.parm setObject:self.Floor_Field.text forKey:@"floor"];
            }else {
                [MBProgressHUD py_showError:@"请填写楼层" toView:nil];
                [MBProgressHUD setAnimationDelay:0.7f];
                return;
            }
            [self.parm setObject:@"2" forKey:@"elevator"];
        }
        self.Sure_BT.userInteractionEnabled = NO;
        [self POSTWasteAddressAddressAdds];
    }
    
}
- (IBAction)LTButtonClick:(id)sender {
//    self.LT_BT.layer.cornerRadius
    self.LT_BT.selected = YES;
    self.DT_BT.selected = NO;
    self.LC_View.hidden = YES;
    self.LT_BT.backgroundColor = QFC_Color_30AC65;
    self.DT_BT.backgroundColor = QFC_Color_F5F5F5;
}
- (IBAction)DTButtonClick:(id)sender {
    self.LT_BT.selected = NO;
    self.DT_BT.selected = YES;
    self.LC_View.hidden = NO;
    self.LT_BT.backgroundColor = QFC_Color_F5F5F5;
    self.DT_BT.backgroundColor = QFC_Color_30AC65;
}



- (NSMutableDictionary *)parm {
    if (!_parm) {
        _parm = [[NSMutableDictionary alloc] init];
    }
    return _parm;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField.tag == 383883) {
        [self textFieldEditState];
        PickerView *pick = [[PickerView alloc] init];
        pick.delegate = self;
        pick.type = PickerViewTypeFloor;
        [self.view addSubview:pick];
        return NO;
    }else {
        Publish_Location_VC *LocationVC = [[Publish_Location_VC alloc] init];
        LocationVC.Number = 1;
        MJWeakSelf;
        LocationVC.PublishLocationVCBlock = ^(NSString * _Nonnull Address, NSString * _Nonnull lat, NSString * _Nonnull longStr, NSString * _Nonnull name, NSString * _Nonnull province, NSString * _Nonnull city, NSString * _Nonnull district) {
            [weakSelf.parm setObject:Address forKey:@"address"];
            [weakSelf.parm setObject:name forKey:@"village"];
            [weakSelf.parm setObject:province forKey:@"province"];
            [weakSelf.parm setObject:city forKey:@"city"];
            [weakSelf.parm setObject:district forKey:@"county"];
            [weakSelf.parm setObject:longStr forKey:@"longitude"];
            [weakSelf.parm setObject:lat forKey:@"latitude"];
            weakSelf.Village_Field.text = name;
        };
        [self.navigationController pushViewController:LocationVC animated:YES];
        return NO;
    }
}

#pragma mark----PickerViewResultDelegate
- (void)pickerView:(UIView *)pickerView result:(NSString *)string {
    self.Floor_Field.text = string;
}

- (void)textFieldEditState {
    [self.Name_Field resignFirstResponder];
    [self.Phone_Field resignFirstResponder];
    [self.Village_Field resignFirstResponder];
    [self.Detailed_Field resignFirstResponder];
    [self.Detailed_Field resignFirstResponder];
}

- (void)POSTWasteAddressAddressUps {
    /**
     地址修改
     waste/address/addressUps
     addressid
     uid
     details    详细地址
     realname      姓名
     phone       手机号
     address      定位地址
     village       小区
     province         省
     city        市
     county;            县/区
     latitude;
     longitude
     */
    [self.parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [self.parm setObject:self.Detailed_Field.text forKey:@"details"];
    [self.parm setObject:self.Name_Field.text forKey:@"realname"];
    [self.parm setObject:self.Phone_Field.text forKey:@"phone"];
    [[HttpRequest sharedInstance] postWithURLString:URL_wasteAddressAddressUps parameters:self.parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        self.Sure_BT.userInteractionEnabled = YES;
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showSuccess:@"修改成功" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [MBProgressHUD py_showError:@"操作失败" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
    } failure:^(NSError * _Nonnull error) {
        self.Sure_BT.userInteractionEnabled = YES;
        [MBProgressHUD py_showError:@"修改失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

- (void)POSTWasteAddressAddressAdds {
    /**
     waste/address/addressAdds
     uid
     details    详细地址
     realname      姓名
     phone       手机号
     address      定位地址
     village       小区
     province         省
     city        市
     county;            县/区
     latitude;
     longitude
     elevator 1电梯楼2无电梯
     floor  多少层
     */
    [self.parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [self.parm setObject:self.Detailed_Field.text forKey:@"details"];
    [self.parm setObject:self.Name_Field.text forKey:@"realname"];
    [self.parm setObject:self.Phone_Field.text forKey:@"phone"];
    [[HttpRequest sharedInstance] postWithURLString:URL_WasteAddressAddressAdds parameters:self.parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        self.Sure_BT.userInteractionEnabled = YES;
        if ([[responseObject objectForKey:@"status"] intValue] == 1) {
            [MBProgressHUD py_showSuccess:@"添加成功" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            [self.navigationController popViewControllerAnimated:YES];
        }else if ([[responseObject objectForKey:@"status"] intValue] == 2) {
            MJWeakSelf;
            SJ_AlertViewController *alterVC = [[SJ_AlertViewController alloc] init];
            alterVC.SJAlterType = SJAlterNotService;
            alterVC.SJButtonBlock = ^(NSInteger Type) {
                if(Type == 1) {
                    Home_KDR_InvitationViewController *invitationVC = [[Home_KDR_InvitationViewController alloc] init];
                    [invitationVC setHidesBottomBarWhenPushed:YES];
                    [weakSelf.navigationController pushViewController:invitationVC animated:YES];
                }
            };
            alterVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            [self presentViewController:alterVC animated:NO completion:Nil];
        } else {
            [MBProgressHUD py_showError:@"操作失败" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
    } failure:^(NSError * _Nonnull error) {
        self.Sure_BT.userInteractionEnabled = YES;
        [MBProgressHUD py_showError:@"添加失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}


- (void)setDataSouerToMyaddress:(Mine_SetUP_MyAddress_Model *)model {
    [self loadViewIfNeeded];
    self.navigationBar.topItem.title = @"编辑地址";
    self.SureBTStyle = 1;
    self.My_Model = model;
    [self.parm setObject:model.MyAddress_id forKey:@"addressid"];
    [self.parm setObject:model.address forKey:@"address"];
    [self.parm setObject:model.village forKey:@"village"];
    [self.parm setObject:model.province forKey:@"province"];
    [self.parm setObject:model.city forKey:@"city"];
    [self.parm setObject:model.county forKey:@"county"];
    [self.parm setObject:model.longitude forKey:@"longitude"];
    [self.parm setObject:model.latitude forKey:@"latitude"];
    self.Name_Field.text = model.realname;
    self.Phone_Field.text = model.phone;
    self.Village_Field.text = model.village;
    self.Detailed_Field.text = model.details;
    if ([model.elevator intValue] == 2) {//无电梯
        self.DT_BT.selected = YES;
        self.LT_BT.backgroundColor = QFC_Color_F5F5F5;
        self.DT_BT.backgroundColor = QFC_Color_30AC65;
        self.Floor_Field.text = model.floor;
        self.LC_View.hidden = NO;
    }else {
        self.LT_BT.selected = YES;
        self.LT_BT.backgroundColor = QFC_Color_30AC65;
        self.DT_BT.backgroundColor = QFC_Color_F5F5F5;
        self.LC_View.hidden = YES;
    }
}

@end
