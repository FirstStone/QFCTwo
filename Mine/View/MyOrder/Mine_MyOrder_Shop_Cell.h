//
//  Mine_MyOrder_Shop_Cell.h
//  QFC
//
//  Created by tiaoxin on 2019/4/22.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class Message_Shoping_Branch_Model;
@class Mine_Order_Details_Model;

@interface Mine_MyOrder_Shop_Cell : UITableViewCell

- (void)setDataSoureToCell:(Message_Shoping_Branch_Model *)model runPrice:(NSString *)runPrice YouhuiPrice:(NSString *)YHPrice;

@end

NS_ASSUME_NONNULL_END
