//
//  Mine_RunErrands_ViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/4/26.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_RunErrands_ViewController.h"
#define CellID_MineSetUPCell @"MineSetUPCell"

@interface Home_RunErrands_ViewController ()<UITableViewDataSource, UITableViewDelegate, HomeRunErrandsViewDelegate, PickerViewResultDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *Prices_Label;
@property (strong, nonatomic) IBOutlet UIButton *Sure_BT;

@property (nonatomic, strong) NSArray *Title_Array;
@property (nonatomic, strong) NSMutableArray *Tip_Array;

@property (nonatomic, strong) UITextField *downField;

@property (nonatomic, strong) NSMutableDictionary *parm;

@end

@implementation Home_RunErrands_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.Title_Array = @[@"出 发 地：",@"目 的 地：",@"取件时间：",@"物品重量："];
    self.Tip_Array = [NSMutableArray arrayWithArray:@[@"选择你的出发地",@"选择你的目的地",@"选择你的取件时间",@"选择你的物品重量"]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    UIView *FooterView = [self getDoewView];
    FooterView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50.0f);
    self.tableView.tableFooterView = FooterView;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_SetUP_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MineSetUPCell];
}
- (UITextField *)downField {
    if (!_downField) {
        _downField = [[UITextField alloc] init];
        _downField.placeholder = @"有什么要说的吗？";
        [_downField setValue:QFC_Color_999999 forKeyPath:@"_placeholderLabel.textColor"];
        [_downField setValue:[UIFont systemFontOfSize:12.0f weight:UIFontWeightMedium] forKeyPath:@"_placeholderLabel.font"];
    }
    return _downField;
}

- (NSMutableDictionary *)parm {
    if (!_parm) {
        _parm = [[NSMutableDictionary alloc] init];
    }
    return _parm;
}

- (UIView *)getDoewView  {
    UIView * contView = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view;
    });
    UILabel *title_lable = ({
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:14.0f weight:UIFontWeightBold];
        label.textColor = QFC_Color_333333;
        label.text = @"备      注：";
        label;
    });
    [contView addSubview:title_lable];
    [title_lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contView.mas_left).offset(10.0f);
        make.centerY.top.bottom.equalTo(contView);
        make.width.offset(70.0f);
    }];
    [contView addSubview:self.downField];
    [self.downField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(title_lable.mas_right).offset(12.0f);
        make.top.bottom.equalTo(contView);
        make.right.equalTo(contView.mas_right).offset(-10.0f);
    }];
    return contView;
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
        Mine_SetUP_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineSetUPCell forIndexPath:indexPath];
        cell.Title_Label.text = self.Title_Array[indexPath.row];
        cell.TitleRight_Label.text = self.Tip_Array[indexPath.row];
        return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        Home_RunErrands_View *View = [[Home_RunErrands_View alloc] init];
        View.Navigation = self.navigationController;
        View.delegate = self;
        View.Number = indexPath.row;
        View.Title_Label.text = @"选择出发地址";
        [self.view addSubview:View];
    }else if (indexPath.row == 1) {
        Home_RunErrands_View *View = [[Home_RunErrands_View alloc] init];
        View.Navigation = self.navigationController;
        View.delegate = self;
        View.Number = indexPath.row;
        View.Title_Label.text = @"选择目的地址";
        [self.view addSubview:View];
    }else if (indexPath.row == 2){
        PickerView *pick = [[PickerView alloc] init];
        pick.delegate = self;
        pick.type = PickerViewTypeDataAndTime;
        pick.tag = 23472342;
        [self.view addSubview:pick];
    }else {
        PickerView *pick = [[PickerView alloc] init];
        pick.array = [NSMutableArray arrayWithArray:@[@"文件", @"鲜花", @"蛋糕", @"服务", @"其他"]];
        pick.delegate = self;
        pick.type = PickerViewTypeGoods;
        pick.tag = 23472343;
        [self.view addSubview:pick];
    }
}

