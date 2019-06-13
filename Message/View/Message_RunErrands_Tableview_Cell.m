//
//  Message_RunErrands_Tableview_Cell.m
//  QFC
//
//  Created by tiaoxin on 2019/4/16.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Message_RunErrands_Tableview_Cell.h"

@interface Message_RunErrands_Tableview_Cell ()

@property (strong, nonatomic) IBOutlet UIImageView *icon_imageView;

@property (strong, nonatomic) IBOutlet UILabel *OrderNumber_Label;

@property (strong, nonatomic) IBOutlet UILabel *Price_Label;



@end

@implementation Message_RunErrands_Tableview_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
