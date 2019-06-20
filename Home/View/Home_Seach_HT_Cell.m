//
//  Home_Seach_HT_Cell.m
//  QFC
//
//  Created by tiaoxin on 2019/6/20.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_Seach_HT_Cell.h"

@interface Home_Seach_HT_Cell ()

@property (strong, nonatomic) IBOutlet UILabel *Text_Label;

@end

@implementation Home_Seach_HT_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)SetDataSoureToCell:(Home_Seach_Model *)model {
    self.Text_Label.text = model.content;
}

@end
