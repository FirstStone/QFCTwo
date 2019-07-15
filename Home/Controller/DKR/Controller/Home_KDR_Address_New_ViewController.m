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

@end

@implementation Home_KDR_Address_New_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.Village_Field.delegate = self;
}

- (IBAction)LiftBtuuonPOP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)AddressToBacker:(id)sender {
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    Publish_Location_VC *LocationVC = [[Publish_Location_VC alloc] init];
    LocationVC.Number = 1;
    MJWeakSelf;
    LocationVC.PublishLocationVCBlock = ^(NSString * _Nonnull Address, NSString * _Nonnull lat, NSString * _Nonnull longStr, NSString * _Nonnull name, NSString * _Nonnull province, NSString * _Nonnull city, NSString * _Nonnull district) {
        //        [weakSelf.Sure_parm setObject:Address forKey:@"address"];
        //        [weakSelf.Sure_parm setObject:longStr forKey:@"longitude"];
        //        [weakSelf.Sure_parm setObject:lat forKey:@"latitude"];
        weakSelf.Village_Field.text = Address;
    };
    [self.navigationController pushViewController:LocationVC animated:YES];
    return NO;
}

@end
