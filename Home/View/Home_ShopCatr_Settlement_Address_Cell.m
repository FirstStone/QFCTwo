//
//  Home_ShopCatr_Settlement_Address_Cell.m
//  QFC
//
//  Created by tiaoxin on 2019/4/23.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_ShopCatr_Settlement_Address_Cell.h"

@interface Home_ShopCatr_Settlement_Address_Cell ()

@property (strong, nonatomic) IBOutlet UILabel *Name_Label;

@property (strong, nonatomic) IBOutlet UILabel *Phone_Label;

@property (strong, nonatomic) IBOutlet UILabel *Address_Label;

@end

@implementation Home_ShopCatr_Settlement_Address_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataSoureToCell:(Mine_SetUP_MyAddress_Model *)model {
    self.Name_Label.text = model.realname;
    self.Phone_Label.text = model.phone;
    self.Address_Label.text = [NSString stringWithFormat:@"%@%@", model.address, model.details];
}


@end
