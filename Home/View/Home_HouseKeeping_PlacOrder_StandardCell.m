//
//  Home_HouseKeeping_PlacOrder_StandardCell.m
//  QFC
//
//  Created by tiaoxin on 2019/5/11.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_HouseKeeping_PlacOrder_StandardCell.h"

@interface Home_HouseKeeping_PlacOrder_StandardCell ()
@property (strong, nonatomic) IBOutlet UILabel *Text_Label;


@end

@implementation Home_HouseKeeping_PlacOrder_StandardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)settextToCell:(NSString *)text {
    self.Text_Label.text = text;
}

@end
