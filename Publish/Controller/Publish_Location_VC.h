//
//  Publish_Location_VC.h
//  QFC
//
//  Created by tiaoxin on 2019/4/12.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^PublishLocationVCSelect)(NSString *Address, NSString *lat, NSString *longStr);

@interface Publish_Location_VC : UIViewController

@property (nonatomic, copy) PublishLocationVCSelect PublishLocationVCBlock;

@property (nonatomic, assign) NSInteger Number;

@end

NS_ASSUME_NONNULL_END
