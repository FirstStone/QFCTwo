//
//  Home_HouseKeepingCell.m
//  QFC
//
//  Created by tiaoxin on 2019/4/28.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_HouseKeepingCell.h"

@interface Home_HouseKeepingCell ()<RatingBarDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *Photo_View;
@property (strong, nonatomic) IBOutlet UILabel *Name_Label;
@property (strong, nonatomic) IBOutlet UILabel *City_Label;
@property (strong, nonatomic) IBOutlet UIImageView *Sex_view;
@property (strong, nonatomic) IBOutlet UILabel *TipLift_Label;
@property (strong, nonatomic) IBOutlet UILabel *TipRight_Label;



@end

@implementation Home_HouseKeepingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.score_View.isIndicator = YES;
    [self.score_View setImageDeselected:@"icon_Home_HouseKeeping_Score_NO" halfSelected:@"icon_Home_HouseKeeping_Score_Select" fullSelected:@"icon_Home_HouseKeeping_Score_YES" andDelegate:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)ratingBar:(RatingBar *)ratingBar ratingChanged:(float)newRating {
    
}
/*
 age = 234;
 avatar = "https://www.txkuaiyou.com/uploads/fileimg/1557307225791-2019-05-08.png";
 grade = 10;
 id = 5;
 province = "\U4e0a\U6d77\U5e02";
 realname = Addsadfa;
 sex = 1;
 */
- (void)setModelToCell:(Home_HouseKeeping_Model *)model {
    [self.Photo_View setImageURL:[NSURL URLWithString:model.avatar]];
    if ([model.sex intValue] == 1) {
        self.Sex_view.image = [UIImage imageNamed:@"icon_Home_HouseKeeping_Sex_man"];
    }else {
        self.Sex_view.image = [UIImage imageNamed:@"icon_Home_HouseKeeping_Sex_Woman"];
    }
    self.Name_Label.text = model.realname;
    self.City_Label.text = [NSString stringWithFormat:@"%@  %@岁", model.province, model.age];
    [self.score_View displayRating:[model.grade intValue]/2.0f];
    self.TipLift_Label.text = [NSString stringWithFormat:@"  %@  ",model.one];
    self.TipRight_Label.text = [NSString stringWithFormat:@"  %@  ",model.two];;
}

- (void)setPlaceOrderModelToCell:(Home_HouseKeeping_Model *)model {
    [self.Photo_View setImageURL:[NSURL URLWithString:model.avatar]];
    if ([model.sex intValue] == 1) {
        self.Sex_view.image = [UIImage imageNamed:@"icon_Home_HouseKeeping_Sex_man"];
    }else {
        self.Sex_view.image = [UIImage imageNamed:@"icon_Home_HouseKeeping_Sex_Woman"];
    }
    self.Name_Label.text = model.realname;
    self.City_Label.text = [NSString stringWithFormat:@"%@  %@岁", model.province, model.age];
    [self.score_View displayRating:[model.grade intValue]/2.0f];
    self.TipLift_Label.text = [NSString stringWithFormat:@"  %@  ",model.labelone];
    self.TipRight_Label.text = [NSString stringWithFormat:@"  %@  ",model.labeltwo];;
}

@end
