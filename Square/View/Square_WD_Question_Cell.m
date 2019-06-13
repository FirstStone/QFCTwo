//
//  Square_WD_ Question_Cell.m
//  QFC
//
//  Created by tiaoxin on 2019/4/10.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Square_WD_Question_Cell.h"

@interface Square_WD_Question_Cell ()

@property (strong, nonatomic) IBOutlet UIButton *Address_BT;
@property (strong, nonatomic) IBOutlet UILabel *Title_Label;

@property (strong, nonatomic) IBOutlet UIImageView *icon_imageView;

@property (strong, nonatomic) IBOutlet UILabel *Name_Label;

@property (strong, nonatomic) IBOutlet UILabel *People_Label;

@property (strong, nonatomic) IBOutlet UIButton *Questiong_BT;

@property (nonatomic, strong) Square_address_Model *Mymodel;

@end

@implementation Square_WD_Question_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *tapZer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconImageViewClick:)];
    [self.icon_imageView addGestureRecognizer:tapZer];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)iconImageViewClick:(UIGestureRecognizer *)zer {
    if ([self.delegate respondsToSelector:@selector(SquareWDQuestionCellIconimageViewClick:)]) {
        [self.delegate SquareWDQuestionCellIconimageViewClick:self.Mymodel.uid];
    }
}

- (void)setModelToCell:(Square_address_Model *)model {
    self.Mymodel = model;
//    [self.Address_BT setTitle:model.content; forState:UIControlStateNormal];
    self.Title_Label.text = model.content;
    [self.icon_imageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    self.Name_Label.text = model.nickname;
    self.People_Label.text = [NSString stringWithFormat:@"%@,人参与讨论", model.discuss_sum];
}

@end
