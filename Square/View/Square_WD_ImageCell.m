//
//  Square_WD_ImageCell.m
//  QFC
//
//  Created by tiaoxin on 2019/4/10.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Square_WD_ImageCell.h"

@interface Square_WD_ImageCell ()
@property (strong, nonatomic) IBOutlet UILabel *Title_Label;
@property (strong, nonatomic) IBOutlet UILabel *Text_Label;
@property (strong, nonatomic) IBOutlet UIImageView *image_View;

@property (strong, nonatomic) IBOutlet UILabel *Talk_Label;
@property (strong, nonatomic) IBOutlet UILabel *Hot_Label;


@end

@implementation Square_WD_ImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModelToCell:(Square_info_Model *)model {
    self.Title_Label.text = model.content;
    self.Text_Label.text = model.answer_content;
    [self.image_View sd_setImageWithURL:[NSURL URLWithString:model.answer_img]];
    self.Talk_Label.text = [NSString stringWithFormat:@"%d人在讨论", [model.discuss_sum intValue]];
}

@end
