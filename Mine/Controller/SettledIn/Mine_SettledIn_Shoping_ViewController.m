//
//  Mine_SettledIn_Shoping_ViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/4/24.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_SettledIn_Shoping_ViewController.h"

@interface Mine_SettledIn_Shoping_ViewController ()<PYPhotosViewDelegate, TZImagePickerControllerDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate, PickerViewResultDelegate, UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollerView;
@property (strong, nonatomic) IBOutlet UIButton *Sure_BT;

@property (nonatomic, strong) LabelAndTextField *Shop_Name_View;
@property (nonatomic, strong) LabelAndTextField *Shop_Range_View;
@property (nonatomic, strong) LabelAndTextField *Shop_Liaison_View;
@property (nonatomic, strong) LabelAndTextField *Shop_PhoneNumber_View;
@property (nonatomic, strong) LabelAndTextField *Shop_Address_View;

@property (nonatomic, strong) UIImageView *Shop_PhotoView;

@property (nonatomic, strong) UITextField *Shop_TimeField;

@property (nonatomic, strong) UILabel *BeginTime_Label;
@property (nonatomic, strong) UILabel *EndTime_Label;

@property (nonatomic, strong) PYPhotosView *BusinessLicense_View;
@property (nonatomic, strong) PYPhotosView *IDCard_Positive_View;
@property (nonatomic, strong) PYPhotosView *IDCard_Back_View;
@property (nonatomic, strong) PYPhotosView *IDCard_Hand_View;

/**1 头像 2 身份证正面 3 身份证反面 4 手持身份证 5 营业执照*/
@property (nonatomic, assign) NSInteger Style_Photo;

@property (nonatomic, strong) NSMutableArray *imageArray;

@property (nonatomic, strong) NSMutableDictionary *parm;

@property (nonatomic, assign) NSInteger time_States;

@end

@implementation Mine_SettledIn_Shoping_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.time_States = 0;
    [self setUPUI];
}

- (NSMutableArray *)imageArray {
    if (!_imageArray) {
        _imageArray = [[NSMutableArray alloc] init];
    }
    return _imageArray;
}
- (NSMutableDictionary *)parm {
    if (!_parm) {
        _parm = [[NSMutableDictionary alloc] init];
    }
    return _parm;
}

