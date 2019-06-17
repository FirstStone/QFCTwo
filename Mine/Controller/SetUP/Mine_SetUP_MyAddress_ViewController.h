//
//  Mine_SetUP_MyAddress_ViewController.h
//  QFC
//
//  Created by tiaoxin on 2019/4/18.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Basic_ViewController.h"

NS_ASSUME_NONNULL_BEGIN
@class Mine_SetUP_MyAddress_Model;

typedef void(^GetMineSetUPMyAddressBlock)(Mine_SetUP_MyAddress_Model *model);
@interface Mine_SetUP_MyAddress_ViewController : Basic_ViewController

@property (nonatomic, copy) GetMineSetUPMyAddressBlock MineSetUPMyAddressBlock;

@end

NS_ASSUME_NONNULL_END
