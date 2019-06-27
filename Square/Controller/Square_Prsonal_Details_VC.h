//
//  Square_Prsonal_Details_VC.h
//  QFC
//
//  Created by tiaoxin on 2019/4/12.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^SquarePrsonalDetailsVCBlock)(void);
@interface Square_Prsonal_Details_VC : UIViewController

@property (nonatomic, strong) NSString *uid;

@property (nonatomic, copy) SquarePrsonalDetailsVCBlock backBlock;

@end

NS_ASSUME_NONNULL_END