- (void)setUPUI {
    UIView *contView = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view;
    });
    [self.scrollerView addSubview:contView];
    [contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollerView);
        make.width.equalTo(self.scrollerView);
    }];
    //店铺头像
    UIView *ShopPhotoView = [self getShopPhotoView];
    [contView addSubview:ShopPhotoView];
    [ShopPhotoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(contView);
        make.height.offset(50.0f);
    }];
    [contView addSubview:self.Shop_Name_View];
    [self.Shop_Name_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(ShopPhotoView);
        make.top.equalTo(ShopPhotoView.mas_bottom);
    }];
    [contView addSubview:self.Shop_Range_View];
    [self.Shop_Range_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.Shop_Name_View);
        make.top.equalTo(self.Shop_Name_View.mas_bottom);
    }];
    [contView addSubview:self.Shop_Liaison_View];
    [self.Shop_Liaison_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.Shop_Name_View);
        make.top.equalTo(self.Shop_Range_View.mas_bottom);
    }];
    [contView addSubview:self.Shop_PhoneNumber_View];
    [self.Shop_PhoneNumber_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.Shop_Name_View);
        make.top.equalTo(self.Shop_Liaison_View.mas_bottom);
    }];
    [contView addSubview:self.Shop_Address_View];
    [self.Shop_Address_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.Shop_Name_View);
        make.top.equalTo(self.Shop_PhoneNumber_View.mas_bottom);
    }];
    
    //营业时间
    UIView *shopTimeView = [self getShopTimeView];
    [contView addSubview:shopTimeView];
    [shopTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.Shop_Address_View);
        make.top.equalTo(self.Shop_Address_View.mas_bottom);
    }];
    
    //营业执照
    UILabel *tip_Label_1 = ({
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:14.0f weight:UIFontWeightBold];
        label.textColor = QFC_Color_30AC65;
        label.text = @"上传营业执照";
        label;
    });
    [contView addSubview:tip_Label_1];
    [tip_Label_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contView.mas_left).offset(20.0f);
        make.top.equalTo(shopTimeView.mas_bottom).offset(10.0f);
        make.height.offset(15.0f);
    }];
    UIImageView *image_View_1 = ({
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"Mine_WD_RZ_BusinessLicense"];
//        imageView.backgroundColor = QFC_Color_30AC65;
        imageView;
    });
    [contView addSubview:image_View_1];
    [image_View_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tip_Label_1.mas_bottom).offset(10.0f);
        make.height.offset(115.0f);
        make.left.equalTo(contView.mas_left).offset(20.0);
        make.width.mas_offset((SCREEN_WIDTH - 60.0f)/2.0f);
    }];
    [contView addSubview:self.BusinessLicense_View];
    [self.BusinessLicense_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(image_View_1);
        make.left.equalTo(image_View_1.mas_right).offset(20.0f);
        make.right.equalTo(contView.mas_right).offset(-20.0f);
    }];
    
    //身份证正面
    UILabel *tip_Label_2 = ({
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:14.0f weight:UIFontWeightBold];
        label.textColor = QFC_Color_30AC65;
        label.text = @"上传身份证正面";
        label;
    });
    [contView addSubview:tip_Label_2];
    [tip_Label_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contView.mas_left).offset(20.0f);
        make.top.equalTo(image_View_1.mas_bottom).offset(10.0f);
        make.height.offset(15.0f);
    }];
    UIImageView *image_View_2 = ({
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"Mine_WD_RZ_IDCard_Positive"];
        //        imageView.backgroundColor = QFC_Color_30AC65;
        imageView;
    });
    [contView addSubview:image_View_2];
    [image_View_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tip_Label_2.mas_bottom).offset(10.0f);
        make.height.offset(115.0f);
        make.left.equalTo(contView.mas_left).offset(20.0);
        make.width.mas_offset((SCREEN_WIDTH - 60.0f)/2.0f);
    }];
    [contView addSubview:self.IDCard_Positive_View];
    [self.IDCard_Positive_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(image_View_2);
        make.left.equalTo(image_View_2.mas_right).offset(20.0f);
        make.right.equalTo(contView.mas_right).offset(-20.0f);
    }];
    
    //身份证反面
    UILabel *tip_Label_3 = ({
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:14.0f weight:UIFontWeightBold];
        label.textColor = QFC_Color_30AC65;
        label.text = @"上传身份证反面";
        label;
    });
    [contView addSubview:tip_Label_3];
    [tip_Label_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contView.mas_left).offset(20.0f);
        make.top.equalTo(image_View_2.mas_bottom).offset(10.0f);
        make.height.offset(15.0f);
    }];
    UIImageView *image_View_3 = ({
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"Mine_WD_RZ_IDCard_Back"];
        //        imageView.backgroundColor = QFC_Color_30AC65;
        imageView;
    });
    [contView addSubview:image_View_3];
    [image_View_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tip_Label_3.mas_bottom).offset(10.0f);
        make.height.offset(115.0f);
        make.left.equalTo(contView.mas_left).offset(20.0);
        make.width.mas_offset((SCREEN_WIDTH - 60.0f)/2.0f);
    }];
    [contView addSubview:self.IDCard_Back_View];
    [self.IDCard_Back_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(image_View_3);
        make.left.equalTo(image_View_3.mas_right).offset(20.0f);
        make.right.equalTo(contView.mas_right).offset(-20.0f);
    }];
    
    //手持身份证
    UILabel *tip_Label_4 = ({
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:14.0f weight:UIFontWeightBold];
        label.textColor = QFC_Color_30AC65;
        label.text = @"上传手持身份证";
        label;
    });
    [contView addSubview:tip_Label_4];
    [tip_Label_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contView.mas_left).offset(20.0f);
        make.top.equalTo(image_View_3.mas_bottom).offset(10.0f);
        make.height.offset(15.0f);
    }];
    UIImageView *image_View_4 = ({
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"Mine_WD_RZ_IDCard_Hand"];
        //        imageView.backgroundColor = QFC_Color_30AC65;
        imageView;
    });
    [contView addSubview:image_View_4];
    [image_View_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tip_Label_4.mas_bottom).offset(10.0f);
        make.height.offset(115.0f);
        make.left.equalTo(contView.mas_left).offset(20.0);
        make.width.mas_offset((SCREEN_WIDTH - 60.0f)/2.0f);
    }];
    [contView addSubview:self.IDCard_Hand_View];
    [self.IDCard_Hand_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(image_View_4);
        make.left.equalTo(image_View_4.mas_right).offset(20.0f);
        make.right.equalTo(contView.mas_right).offset(-20.0f);
    }];
    
    
    [contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.IDCard_Hand_View.mas_bottom).offset(10.0);
    }];
}