#pragma mark----HomeRunErrandsViewDelegate
- (void)AddressSelectItem:(Mine_SetUP_MyAddress_Model *)model Number:(NSInteger)number {
    if (number == 0) {
        self.Tip_Array[number] = [NSString stringWithFormat:@"%@%@", model.address, model.details];
        [self.parm setObject:model.MyAddress_id forKey:@"begin"];
        [self.tableView reloadData];
    }else {
        self.Tip_Array[number] = [NSString stringWithFormat:@"%@%@", model.address, model.details];
        [self.parm setObject:model.MyAddress_id forKey:@"finish"];
        [self.tableView reloadData];
    }
}
/**
 //跑腿下单 生成订单
 Route::rule('errandorder/:uid/:begin/:finish/:times/:type/:weight/:remark','index/Errand/errandOrder');
 */

#pragma mark----PickerViewResultDelegate

- (void)pickerView:(UIView *)pickerView result:(NSString *)string {
    if (pickerView.tag == 23472342) {
        self.Tip_Array[2] = string;
        [self.parm setObject:string forKey:@"times"];
        [self.tableView reloadData];
    }else {
        self.Tip_Array[3] = string;
        NSArray * GoodsArray = [string componentsSeparatedByString:@"-"];
        [self.parm setObject:GoodsArray[0] forKey:@"type"];
        [self.parm setObject:GoodsArray[1] forKey:@"weight"];
        [self.tableView reloadData];
    }
}
- (IBAction)SureButtonClick:(id)sender {
    if (![[self.parm objectForKey:@"begin"] length]) {
        [MBProgressHUD py_showError:@"请选择出发地址" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }else if (![[self.parm objectForKey:@"finish"] length]) {
        [MBProgressHUD py_showError:@"请选择目的地址" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }else if (![[self.parm objectForKey:@"times"] length]) {
        [MBProgressHUD py_showError:@"请选择时间" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }else if (![[self.parm objectForKey:@"type"] length] || ![[self.parm objectForKey:@"weight"] length]) {
        [MBProgressHUD py_showError:@"请选择物品类型和重量" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }else {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
            [self LoadingDataSoure];
        }else {
            Basic_NavigationController *LoginVC = [[Basic_NavigationController alloc] initWithRootViewController:[[Login_PhoneCodeViewControlloer alloc] init]];
            [self.navigationController presentViewController:LoginVC animated:YES completion:Nil];
        }
    }
}


#pragma mark----UPdata
- (void)LoadingDataSoure {

    [self.parm setObject:self.downField.text forKey:@"remark"];
    [self.parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    self.Sure_BT.userInteractionEnabled = NO;
    [[HttpRequest sharedInstance] postWithURLString:URL_errandOrder parameters:self.parm success:^(NSDictionary * _Nonnull responseObject) {
        if ([[responseObject objectForKey:@"status"] intValue]) {
//            [MBProgressHUD py_showSuccess:@"下单成功" toView:nil];
//            [MBProgressHUD setAnimationDelay:0.7f];
//            [self setDataSoureToBacker:[responseObject objectForKey:@"message"]];
            Pay_ViewController *payVC = [[Pay_ViewController alloc] init];
            payVC.OrderID = [responseObject objectForKey:@"message"];
            [self.navigationController pushViewController:payVC animated:YES];
//            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [MBProgressHUD py_showError:@"预约失败" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
         self.Sure_BT.userInteractionEnabled = YES;
    } failure:^(NSError * _Nonnull error) {
        self.Sure_BT.userInteractionEnabled = YES;
        [MBProgressHUD py_showError:@"预约失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

/*- (void)setDataSoureToBacker:(NSString *)orderid {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:orderid forKey:@"orderid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_orders_ordersnFind parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        if ([[responseObject objectForKey:@"status"] intValue]) {
            Pay_ViewController *payVC = [[Pay_ViewController alloc] init];
            payVC.DataSoure = [responseObject objectForKey:@"info"];
            
            [self.navigationController pushViewController:payVC animated:YES];
        }else {
            [MBProgressHUD py_showError:@"暂无数据" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"数据加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}*/

@end
