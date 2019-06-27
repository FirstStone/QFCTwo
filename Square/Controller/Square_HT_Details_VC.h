//
//  Square_HT_Details_VC.h
//  QFC
//
//  Created by tiaoxin on 2019/4/10.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SquareHTDetailsVCBlock)(void);
@interface Square_HT_Details_VC : UIViewController

@property (nonatomic, strong) NSString *item_id;

@property (nonatomic, copy) SquareHTDetailsVCBlock backBlock;


@end

NS_ASSUME_NONNULL_END
