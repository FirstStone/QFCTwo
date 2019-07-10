//
//  Home_KDROrder_Cell.m
//  QFC
//
//  Created by tiaoxin on 2019/7/10.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_KDROrder_Cell.h"

@interface Home_KDROrder_Cell ()

@property (strong, nonatomic) IBOutlet UILabel *Time_Label;

@property (strong, nonatomic) IBOutlet UILabel *Address_Label;

@property (strong, nonatomic) IBOutlet UILabel *Peopel_Label;

@property (strong, nonatomic) IBOutlet UIButton *State_BT;


@end

@implementation Home_KDROrder_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
