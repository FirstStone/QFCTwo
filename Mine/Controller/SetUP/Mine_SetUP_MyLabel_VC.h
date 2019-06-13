//
//  Mine_SetUP_MyLabel_VC.h
//  QFC
//
//  Created by tiaoxin on 2019/6/10.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Basic_ViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^MineSetUPMyLabelVCBlack)(NSString *TextStr);
@interface Mine_SetUP_MyLabel_VC : Basic_ViewController

@property (nonatomic, strong) NSString *textStr;

@property (nonatomic, copy) MineSetUPMyLabelVCBlack MineSetUPBlack;

@end

NS_ASSUME_NONNULL_END
