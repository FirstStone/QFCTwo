//
//  Mine_HouseKeeping_Service_ViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/4/28.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_HouseKeeping_Service_ViewController.h"
#define CellID_MineSetUPCell @"MineSetUPCell"

@interface Mine_HouseKeeping_Service_ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *Title_Array;

@property (nonatomic, strong) UIImageView *icon_View;

@end

@implementation Mine_HouseKeeping_Service_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.Title_Array = @[@"头像", @"手机号", @"联系地址", @"服务类型", @"我的标签"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_SetUP_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MineSetUPCell];
}

- (UIImageView *)icon_View {
    if (!_icon_View) {
        _icon_View = [[UIImageView alloc] init];
        _icon_View.image = [UIImage imageNamed:@"icon_touxiang"];
    }
    return _icon_View;
}

- (IBAction)LiftButtonPOP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDelegate
//返回多少个分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
//返回一个分区里多少数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.Title_Array.count;
}
// 返回Cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableviewCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableviewCell"];
            UILabel *title_Label = ({
                UILabel *label = [[UILabel alloc] init];
                label.font = [UIFont systemFontOfSize:14.0f weight:UIFontWeightMedium];
                label.textColor = QFC_Color_333333;
                label.text = self.Title_Array[indexPath.row];
                label;
            });
            [cell.contentView addSubview:title_Label];
            [title_Label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(cell.contentView.mas_top).offset(23.0f);
                make.left.equalTo(cell.contentView.mas_left).offset(10.0f);
                make.height.offset(15.0f);
                make.bottom.equalTo(cell.contentView.mas_bottom).offset(-23.0f);
            }];
            UIImageView *icon_ImageView = ({
                UIImageView *imageView = [[UIImageView alloc] init];
                imageView.image = [UIImage imageNamed:@"icon_you_Hui"];
                imageView;
            });
            [cell.contentView addSubview:icon_ImageView];
            [icon_ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_offset(CGSizeMake(6.0f, 11.0f));
                make.centerY.equalTo(title_Label.mas_centerY);
                make.right.equalTo(cell.contentView.mas_right).offset(-10.0f);
            }];
            
            [cell.contentView addSubview:self.icon_View];
            [self.icon_View mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_offset(CGSizeMake(40.0f, 40.0f));
                make.centerY.equalTo(cell.mas_centerY);
                make.right.equalTo(icon_ImageView.mas_left).offset(-10.0f);
            }];
            UIView *Line_View = ({
                UIView *view = [[UIView alloc] init];
                view.backgroundColor = QFC_Color_F5F5F5;
                view;
            });
            [cell.contentView addSubview:Line_View];
            [Line_View mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(cell.contentView);
                make.height.offset(1.0f);
                make.bottom.equalTo(cell.contentView.mas_bottom);
            }];
        }
        return cell;
    }else {
        Mine_SetUP_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineSetUPCell];
        cell.Title_Label.text = self.Title_Array[indexPath.row];
        if (indexPath.row == 1) {
            cell.SubTitle_Label.text = @"18539465047";
        }else if (indexPath.row == 2) {
            cell.SubTitle_Label.text = @"上海市松江区泗泾镇泗泾东区";
        }else if (indexPath.row == 3) {
            cell.SubTitle_Label.text = @"日常清洁";
        }else {
            cell.SubTitle_Label.text = @"#勤奋老实#诚实能干";
        }
        return cell;
    }
}

@end
