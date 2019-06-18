//
//  Mine_MyOrder_TuiKuang_FooterView.h
//  QFC
//
//  Created by tiaoxin on 2019/6/16.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class Mine_Order_Model;

typedef enum : NSUInteger {
    MyOrderFooterStyleHouseKeeping,
    MyOrderFooterStyleRunErrands,
    MyOrderFooterStyleShop,
}FooterOrderStyle;

@protocol MineMyOrderTuiKuangFooterViewDelegate <NSObject>
/**1为左。2为右*/
- (void)buttonStyle:(NSInteger)index model:(Mine_Order_Model *)model OrderStyle:(OrderStyle)style;

@end

@interface Mine_MyOrder_TuiKuang_FooterView : UITableViewHeaderFooterView

@property (nonatomic, strong) UILabel *Total_Label;

@property (nonatomic, strong) UIButton *Right_BT;

@property (nonatomic, strong) UIButton *Lift_BT;

@property (nonatomic, strong) UIImageView *image_View;

@property (nonatomic, strong) UILabel *Discount_Label;

- (void)setToTotalLabel:(NSString *)Text redText:(NSString *)Price;

@property (nonatomic, assign) id <MineMyOrderTuiKuangFooterViewDelegate> delegate;

@property (nonatomic, assign) FooterOrderStyle OrderCellStyle;

@property (nonatomic, strong) Mine_Order_Model *MyModel;

@end

NS_ASSUME_NONNULL_END
