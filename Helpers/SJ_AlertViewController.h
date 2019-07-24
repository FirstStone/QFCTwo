//
//  SJ_AlertViewController.h
//  QFC
//
//  Created by tiaoxin on 2019/7/22.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SureBTBlock)(NSInteger Type);

typedef enum : NSUInteger {
    SJAlterNoAddress,
    SJAlterNomelAddress,
    SJAlterNotService,
} SJAlertStyle;
@interface SJ_AlertViewController : UIViewController
@property (nonatomic, copy) SureBTBlock SJButtonBlock;

@property (nonatomic, assign) SJAlertStyle SJAlterType;

@property (nonatomic, strong) NSString *VillageName;
@property (nonatomic, strong) NSString *Address;

@end

NS_ASSUME_NONNULL_END
