//
//  Home_ShopStore_Lift_TableViewCell.m
//  QFC
//
//  Created by tiaoxin on 2019/6/16.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_ShopStore_Lift_TableViewCell.h"

@interface Home_ShopStore_Lift_TableViewCell ()

@property (strong, nonatomic) IBOutlet UILabel *Text_Label;

@end

@implementation Home_ShopStore_Lift_TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)SetDataSoureToCell:(Home_ShopStoreStyle_Model *)model {
    self.Text_Label.text = model.names;
}

@end
