//
//  Square_HT_Details_Comment_Cell.m
//  QFC
//
//  Created by tiaoxin on 2019/4/11.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Square_HT_Details_Comment_Cell.h"


@interface Square_HT_Details_Comment_Cell ()

@property (weak, nonatomic) IBOutlet UIImageView *icon_imageView;
@property (weak, nonatomic) IBOutlet UILabel *Name_Label;

@property (strong, nonatomic) IBOutlet UIButton *Praise_Label;

@property (strong, nonatomic) IBOutlet UILabel *Text_Label;

@property (strong, nonatomic) IBOutlet UILabel *Time_Label;

@property (nonatomic, strong) Square_detailsDiscuss_Model *My_Model;
@end

@implementation Square_HT_Details_Comment_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataSoureToCell:(Square_detailsDiscuss_Model *)model {
    self.My_Model = model;
    if ([model.status intValue]) {
        self.Praise_Label.selected = YES;
    }else {
        self.Praise_Label.selected = NO;
    }
    [self.icon_imageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    self.Name_Label.text = model.nickname;
    [self.Praise_Label setTitle:model.like_sum forState:UIControlStateNormal];
    if (model.pnickname.length) {
        self.Text_Label.text = [NSString stringWithFormat:@"回复%@：%@", model.pnickname, model.content];
    }else {
        self.Text_Label.text = model.content;
    }
    self.Time_Label.text = model.createtime;
}

/**1 回复   2点赞*/
- (IBAction)AnswerButtonClaick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(SquareHTDetailsFirstCellButton:model:)]) {
        [self.delegate SquareHTDetailsCommentCell:1 model:self.My_Model];
    }
}

- (IBAction)PraiseButtonClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(SquareHTDetailsFirstCellButton:model:)]) {
        [self.delegate SquareHTDetailsCommentCell:2 model:self.My_Model];
    }
    
}




@end
