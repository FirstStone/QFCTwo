//
//  Home_HouseKeeping_StyleCell.m
//  QFC
//
//  Created by tiaoxin on 2019/5/10.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_HouseKeeping_StyleCell.h"

@interface Home_HouseKeeping_StyleCell ()

@property (strong, nonatomic) IBOutlet UILabel *Kitchen_Label;

@property (strong, nonatomic) IBOutlet UILabel *WC_Label;
@property (strong, nonatomic) IBOutlet UILabel *Room_Label;



@end

@implementation Home_HouseKeeping_StyleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
