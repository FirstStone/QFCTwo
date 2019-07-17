//
//  Home_KDR_Address_ViewController.h
//  QFC
//
//  Created by tiaoxin on 2019/7/10.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Basic_ViewController.h"

NS_ASSUME_NONNULL_BEGIN
@class Mine_SetUP_MyAddress_Model;
typedef void(^HomeKDRAddressVCBlack)(Mine_SetUP_MyAddress_Model *model);
@interface Home_KDR_Address_ViewController : Basic_ViewController

@property (nonatomic, copy) HomeKDRAddressVCBlack addressBlock;

@end

NS_ASSUME_NONNULL_END