- (IBAction)LiftButtonPOP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark----懒加载
- (PYPhotosView *)IDCard_Hand_View {
    if (!_IDCard_Hand_View) {
        _IDCard_Hand_View = [[PYPhotosView alloc] init];
        _IDCard_Hand_View.photoWidth = (SCREEN_WIDTH - 60.0f)/2.0f;
        _IDCard_Hand_View.photoHeight = 115;
        _IDCard_Hand_View.photosMaxCol = 1.0f;
        _IDCard_Hand_View.imagesMaxCountWhenWillCompose = 1.0f;
        _IDCard_Hand_View.delegate = self;
    }
    return _IDCard_Hand_View;
}

- (PYPhotosView *)IDCard_Back_View {
    if (!_IDCard_Back_View) {
        _IDCard_Back_View = [[PYPhotosView alloc] init];
        _IDCard_Back_View.photoWidth = (SCREEN_WIDTH - 60.0f)/2.0f;
        _IDCard_Back_View.photoHeight = 115;
        _IDCard_Back_View.photosMaxCol = 1.0f;
        _IDCard_Back_View.imagesMaxCountWhenWillCompose = 1.0f;
        _IDCard_Back_View.delegate = self;
    }
    return _IDCard_Back_View;
}

- (PYPhotosView *)IDCard_Positive_View {
    if (!_IDCard_Positive_View) {
        _IDCard_Positive_View = [[PYPhotosView alloc] init];
        _IDCard_Positive_View.photoWidth = (SCREEN_WIDTH - 60.0f)/2.0f;
        _IDCard_Positive_View.photoHeight = 115;
        _IDCard_Positive_View.photosMaxCol = 1.0f;
        _IDCard_Positive_View.imagesMaxCountWhenWillCompose = 1.0f;
        _IDCard_Positive_View.delegate = self;
    }
    return _IDCard_Positive_View;
}

- (PYPhotosView *)BusinessLicense_View {
    if (!_BusinessLicense_View) {
        _BusinessLicense_View = [[PYPhotosView alloc] init];
        _BusinessLicense_View.photoWidth = (SCREEN_WIDTH - 60.0f)/2.0f;
        _BusinessLicense_View.photoHeight = 115;
        _BusinessLicense_View.photosMaxCol = 1.0f;
        _BusinessLicense_View.imagesMaxCountWhenWillCompose = 1.0f;
        _BusinessLicense_View.delegate = self;
    }
    return _BusinessLicense_View;
}

- (UITextField *)Shop_TimeField {
    if (!_Shop_TimeField) {
        _Shop_TimeField = [[UITextField alloc] init];
        _Shop_TimeField.placeholder = @"请选择时间";
    }
    return _Shop_TimeField;
}

- (UILabel *)BeginTime_Label {
    if (!_BeginTime_Label) {
        _BeginTime_Label = [[UILabel alloc] init];
        _BeginTime_Label.font = [UIFont systemFontOfSize:15.0f weight:UIFontWeightMedium];
        _BeginTime_Label.textColor = QFC_Color_Six;
        _BeginTime_Label.text = @"营业时间";
        _BeginTime_Label.textAlignment = NSTextAlignmentCenter;
        _BeginTime_Label.userInteractionEnabled = YES;
        UITapGestureRecognizer *beginTimeZer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(beginTimeLAbelClick:)];
        [_BeginTime_Label addGestureRecognizer:beginTimeZer];
    }
    return _BeginTime_Label;
}

- (void)beginTimeLAbelClick:(UIGestureRecognizer *)Zer {
    PickerView *pick = [[PickerView alloc] init];
    pick.delegate = self;
    pick.type = PickerViewTypeTime;
    pick.tag = 4895854;
    [self.view addSubview:pick];
}
- (UILabel *)EndTime_Label {
    if (!_EndTime_Label) {
        _EndTime_Label = [[UILabel alloc] init];
        _EndTime_Label.font = [UIFont systemFontOfSize:15.0f weight:UIFontWeightMedium];
        _EndTime_Label.textColor = QFC_Color_Six;
        _EndTime_Label.text = @"打烊时间";
        _EndTime_Label.textAlignment = NSTextAlignmentCenter;
        _EndTime_Label.userInteractionEnabled = YES;
        UITapGestureRecognizer *EndTimeZer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(EndTimeLAbelClick:)];
        [_EndTime_Label addGestureRecognizer:EndTimeZer];
    }
    return _EndTime_Label;
}

- (void)EndTimeLAbelClick:(UIGestureRecognizer *)Zer {
    PickerView *pick = [[PickerView alloc] init];
    pick.delegate = self;
    pick.type = PickerViewTypeTime;
    pick.tag = 4895855;
    [self.view addSubview:pick];
}

