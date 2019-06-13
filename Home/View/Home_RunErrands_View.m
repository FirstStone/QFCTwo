//
//  Home_RunErrands_View.m
//  QFC
//
//  Created by tiaoxin on 2019/5/9.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_RunErrands_View.h"
#define HScale ([UIScreen mainScreen].bounds.size.height) / 667

#define CellID_HomeRunErrandsOrderCell @"HomeRunErrandsOrderCell"
@interface Home_RunErrands_View ()<UITableViewDelegate, UITableViewDataSource, HomeRunErrandsOrderCellDelegate>

@property (nonatomic, strong) UIView *BackView;

@property (nonatomic, strong) UIButton *AddAddress_BT;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UIButton *ESC_BT;

@end

@implementation Home_RunErrands_View

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeRunErrandsOrderCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_HomeRunErrandsOrderCell];
        [self setUPUI];
        [self setDataSoureToBacker];
    }
    return self;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)setUPUI {
//    UITapGestureRecognizer *backViewZer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backHiddle:)];
//    [self addGestureRecognizer:backViewZer];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    self.frame = [UIScreen mainScreen].bounds;
    [self addSubview:self.BackView];
    [self.BackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(375.0f);
        make.bottom.left.right.equalTo(self);
    }];
    [self.BackView addSubview:self.Title_Label];
    [self.Title_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(40.0f);
        make.centerX.equalTo(self.BackView);
        make.top.equalTo(self.BackView.mas_top).offset(10.0f);
    }];
    [self.BackView addSubview:self.ESC_BT];
    [self.ESC_BT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(16.0f, 16.0f));
        make.centerY.equalTo(self.Title_Label.mas_centerY);
        make.right.equalTo(self.BackView.mas_right).offset(-14.0f);
    }];
    
    UIView *Line_View1 = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = QFC_Color_F5F5F5;
        view;
    });
    [self.BackView addSubview:Line_View1];
    [Line_View1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.BackView);
        make.top.equalTo(self.Title_Label.mas_bottom).offset(10.0f);
        make.height.offset(1.0f);
    }];
    [self.BackView addSubview:self.AddAddress_BT];
    [self.AddAddress_BT mas_makeConstraints:^(MASConstraintMaker *make) {
        if (is_IPhone_X) {
            make.bottom.equalTo(self.BackView.mas_bottom).offset(-14.0f);
        }else {
            make.bottom.equalTo(self.BackView.mas_bottom);
        }
        make.left.right.equalTo(self.BackView);
        make.height.offset(50.0f);
    }];
    
    UIView *Line_View2 = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = QFC_Color_F5F5F5;
        view;
    });
    [self.BackView addSubview:Line_View2];
    [Line_View2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.BackView);
        make.bottom.equalTo(self.AddAddress_BT.mas_top);
        make.height.offset(1.0f);
    }];
    [self.BackView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.BackView);
        make.top.equalTo(Line_View1.mas_bottom);
        make.bottom.equalTo(Line_View2.mas_top);
    }];
}

- (UIView *)BackView {
    if (!_BackView) {
        _BackView = [[UIView alloc] init];
        _BackView.backgroundColor = [UIColor whiteColor];
        _BackView.tag = 59584873;
    }
    return _BackView;
}

- (UILabel *)Title_Label {
    if (!_Title_Label) {
        _Title_Label = [[UILabel alloc] init];
        _Title_Label.font = [UIFont systemFontOfSize:14.0f weight:UIFontWeightBold];
        _Title_Label.textColor = QFC_Color_333333;
    }
    return _Title_Label;
}

