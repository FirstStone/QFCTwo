//
//  Message_Shoping_Tableview_Cell.m
//  QFC
//
//  Created by tiaoxin on 2019/4/17.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Message_Shoping_Tableview_Cell.h"

@interface Message_Shoping_Tableview_Cell ()

@property (strong, nonatomic) IBOutlet UIImageView *icon_imageView;

@property (strong, nonatomic) IBOutlet UILabel *Title_Label;

@property (strong, nonatomic) IBOutlet UILabel *Sub_Label;

@property (strong, nonatomic) IBOutlet UILabel *Price_Label;

@end

@implementation Message_Shoping_Tableview_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataSoureToCell:(Message_Shoping_Branch_Model *)model {
    [self.icon_imageView sd_setImageWithURL:[NSURL URLWithString:model.goods_img]];
    self.Title_Label.text = model.goods_name;
    self.Sub_Label.text = model.specification;
    self.Price_Label.text = [NSString stringWithFormat:@"¥%@", model.price];
}

@end
