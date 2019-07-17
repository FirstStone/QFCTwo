//
//  Home_KDR_Address_New_ViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/7/10.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_KDR_Address_New_ViewController.h"

@interface Home_KDR_Address_New_ViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *Name_Field;

@property (strong, nonatomic) IBOutlet UITextField *Phone_Field;

@property (strong, nonatomic) IBOutlet UITextField *Village_Field;

@property (strong, nonatomic) IBOutlet UITextField *Detailed_Field;

@property (strong, nonatomic) IBOutlet UIButton *Sure_BT;

@property (strong, nonatomic) IBOutlet UINavigationBar *navigationBar;

@property (nonatomic, strong) NSMutableDictionary *parm;

@property (nonatomic, assign) NSInteger SureBTStyle;

@property (nonatomic, strong) Mine_SetUP_MyAddress_Model *My_Model;

@end

@implementation Home_KDR_Address_New_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.SureBTStyle = 0;
    self.Village_Field.delegate = self;
}

- (IBAction)LiftBtuuonPOP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)AddressToBacker:(id)sender {
    self.Sure_BT.userInteractionEnabled = NO;
    if (self.SureBTStyle) {
        [self POSTWasteAddressAddressUps];
    }else {
        [self POSTWasteAddressAddressAdds];
    }
    
}

- (NSMutableDictionary *)parm {
    if (!_parm) {
        _parm = [[NSMutableDictionary alloc] init];
    }
    return _parm;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
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
     */
    [self.parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [self.parm setObject:self.Detailed_Field.text forKey:@"details"];
    [self.parm setObject:self.Name_Field.text forKey:@"realname"];
    [self.parm setObject:self.Phone_Field.text forKey:@"phone"];
    [[HttpRequest sharedInstance] postWithURLString:URL_WasteAddressAddressAdds parameters:self.parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        self.Sure_BT.userInteractionEnabled = YES;
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showSuccess:@"添加成功" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
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
}

@end