- (UIButton *)AddAddress_BT {
    if (!_AddAddress_BT) {
        _AddAddress_BT = [[UIButton alloc] init];
        [_AddAddress_BT setTitle:@"新增地址" forState:UIControlStateNormal];
        [_AddAddress_BT setImage:[UIImage imageNamed:@"icon_Mine_SetUP_shouhuo"] forState:UIControlStateNormal];
        [_AddAddress_BT setTitleColor:QFC_Color_30AC65 forState:UIControlStateNormal];
        _AddAddress_BT.titleLabel.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightMedium];
        [_AddAddress_BT addTarget:self action:@selector(addaddButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _AddAddress_BT;
}

- (UIButton *)ESC_BT {
    if (!_ESC_BT) {
        _ESC_BT = [[UIButton alloc] init];
        [_ESC_BT setImage:[UIImage imageNamed:@"icon_Login_QX"] forState:UIControlStateNormal];
        [_ESC_BT addTarget:self action:@selector(ESCBTClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _ESC_BT;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.separatorStyle = UITableViewCellEditingStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)ESCBTClick:(UIButton *)button {
    [self hideAnimation];
}

#pragma mark - UITableViewDelegate
//返回多少个分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
//返回一个分区里多少数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
// 返回Cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeRunErrandsOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeRunErrandsOrderCell];
    [cell setModelToCell:self.dataArray[indexPath.row]];
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(AddressSelectItem:Number:)]) {
        [self.delegate AddressSelectItem:self.dataArray[indexPath.row] Number:self.Number];
    }
}

/**
 //收货地址列表
 Route::rule('addresslist/:uid','index/UserAddresss/addressList');
 */
#pragma mark----UPdata
- (void)setDataSoureToBacker {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_addressList parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSArray *Array = [responseObject objectForKey:@"list"];
            for (NSDictionary *dic in Array) {
                Mine_SetUP_MyAddress_Model *model = [Mine_SetUP_MyAddress_Model mj_objectWithKeyValues:dic];
                [self.dataArray addObject:model];
            }
            [self.tableView reloadData];
            //            [MBProgressHUD py_showSuccess:@"地址添加成功" toView:nil];
            //            [MBProgressHUD setAnimationDelay:0.7f];
        }else {
            [MBProgressHUD py_showError:@"暂无数据" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"信息获取失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

/**
 //收货地址删除
 Route::rule('addressdel/:uid','index/UserAddress/addressDel')
 */

#pragma mark----MineSetUPMyAddressCellDelegate

- (void)HomeRunErrandsOrderCellDelectButtonClick:(Mine_SetUP_MyAddress_Model *)modle button:(UIButton *)BT {
    BT.userInteractionEnabled = NO;
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:modle.MyAddress_id forKey:@"id"];
    [[HttpRequest sharedInstance] postWithURLString:URL_addressDel parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showSuccess:@"地址删除成功" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            [self.dataArray removeAllObjects];
            [self setDataSoureToBacker];
        }else {
            [MBProgressHUD py_showError:@"添加失败" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
        BT.userInteractionEnabled = YES;
    } failure:^(NSError * _Nonnull error) {
        BT.userInteractionEnabled = YES;
        [MBProgressHUD py_showError:@"删除失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

- (void)HomeRunErrandsOrderCellEditButtonClick:(Mine_SetUP_MyAddress_Model *)modle button:(UIButton *)BT {
    Mine_SetUPUI_MyAddress_NewAdd_VC *edit = [[Mine_SetUPUI_MyAddress_NewAdd_VC alloc] init];
    [edit setDataSouerToMyaddress:modle];
    [self.Navigation pushViewController:edit animated:YES];
}

#pragma mark event
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = touches.anyObject;
    
    if (touch.view.tag != 59584873) {
        
        [self hideAnimation];
    }
}

- (void)showAnimation{
    self.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        
        CGRect frame = self.BackView.frame;
        frame.origin.y = self.frame.size.height-260*HScale;
        self.BackView.frame = frame;
    }];
    
}

- (void)hideAnimation{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        CGRect frame = self.BackView.frame;
        frame.origin.y = self.frame.size.height;
        self.BackView.frame = frame;
        self.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [self.BackView removeFromSuperview];
        [self removeFromSuperview];
    }];
}
- (void)backHiddle:(UIGestureRecognizer *)Zer {
    [self hideAnimation];
}

- (void)addaddButtonClick:(UIButton *)button {
    Mine_SetUPUI_MyAddress_NewAdd_VC *addVC = [[Mine_SetUPUI_MyAddress_NewAdd_VC alloc] init];
    [self.Navigation pushViewController:addVC animated:YES];
}

@end
