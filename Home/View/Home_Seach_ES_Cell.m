//
//  Home_Seach_ES_Cell.m
//  QFC
//
//  Created by tiaoxin on 2019/6/20.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_Seach_ES_Cell.h"

@interface Home_Seach_ES_Cell ()

@property (strong, nonatomic) IBOutlet UIImageView *icon_imageView;

@property (strong, nonatomic) IBOutlet UILabel *Text_Label;

@end

@implementation Home_Seach_ES_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)SetDataSoureToCell:(Home_Seach_Model *)model {
    [self.icon_imageView sd_setImageWithURL:[NSURL URLWithString:model.imgurl]];
    self.Text_Label.text = model.content;
}

@end
