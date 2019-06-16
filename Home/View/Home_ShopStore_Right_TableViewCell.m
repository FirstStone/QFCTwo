
//
//  Home_ShopStore_Right_TableViewCell.m
//  QFC
//
//  Created by tiaoxin on 2019/6/16.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_ShopStore_Right_TableViewCell.h"

@interface Home_ShopStore_Right_TableViewCell ()

@property (strong, nonatomic) IBOutlet UIImageView *Icon_ImageView;

@property (strong, nonatomic) IBOutlet UILabel *ShopStore_Label;

@property (strong, nonatomic) IBOutlet UILabel *Sub_Label;

@property (strong, nonatomic) IBOutlet UILabel *Price_Label;

@property (strong, nonatomic) IBOutlet UIView *Sum_View;

@property (strong, nonatomic) IBOutlet UIButton *Cart_BT;

@property (strong, nonatomic) IBOutlet UIButton *Jian_BT;

@property (strong, nonatomic) IBOutlet UIButton *Jia_BT;

@property (strong, nonatomic) IBOutlet UILabel *Sum_Label;


@end

@implementation Home_ShopStore_Right_TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)SetDataSoureToRightCell:(Home_ShopStore_Branch_Model *)model {
    
}


@end
