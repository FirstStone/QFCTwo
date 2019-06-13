//
//  Message_HouseKeeping_Tableview_Cell.m
//  QFC
//
//  Created by tiaoxin on 2019/4/17.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Message_HouseKeeping_Tableview_Cell.h"

@interface Message_HouseKeeping_Tableview_Cell ()

@property (strong, nonatomic) IBOutlet UIImageView *icon_imageView;

@property (strong, nonatomic) IBOutlet UILabel *Title_Label;

@property (strong, nonatomic) IBOutlet UILabel *Time_Label;


@end

@implementation Message_HouseKeeping_Tableview_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataSoureToCell:(Message_Housekeeping_Model *)model {
    [self.icon_imageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    self.Title_Label.text = [NSString stringWithFormat:@"%@ %@", ([model.hyusbandry_type intValue] == 1 ? @"日常保洁" : @"深度保洁"), model.weight];
    self.Time_Label.text = [NSString stringWithFormat:@"%@上门清洁", model.fetchtime];
}

@end
