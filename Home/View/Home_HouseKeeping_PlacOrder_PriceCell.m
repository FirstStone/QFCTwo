//
//  Home_HouseKeeping_PlacOrder_PriceCell.m
//  QFC
//
//  Created by tiaoxin on 2019/5/11.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_HouseKeeping_PlacOrder_PriceCell.h"

@interface Home_HouseKeeping_PlacOrder_PriceCell ()
@property (strong, nonatomic) IBOutlet UILabel *Price_Label;

@end

@implementation Home_HouseKeeping_PlacOrder_PriceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPriceToCell:(NSString *)price {
    self.Price_Label.text = [NSString stringWithFormat:@"%@元",price];
}

@end