- (LabelAndTextField *)Shop_Name_View {
    if (!_Shop_Name_View) {
        _Shop_Name_View = [[LabelAndTextField alloc] init];
        _Shop_Name_View.Title_Label.text = @"店铺名称：";
        _Shop_Name_View.Text_Field.placeholder = @"请输入店铺名称";
    }
    return _Shop_Name_View;
}

- (LabelAndTextField *)Shop_Range_View {
    if (!_Shop_Range_View) {
        _Shop_Range_View = [[LabelAndTextField alloc] init];
        _Shop_Range_View.Title_Label.text = @"经营范围：";
        _Shop_Range_View.Text_Field.placeholder = @"请输入经营范围";
    }
    return _Shop_Range_View;
}

- (LabelAndTextField *)Shop_Liaison_View {
    if (!_Shop_Liaison_View) {
        _Shop_Liaison_View = [[LabelAndTextField alloc] init];
        _Shop_Liaison_View.Title_Label.text = @"联  系  人：";
        _Shop_Liaison_View.Text_Field.placeholder = @"请输入联系人";
    }
    return _Shop_Liaison_View;
}

- (LabelAndTextField *)Shop_PhoneNumber_View {
    if (!_Shop_PhoneNumber_View) {
        _Shop_PhoneNumber_View = [[LabelAndTextField alloc] init];
        _Shop_PhoneNumber_View.Title_Label.text = @"联系电话：";
        _Shop_PhoneNumber_View.Text_Field.placeholder = @"请输入联系电话";
        _Shop_PhoneNumber_View.Text_Field.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _Shop_PhoneNumber_View;
}

- (LabelAndTextField *)Shop_Address_View {
    if (!_Shop_Address_View) {
        _Shop_Address_View = [[LabelAndTextField alloc] init];
        _Shop_Address_View.Title_Label.text = @"联系地址：";
        _Shop_Address_View.Text_Field.placeholder = @"请输入联系地址";
        _Shop_Address_View.Text_Field.delegate = self;
    }
    return _Shop_Address_View;
}

- (UIImageView *)Shop_PhotoView {
    if (!_Shop_PhotoView) {
        _Shop_PhotoView = [[UIImageView alloc] init];
        _Shop_PhotoView.image = [UIImage imageNamed:@"icon_touxiang"];
        _Shop_PhotoView.layer.cornerRadius = 18.0f;
        _Shop_PhotoView.layer.masksToBounds = YES;
    }
    return _Shop_PhotoView;
}

//店铺头像
- (UIView *)getShopPhotoView {
    UIView *contView = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view;
    });
    UILabel *title_lable = ({
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:14.0f weight:UIFontWeightBold];
        label.textColor = QFC_Color_333333;
        label.text = @"店铺头像：";
        label;
    });
    [contView addSubview:title_lable];
    [title_lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contView.mas_left).offset(20.0f);
        make.top.bottom.equalTo(contView);
    }];
    [contView addSubview:self.Shop_PhotoView];
    [self.Shop_PhotoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(title_lable);
        make.size.mas_offset(CGSizeMake(36.0f, 36.0f));
        make.left.equalTo(title_lable.mas_right).offset(11.0f);
    }];
    UIImageView *image_View = ({
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"icon_you_Hui"];
        imageView;
    });
    [contView addSubview:image_View];
    [image_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(6.0f, 11.0f));
        make.centerY.equalTo(title_lable.mas_centerY);
        make.right.equalTo(contView.mas_right).offset(-20.0f);
    }];
    UIView *LineView = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = QFC_BackColor_Gray;
        view;
    });
    [contView addSubview:LineView];
    [LineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contView);
        make.height.offset(1.0f);
        make.bottom.equalTo(title_lable.mas_bottom);
    }];
    UITapGestureRecognizer *photoViewZer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoViewZerChange:)];
    [contView addGestureRecognizer:photoViewZer];
    return contView;
}

- (UIView *)getShopTimeView {
    UIView *contView = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view;
    });
    UILabel *title_lable = ({
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:14.0f weight:UIFontWeightBold];
        label.textColor = QFC_Color_333333;
        label.text = @"营业时间：";
        label;
    });
    [contView addSubview:title_lable];
    [title_lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contView.mas_left).offset(20.0f);
        make.top.bottom.equalTo(contView);
    }];
    
    [contView addSubview:self.BeginTime_Label];
    [self.BeginTime_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(title_lable);
        make.left.equalTo(title_lable.mas_right).offset(20.0f);
        make.width.offset(100.0f);
    }];
    [contView addSubview:self.EndTime_Label];
    [self.EndTime_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(title_lable);
        make.left.equalTo(self.BeginTime_Label.mas_right).offset(20.0f);
        make.width.offset(100.0f);
    }];
  /*
   [contView addSubview:self.Shop_TimeField];
   [self.Shop_TimeField mas_makeConstraints:^(MASConstraintMaker *make) {
   make.top.bottom.equalTo(title_lable);
   make.right.equalTo(contView.mas_right).offset(-20.0f);
   make.left.equalTo(title_lable.mas_right).offset(20.0f);
   }];
   */
    UIView *LineView = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = QFC_BackColor_Gray;
        view;
    });
    [contView addSubview:LineView];
    [LineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contView);
        make.height.offset(1.0f);
        make.bottom.equalTo(title_lable.mas_bottom);
    }];
    return contView;
}

