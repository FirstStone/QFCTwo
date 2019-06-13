//
//  HomeRunErrandsOrderCell.h
//  QFC
//
//  Created by tiaoxin on 2019/5/9.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol HomeRunErrandsOrderCellDelegate <NSObject>

- (void)HomeRunErrandsOrderCellEditButtonClick:(Mine_SetUP_MyAddress_Model *)modle button:(UIButton *)BT;
- (void)HomeRunErrandsOrderCellDelectButtonClick:(Mine_SetUP_MyAddress_Model *)modle button:(UIButton *)BT;



@end
@interface HomeRunErrandsOrderCell : UITableViewCell

- (void)setModelToCell:(Mine_SetUP_MyAddress_Model *)model;

@property (nonatomic, assign) id <HomeRunErrandsOrderCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
