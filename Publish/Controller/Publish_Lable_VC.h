//
//  Publish_Lable_VC.h
//  QFC
//
//  Created by tiaoxin on 2019/4/12.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^PublishLableVCBlock)(NSString *LabelString);

@interface Publish_Lable_VC : UIViewController


@property (nonatomic, copy) PublishLableVCBlock publickBlock;

@end

NS_ASSUME_NONNULL_END
