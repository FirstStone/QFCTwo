//
//  Mine_SetUPUI_MyAddress_NewAdd_VC.h
//  QFC
//
//  Created by tiaoxin on 2019/4/18.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Mine_SetUPUI_MyAddress_NewAdd_VC : UIViewController
@property (strong, nonatomic) IBOutlet UINavigationBar *Navigation;

- (void)setDataSouerToMyaddress:(Mine_SetUP_MyAddress_Model *)model;

@end

NS_ASSUME_NONNULL_END