#pragma mark----UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    Publish_Location_VC *LocationVC = [[Publish_Location_VC alloc] init];
    //    MJWeakSelf;
    LocationVC.PublishLocationVCBlock = ^(NSString * _Nonnull Address, NSString * _Nonnull lat, NSString * _Nonnull longStr) {
        //        [weakSelf.Sure_parm setObject:Address forKey:@"address"];
        textField.text = Address;
    };
    [self.navigationController pushViewController:LocationVC animated:YES];
    return NO;
}


#pragma mark----PYPhotosViewDelegate

- (void)photosView:(PYPhotosView *)photosView didAddImageClickedWithImages:(NSMutableArray *)images {
    
    if ([photosView isEqual:self.IDCard_Positive_View]) {
        self.Style_Photo = 2;
    }else if ([photosView isEqual:self.IDCard_Back_View]) {
        self.Style_Photo = 3;
    }else if ([photosView isEqual:self.IDCard_Hand_View]){
        self.Style_Photo = 4;
    }else {
        self.Style_Photo = 5;
    }
    XNLog(@"-------------------------%@",images);
    UIAlertController *alertCtl =[[UIAlertController alloc]init];
    UIAlertAction *cancel =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"cancel");
    }];
    UIAlertAction *xiangji =[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"xiangji");
        
        [self openCamera];
    }];
    UIAlertAction *xiangce =[UIAlertAction actionWithTitle:@"我的相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"xiangce");
        
        [self openPhotoLibrary];
    }];
    
    [alertCtl addAction:xiangce];
    [alertCtl addAction:cancel];
    [alertCtl addAction:xiangji];
    
    [self presentViewController:alertCtl animated:YES completion:nil];
}

#pragma mark---Click
- (void)photoViewZerChange:(UIGestureRecognizer *)Zer {
    self.Style_Photo = 1;
    UIAlertController *alertCtl =[[UIAlertController alloc]init];
    
    UIAlertAction *cancel =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"cancel");
    }];
    UIAlertAction *xiangji =[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"xiangji");
        
        [self openCamera];
    }];
    UIAlertAction *xiangce =[UIAlertAction actionWithTitle:@"我的相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"xiangce");
        
        [self openPhotoLibrary];
    }];
    
    [alertCtl addAction:xiangce];
    [alertCtl addAction:cancel];
    [alertCtl addAction:xiangji];
    
    [self presentViewController:alertCtl animated:YES completion:nil];
}

/**
 *  调用照相机
 */
- (void)openCamera
{
    //访问相机权限判断
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusNotDetermined) {//用户还没有对应程序程序授权进行操作
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [self openCamera];
                });
            }
        }];
    }else if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {//还没有授权访问的照片数据    ||    用户拒绝对应用程序授权
        // 无相机权限 做一个友好的提示
        UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * camera = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            UIApplication *application = [UIApplication sharedApplication];
            if (@available(iOS 10.0, *)) {
                [application openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
            } else {
                // Fallback on earlier versions
            }
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil];
        [alertVC addAction:cancel];
        [alertVC addAction:camera];
        [self presentViewController:alertVC animated:YES completion:nil];
    }else {//用户对应用程序授权
        //判断是否可以打开照相机
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            //摄像头
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = self;
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePickerController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }
        else{
            NSLog(@"没有摄像头");
            UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"提示" message:@"请检查是否有拍照设备" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //成功返回Block
            }];
            [alertV addAction:okAction];
            [self presentViewController:alertV animated:YES completion:nil];
        }
    }
}

/**
 *  打开相册
 */
