//
//  Home_HouseKeeping_PlaceOrder_AddressTimeCell.m
//  QFC
//
//  Created by tiaoxin on 2019/5/10.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_HouseKeeping_PlaceOrder_AddressTimeCell.h"

@interface Home_HouseKeeping_PlaceOrder_AddressTimeCell ()

@property (strong, nonatomic) IBOutlet UILabel *Address_Label;

@property (strong, nonatomic) IBOutlet UILabel *Time_Label;
@property (strong, nonatomic) IBOutlet UIView *Address_View;
@property (strong, nonatomic) IBOutlet UIView *Time_View;

@end

@implementation Home_HouseKeeping_PlaceOrder_AddressTimeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *AddressTapZer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(AddressViewClick:)];
    [self.Address_View addGestureRecognizer:AddressTapZer];
     UITapGestureRecognizer *TimeTapZer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TimeViewClick:)];
    [self.Time_View addGestureRecognizer:TimeTapZer];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)AddressViewClick:(UIGestureRecognizer *)zer {
    if ([self.delegate respondsToSelector:@selector(ViewClick:)]) {
        [self.delegate ViewClick:1];
    }
    
}

- (void)TimeViewClick:(UIGestureRecognizer *)zer {
    if ([self.delegate respondsToSelector:@selector(ViewClick:)]) {
        [self.delegate ViewClick:2];
    }
}
- (void)setAddressTocell:(NSString *)AddressString {
    self.Address_Label.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightMedium];
    self.Address_Label.text = AddressString;
}

- (void)setTimesTocell:(NSString *)TimesString {
    self.Time_Label.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightMedium];
    self.Time_Label.text = TimesString;
}

@end
