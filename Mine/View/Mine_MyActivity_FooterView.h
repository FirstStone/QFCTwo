//
//  Mine_MyActivity_FooterView.h
//  QFC
//
//  Created by tiaoxin on 2019/6/6.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class Mine_MyActivity_Model;
@protocol MineMyActivityFooterViewDelegate <NSObject>

- (void)MineMyActivityFooterViewDelectButtonClick:(Mine_MyActivity_Model *)model;

@end

@interface Mine_MyActivity_FooterView : UITableViewHeaderFooterView

@property (nonatomic, strong) UILabel *Text_Label;

@property (nonatomic, strong) UIButton *Delect_BT;

@property (nonatomic, strong) Mine_MyActivity_Model *Mymodel;

@property (nonatomic, assign) id <MineMyActivityFooterViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
