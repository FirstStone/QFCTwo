//
//  Square_HT_Details_First_Cell.m
//  QFC
//
//  Created by tiaoxin on 2019/4/10.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Square_HT_Details_First_Cell.h"

@interface Square_HT_Details_First_Cell ()
@property (strong, nonatomic) IBOutlet UIImageView *icon_imageView;

@property (strong, nonatomic) IBOutlet UILabel *Name_Label;

@property (strong, nonatomic) IBOutlet UILabel *Time_Label;

@property (strong, nonatomic) IBOutlet UIButton *Follow_BT;

@property (strong, nonatomic) IBOutlet UIButton *Collection_BT;

@property (strong, nonatomic) IBOutlet UILabel *Text_Label;


@property (strong, nonatomic) IBOutlet UIButton *ding_BT;
@property (strong, nonatomic) IBOutlet UIButton *pinglin_BT;
@property (strong, nonatomic) IBOutlet UIButton *xihuang_BT;
@property (strong, nonatomic) IBOutlet UIButton *fenxiang_BT;

@property (nonatomic, strong) Square_Details_Model *My_Model;

@end

@implementation Square_HT_Details_First_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.Image_View.photoWidth = (SCREEN_WIDTH - 60.0f)/3.0f;
    self.Image_View.photoHeight = (SCREEN_WIDTH - 60.0f)/3.0f;
    self.Image_View.photoMargin = 10.0f;
    self.Image_View.oneImageFullFrame = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModelToCell:(Square_Details_Model *)model {
    self.My_Model = model;
    if ([model.attention intValue]) {
        self.Follow_BT.selected = [model.attention intValue];
        self.Follow_BT.backgroundColor = QFC_Color_30AC65;
    }else {
          self.Follow_BT.selected = [model.attention intValue];
        self.Follow_BT.backgroundColor = [UIColor whiteColor];
    }
    if ([model.like intValue]) {
        self.ding_BT.selected = YES;
    }else {
        self.ding_BT.selected = NO;
    }
    
    [self.icon_imageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    self.Name_Label.text = model.nickname;
    self.Time_Label.text = model.createtime;
    self.Collection_BT.selected = [model.collect intValue];
    self.xihuang_BT.selected = [model.like intValue];
    self.Image_View.thumbnailUrls = model.imgurl;
    self.Image_View.originalUrls = model.imgurl;
    __weak typeof(self)weakSelf = self;
    [self.Image_View mas_updateConstraints:^(MASConstraintMaker *make) {
        if (model.imgurl.count) {
            make.size.mas_offset([weakSelf.Image_View sizeWithPhotoCount:model.imgurl.count photosState:1]).priorityHigh();
        }else {
            make.height.offset(0.0f);
        }
    }];
    [self.fenxiang_BT setTitle:model.share_sum forState:UIControlStateNormal];
    [self.xihuang_BT setTitle:model.like_sum forState:UIControlStateNormal];
    [self.pinglin_BT setTitle:model.discuss_sum forState:UIControlStateNormal];
    [self.ding_BT setTitle:model.parent forState:UIControlStateNormal];
    NSString *Bstr = @"";
    for (NSString *str in model.label) {
        Bstr = [NSString stringWithFormat:@"%@#%@",Bstr, str];
    }
    NSString *Astr = [NSString stringWithFormat:@"%@%@",model.content, Bstr];
    //        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:Astr attributes:@{NSFontAttributeName:[UIFont fontWithCGFont:UIFontWeightMedium size:16]}];// [UIFont fontWithName:@"SourceHanSansCN-Medium" size: 16],NSForegroundColorAttributeName: QFC_Color_333333
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:Astr];
    [text addAttributes:@{NSForegroundColorAttributeName: QFC_Color_32CCF2} range:NSMakeRange(model.content.length, Bstr.length)];
    self.Text_Label.attributedText = text;
}


- (IBAction)FollowButtonClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(SquareHTDetailsFirstCellButton:model:)]) {
        [self.delegate SquareHTDetailsFirstCellButton:1 model:self.My_Model];
    }
}

- (IBAction)CollectionButtonClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(SquareHTDetailsFirstCellButton:model:)]) {
        [self.delegate SquareHTDetailsFirstCellButton:2 model:self.My_Model];
    }
}

- (IBAction)PraiseButtonClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(SquareHTDetailsFirstCellButton:model:)]) {
        [self.delegate SquareHTDetailsFirstCellButton:3 model:self.My_Model];
    }
}

- (IBAction)ShareButtonClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(SquareHTDetailsFirstCellButton:model:)]) {
        [self.delegate SquareHTDetailsFirstCellButton:4 model:self.My_Model];
    }
}



@end
