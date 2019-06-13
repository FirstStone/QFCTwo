//
//  Publish_Location_Cell.m
//  QFC
//
//  Created by tiaoxin on 2019/6/5.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Publish_Location_Cell.h"

@interface Publish_Location_Cell ()

@property (strong, nonatomic) IBOutlet UIButton *State_BT;

@property (strong, nonatomic) IBOutlet UILabel *Title_Label;

@property (strong, nonatomic) IBOutlet UILabel *Sub_Label;


@end

@implementation Publish_Location_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)StateButtonClick:(id)sender {
}

- (void)setDataSoureToCell:(Publish_Location_Model *)model {
    self.State_BT.selected = model.State;
    self.Title_Label.text = model.Name;
    self.Sub_Label.text = model.SubName;
}

@end
