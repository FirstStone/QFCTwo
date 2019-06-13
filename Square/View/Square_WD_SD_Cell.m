//
//  Square_WD_SD_Cell.m
//  QFC
//
//  Created by tiaoxin on 2019/4/10.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Square_WD_SD_Cell.h"

@interface Square_WD_SD_Cell ()<SDCycleScrollViewDelegate>
@property (nonatomic, strong) UIImageView *icon_View;

@property (nonatomic, strong) UILabel *Title_Label;

@property (nonatomic, strong) SDCycleScrollView *TextSDCscrollView;

@property (nonatomic, strong) NSMutableArray *DataSoure;

@end

@implementation Square_WD_SD_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUPUI];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSMutableArray *)DataSoure {
    if (!_DataSoure) {
        _DataSoure = [[NSMutableArray alloc] init];
    }
    return _DataSoure;
}

- (void)setUPUI {
    self.contentView.backgroundColor = QFC_BackColor_Gray;
    UIView *Back_View = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.cornerRadius = 15.0f;
        view;
    });
    [self.contentView addSubview:Back_View];
    [Back_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 10.0f, 5.0f, 10.0f));
    }];
    [Back_View addSubview:self.icon_View];
    [self.icon_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(Back_View.mas_left).offset(14.0f);
        make.top.equalTo(Back_View.mas_top).offset(11.0f);
        make.size.mas_offset(CGSizeMake(16.0f, 23.0f));
        make.bottom.equalTo(Back_View.mas_bottom).offset(-10.0f);
    }];
    
    [Back_View addSubview:self.Title_Label];
    [self.Title_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon_View.mas_right).offset(16.0f);
        make.height.offset(12.0f);
        make.centerY.equalTo(self.icon_View.mas_centerY);
    }];
    [Back_View addSubview:self.TextSDCscrollView];
    [self.TextSDCscrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.Title_Label.mas_right);
        make.right.equalTo(Back_View.mas_right).offset(-10.0f);
        make.centerY.height.equalTo(self.icon_View);
    }];
    
    
}

#pragma mark----懒加载
- (UIImageView *)icon_View {
    if (!_icon_View) {
        _icon_View = [[UIImageView alloc] init];
        _icon_View.image = [UIImage imageNamed:@"icon_Wen"];
    }
    return _icon_View;
}

- (UILabel *)Title_Label {
    if (!_Title_Label) {
        _Title_Label = [[UILabel alloc] init];
        _Title_Label.text = @"脑洞大开：";
        _Title_Label.font = [UIFont systemFontOfSize:12.0f weight:3.0f];
    }
    return _Title_Label;
}

- (SDCycleScrollView *)TextSDCscrollView {
    if (!_TextSDCscrollView) {
        _TextSDCscrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 6.0f, SCREEN_WIDTH, 43.0f) delegate:self placeholderImage:nil];//[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 6.0f, SCREEN_WIDTH, 43.0f) imageNamesGroup:nil];
        _TextSDCscrollView.onlyDisplayText = YES;
        _TextSDCscrollView.scrollDirection = UICollectionViewScrollDirectionVertical;
        NSMutableArray *titleArray = [NSMutableArray new];
//        [titleArray addObject:@"如果我有时光机，我最想？"];
//        [titleArray addObject:@"如果我有时光机，我最想？"];
        _TextSDCscrollView.titlesGroup = [titleArray copy];
        _TextSDCscrollView.showPageControl = NO;
        [_TextSDCscrollView disableScrollGesture];
//        _TextSDCscrollView.layer.cornerRadius = 21.5f;
//        _TextSDCscrollView.layer.masksToBounds = YES;
        _TextSDCscrollView.titleLabelBackgroundColor = [UIColor whiteColor];
        _TextSDCscrollView.titleLabelTextColor = [UIColor blackColor];
        _TextSDCscrollView.tag = 59695884;
    }
    return _TextSDCscrollView;
}

- (void)setModelToCell:(NSMutableArray *)array; {
    self.DataSoure = array;
    NSMutableArray *title_Array = [[NSMutableArray alloc] init];
    for (Square_carousel_Model *model in array) {
        [title_Array addObject:model.content];
    }
    self.TextSDCscrollView.titlesGroup = [title_Array copy];
}

@end
