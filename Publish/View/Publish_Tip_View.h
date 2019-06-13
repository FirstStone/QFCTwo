//
//  Publish_Tip_View.h
//  QFC
//
//  Created by tiaoxin on 2019/4/9.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PublishTipViewDelegate <NSObject>

- (void)PublishTipViewButtonClick:(NSInteger)index;

@end

@interface Publish_Tip_View : UIView

@property (nonatomic, strong) CustomBT *QB_BT;

@property (nonatomic, strong) CustomBT *GC_BT;

@property (nonatomic, strong) CustomBT *ZY_BT;

@property (nonatomic, strong) CustomBT *ZJ_BT;

@property (nonatomic, strong) UILabel *Text_Label;

@property (nonatomic, assign) id <PublishTipViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