-(void)openPhotoLibrary{
    //相册访问权限判断
    PHAuthorizationStatus PHAstatus = [PHPhotoLibrary authorizationStatus];
    if (PHAstatus == AVAuthorizationStatusNotDetermined) {//表明用户尚未选择关于客户端是否可以访问相册
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                [self openPhotoLibrary];
            }];
        });
        
    }else if (PHAstatus == AVAuthorizationStatusRestricted || PHAstatus == AVAuthorizationStatusDenied) {//客户端未被授权访问硬件 || 明确拒绝用户访问相册
        UIAlertController * alertPhotosVC = [UIAlertController alertControllerWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * camera = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            UIApplication *application = [UIApplication sharedApplication];
            if (@available(iOS 10.0, *)) {
                [application openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
            } else {
                // Fallback on earlier versions
            }
        }];
        UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        // 添加到alertVC上
        [alertPhotosVC addAction:cancel];
        [alertPhotosVC addAction:camera];
        // 显示alertVC
        [self presentViewController:alertPhotosVC animated:YES completion:nil];
    }else {//用户可以访问相册
        // 进入相册
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            //            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            //            imagePickerController.delegate = self;
            TZImagePickerController *imagePickerController = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
            //是否限制图片显示区域大小
            //            imagePickerController.allowsEditing = YES;
            //            imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePickerController animated:YES completion:nil];
            //            self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            //            [self presentViewController:self.imagePickerController animated:YES completion:nil];
        }else{
            NSLog(@"不能打开相册");
            UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"提示" message:@"抱歉，打不开相册哦！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //成功返回Block
            }];
            [alertV addAction:okAction];
            [self presentViewController:alertV animated:YES completion:nil];
        }
    }
}


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    if (self.Style_Photo == 1) {//头像
        self.Shop_PhotoView.image = [photos firstObject];
    }else if (self.Style_Photo == 2) {//身份证正面
        self.IDCard_Positive_View.images = [NSMutableArray arrayWithArray:photos];
    }else if (self.Style_Photo == 3) {//身份证反面
        self.IDCard_Back_View.images = [NSMutableArray arrayWithArray:photos];
    }else if (self.Style_Photo == 4) {//手持身份证
        self.IDCard_Hand_View.images = [NSMutableArray arrayWithArray:photos];
    }else {//经营资格证
        self.BusinessLicense_View.images = [NSMutableArray arrayWithArray:photos];
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (self.Style_Photo == 1) {//头像
        self.Shop_PhotoView.image = image;
    }else if (self.Style_Photo == 2) {//身份证正面
        self.IDCard_Positive_View.images = [NSMutableArray arrayWithArray:@[image]];
    }else if (self.Style_Photo == 3) {//身份证反面
        self.IDCard_Back_View.images = [NSMutableArray arrayWithArray:@[image]];;
    }else if (self.Style_Photo == 4){//手持身份证
        self.IDCard_Hand_View.images = [NSMutableArray arrayWithArray:@[image]];;
    }else {//经营资格证
        self.BusinessLicense_View.images = [NSMutableArray arrayWithArray:@[image]];;
    }
}
//进入拍摄页面点击取消按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)SureBTClick:(id)sender {
    if (!self.Shop_Name_View.Text_Field.text.length) {
        [MBProgressHUD py_showSuccess:@"请输入店铺名称" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }else if (!self.Shop_Range_View.Text_Field.text.length) {
        [MBProgressHUD py_showSuccess:@"请输入经营范围" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }else if (!self.Shop_Liaison_View.Text_Field.text.length) {
        [MBProgressHUD py_showSuccess:@"请输入联系人" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }else if (!self.Shop_PhoneNumber_View.Text_Field.text.length) {
        [MBProgressHUD py_showSuccess:@"请输入联系电话" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }else if (!self.Shop_Address_View.Text_Field.text.length) {
        [MBProgressHUD py_showSuccess:@"请输入联系地址" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }else if (!self.IDCard_Positive_View.images) {
        [MBProgressHUD py_showSuccess:@"请上传身份证正面" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }else if (!self.IDCard_Back_View.images) {
        [MBProgressHUD py_showSuccess:@"请上传身份证反面" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }else if (!self.IDCard_Hand_View.images) {
        [MBProgressHUD py_showSuccess:@"请上传手持身份证图片" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }else if (!self.BusinessLicense_View.images) {
        [MBProgressHUD py_showSuccess:@"请上传营业执照图片" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }else if (self.time_States < 2) {
        [MBProgressHUD py_showSuccess:@"请选择营业时间" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }else {
        [self UploadingImage];
    }
}

- (void)UploadingImage {
    UIImage *Photo = self.Shop_PhotoView.image;
    
    dispatch_queue_t queue = dispatch_queue_create("Uploadimage", DISPATCH_QUEUE_CONCURRENT);
    //创建分组
    dispatch_group_t group = dispatch_group_create();
    [SVProgressHUD showWithStatus:@"上传中。。。"];
    //添加任务,并且把任务放在同一分组下
    dispatch_group_async(group, queue, ^{
        dispatch_group_enter(group);
        UploadParam *image = [[UploadParam alloc] init];
        image.data = UIImagePNGRepresentation(Photo);
        image.name = @"file";
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        image.filename = str;
        image.mimeType = @".jpg";
        [[HttpRequest sharedInstance] uploadWithURLString:URL_userFiles parameters:nil uploadParam:@[image] success:^(NSDictionary * _Nonnull success) {
            if ([[success objectForKey:@"status"] intValue]) {
                [self.imageArray addObject:[success objectForKey:@"url"]];
                [self.parm setObject:[success objectForKey:@"url"] forKey:@"avatar"];
            }
            dispatch_group_leave(group);
            NSLog(@"%@",success);
        } failure:^(NSError * _Nonnull error) {
            NSLog(@"%@",error);
            [MBProgressHUD py_showError:@"上传失败" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            dispatch_group_leave(group);
        }];
    });
    dispatch_group_async(group, queue, ^{
        dispatch_group_enter(group);
        UploadParam *image = [[UploadParam alloc] init];
        image.data = UIImagePNGRepresentation(self.IDCard_Positive_View.images[0]);
        image.name = @"file";
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        image.filename = str;
        image.mimeType = @".jpg";
        [[HttpRequest sharedInstance] uploadWithURLString:URL_userFiles parameters:nil uploadParam:@[image] success:^(NSDictionary * _Nonnull success) {
            if ([[success objectForKey:@"status"] intValue]) {
                [self.imageArray addObject:[success objectForKey:@"url"]];
                [self.parm setObject:[success objectForKey:@"url"] forKey:@"just"];
            }
            dispatch_group_leave(group);
            NSLog(@"%@",success);
        } failure:^(NSError * _Nonnull error) {
            NSLog(@"%@",error);
            [MBProgressHUD py_showError:@"上传失败" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            dispatch_group_leave(group);
        }];
    });
    dispatch_group_async(group, queue, ^{
        dispatch_group_enter(group);
        UploadParam *image = [[UploadParam alloc] init];
        image.data = UIImagePNGRepresentation(self.IDCard_Back_View.images[0]);
        image.name = @"file";
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        image.filename = str;
        image.mimeType = @".jpg";
        [[HttpRequest sharedInstance] uploadWithURLString:URL_userFiles parameters:nil uploadParam:@[image] success:^(NSDictionary * _Nonnull success) {
            if ([[success objectForKey:@"status"] intValue]) {
                [self.imageArray addObject:[success objectForKey:@"url"]];
                [self.parm setObject:[success objectForKey:@"url"] forKey:@"against"];
            }
            dispatch_group_leave(group);
            NSLog(@"%@",success);
        } failure:^(NSError * _Nonnull error) {
            NSLog(@"%@",error);
            [MBProgressHUD py_showError:@"上传失败" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            dispatch_group_leave(group);
        }];
    });
    dispatch_group_async(group, queue, ^{
        dispatch_group_enter(group);
        UploadParam *image = [[UploadParam alloc] init];
        image.data = UIImagePNGRepresentation(self.IDCard_Hand_View.images[0]);
        image.name = @"file";
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        image.filename = str;
        image.mimeType = @".jpg";
        [[HttpRequest sharedInstance] uploadWithURLString:URL_userFiles parameters:nil uploadParam:@[image] success:^(NSDictionary * _Nonnull success) {
            if ([[success objectForKey:@"status"] intValue]) {
                [self.imageArray addObject:[success objectForKey:@"url"]];
                [self.parm setObject:[success objectForKey:@"url"] forKey:@"hand"];
            }
            dispatch_group_leave(group);
            NSLog(@"%@",success);
        } failure:^(NSError * _Nonnull error) {
            NSLog(@"%@",error);
            [MBProgressHUD py_showError:@"上传失败" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            dispatch_group_leave(group);
        }];
    });
    dispatch_group_async(group, queue, ^{
        dispatch_group_enter(group);
        UploadParam *image = [[UploadParam alloc] init];
        image.data = UIImagePNGRepresentation(self.BusinessLicense_View.images[0]);
        image.name = @"file";
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        image.filename = str;
        image.mimeType = @".jpg";
        [[HttpRequest sharedInstance] uploadWithURLString:URL_userFiles parameters:nil uploadParam:@[image] success:^(NSDictionary * _Nonnull success) {
            if ([[success objectForKey:@"status"] intValue]) {
                [self.imageArray addObject:[success objectForKey:@"url"]];
                [self.parm setObject:[success objectForKey:@"url"] forKey:@"license"];
            }
            dispatch_group_leave(group);
            NSLog(@"%@",success);
        } failure:^(NSError * _Nonnull error) {
            NSLog(@"%@",error);
            [MBProgressHUD py_showError:@"上传失败" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            dispatch_group_leave(group);
        }];
    });
    //添加分组内的最后一个任务
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if (self.imageArray.count == 5) {
            [self setDataSoureToBacker];
        }else {
            [SVProgressHUD dismiss];
            UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"提示" message:@"图片上传失败请重新上传" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //成功返回Block
                 [self.imageArray removeAllObjects];
            }];
            [alertV addAction:okAction];
            
            [self presentViewController:alertV animated:YES completion:nil];
        }
    });
}

//[SVProgressHUD dismissWithDelay:0.7f];
/*
 //服务商入驻 商家入驻  begin开始时间 end结束时间 merchant 名
 Route::rule('merchantenter/:uid/:merchant/:avatar/:type/:realname/:phone/:address /:license /:just/:against/:hand/:begin/:end','index/Users/merchantEnter');
 */

#pragma mark----UPdata
- (void)setDataSoureToBacker {
    [self.parm setObject:self.Shop_Liaison_View.Text_Field.text forKey:@"realname"];
    [self.parm setObject:self.Shop_Name_View.Text_Field.text forKey:@"merchant"];
    [self.parm setObject:self.Shop_Range_View.Text_Field.text forKey:@"type"];
    [self.parm setObject:self.Shop_PhoneNumber_View.Text_Field.text forKey:@"phone"];
    [self.parm setObject:self.Shop_Address_View.Text_Field.text forKey:@"address"];
    [self.parm setObject:self.BeginTime_Label.text forKey:@"begin"];
    [self.parm setObject:self.EndTime_Label.text forKey:@"end"];
    
    [self.parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_errandEnter parameters:self.parm success:^(NSDictionary * _Nonnull responseObject) {
        [SVProgressHUD dismiss];
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSDictionary *DataSoure = [responseObject objectForKey:@"info"];
            NSUserDefaults *defaults =  [NSUserDefaults standardUserDefaults];
            [defaults setObject:[DataSoure objectForKey:@"id"] forKey:User_Mid];
            [defaults setObject:[DataSoure objectForKey:@"type_id"] forKey:User_Type];
            [Singleton sharedSingleton].nickname = [DataSoure objectForKey:@"nickname"];
            [Singleton sharedSingleton].soleid = [DataSoure objectForKey:@"soleid"];
            [Singleton sharedSingleton].avatar = [DataSoure objectForKey:@"avatar"];
            [Singleton sharedSingleton].type_id = [DataSoure objectForKey:@"type_id"];
            [Singleton sharedSingleton].address = [DataSoure objectForKey:@"address"];
            [Singleton sharedSingleton].audit = [DataSoure objectForKey:@"audit"];
            [Singleton sharedSingleton].Mid = [DataSoure objectForKey:@"id"];
            [Singleton sharedSingleton].balance = [DataSoure objectForKey:@"balance"];
            [[NSNotificationCenter defaultCenter] postNotificationName:QFC_UpDataSoureToSelfView_NSNotification object:nil];
            [MBProgressHUD py_showSuccess:@"信息已提交，请等待审核" toView:nil];
            [SVProgressHUD setAnimationDelay:0.7f];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else {
            [MBProgressHUD py_showError:@"暂无注册信息" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            [self.imageArray removeAllObjects];
        }
        
        
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [MBProgressHUD py_showError:@"信息提交失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
        [self.imageArray removeAllObjects];
    }];
}
#pragma mark----PickerViewResultDelegate

- (void)pickerView:(UIView *)pickerView result:(NSString *)string {
    if (pickerView.tag == 4895854) {//开始时间
        NSLog(@"%@", string);
        self.BeginTime_Label.text = string;
        self.time_States += 1;
//        self.RunErrands_Sex_View.Text_Field.text = string;
//        [self.parm setObject:[self.RunErrands_Sex_View.Text_Field.text isEqualToString:@"男"] ? @"1" : @"2" forKey:@"sex"];
    }else {//结束时间
        NSLog(@"%@", string);
        self.EndTime_Label.text = string;
        self.time_States += 1;
//        self.RunErrands_Sex_View.Text_Field.text = string;
//        [self.parm setObject:[self.RunErrands_Sex_View.Text_Field.text isEqualToString:@"男"] ? @"1" : @"2" forKey:@"sex"];
    }
}


@end
