//
//  Home_Shopping_Cell.h
//  QFC
//
//  Created by tiaoxin on 2019/4/23.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class Home_ShoppingCart_Branch_Model;

@protocol HomeShoppingCellDelegate <NSObject>

- (void)HomeShoppingCellButtonClick:(NSString *)modelid;
/**1 为减 2 为加*/
- (void)HomeShoppingCellSum:(NSString *)modelid State:(NSInteger)state;

@end

@interface Home_Shopping_Cell : UITableViewCell

@property (nonatomic, assign) id <HomeShoppingCellDelegate> delegate;


- (void)setModelToCell:(Home_ShoppingCart_Branch_Model *)model;

@end

NS_ASSUME_NONNULL_END
