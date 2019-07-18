//
//  Home_KDR_OrderState_ViewController.h
//  QFC
//
//  Created by tiaoxin on 2019/7/11.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Basic_ViewController.h"

NS_ASSUME_NONNULL_BEGIN
@interface Home_KDR_OrderState_ViewController : Basic_ViewController

@property (nonatomic, assign) NSInteger Number;
/**0 代接单 1 代服务 2 已完成*/
@property (nonatomic, assign) NSInteger State;

@property (nonatomic, strong) NSString *orderid;

@end

NS_ASSUME_NONNULL_END
