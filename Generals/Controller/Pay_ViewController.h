//
//  Pay_ViewController.h
//  QFC
//
//  Created by tiaoxin on 2019/5/14.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Basic_ViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    PayViewControllerDefault,
    PayViewControllerKDR,
} PayViewControllerStyle;
@interface Pay_ViewController : Basic_ViewController

@property (nonatomic, strong) NSString *OrderID;
/**1 二次付款*/
@property (nonatomic, assign) NSInteger Number;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) PayViewControllerStyle PayStyle;

@end

NS_ASSUME_NONNULL_END
