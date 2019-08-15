//
//  Mine_KDR_ViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/7/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_KDR_ViewController.h"
#define CellID_MineSetUPCell @"MineSetUPCell"

@interface Mine_KDR_ViewController ()<UITableViewDelegate, UITableViewDataSource, PickerViewResultDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate, PYPhotosViewDelegate, TZImagePickerControllerDelegate>
@property (strong, nonatomic) IBOutlet UIBarButtonItem *Sure_BT;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *Title_Array;

@property (nonatomic, strong) UIImageView *icon_View;

@property (nonatomic, strong) KDR_People_Model *My_Model;

@property (nonatomic, strong) PYPhotosView *IDCard_Positive_View;
@property (nonatomic, strong) PYPhotosView *IDCard_Back_View;
@property (nonatomic, strong) PYPhotosView *IDCard_Hand_View;

/**1 头像 2 身份证正面 3 身份证反面 4 手持身份证*/
@property (nonatomic, assign) NSInteger Style_Photo;

@property (nonatomic, strong) NSMutableArray *imageArray;

@end

@implementation Mine_KDR_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.Title_Array = @[@"头像：", @"姓名：", @"性别：", @"年龄：", @"手机号：", @"服务小区"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    UIView *footerV = [self setTableViewFooterView];
    UIView *footerView = [[UIView alloc] init];
//    footerView.backgroundColor = [UIColor orangeColor];
    footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 500.0f);
    [footerView addSubview:footerV];
    [footerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    self.tableView.tableFooterView = footerView;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_SetUP_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MineSetUPCell];
    [self LoadingDataSoure];
}
- (IBAction)LiftButtonPOP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)SureButtonClick:(id)sender {
    if (!self.My_Model.realname.length) {
        [MBProgressHUD py_showSuccess:@"请输入姓名" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }else if (!self.My_Model.sex.length) {
        [MBProgressHUD py_showSuccess:@"请选择性别" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }else if (!self.My_Model.age.length) {
        [MBProgressHUD py_showSuccess:@"请输入年龄" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }else if (!self.My_Model.phone.length) {
        [MBProgressHUD py_showSuccess:@"请输入手机号" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }else if (!self.My_Model.village.length) {
        [MBProgressHUD py_showSuccess:@"请选择服务小区" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }else if (!self.IDCard_Positive_View.images) {
        [MBProgressHUD py_showSuccess:@"请输上传身份证正面" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }else if (!self.IDCard_Back_View.images) {
        [MBProgressHUD py_showSuccess:@"请输上传身份证反面" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }else if (!self.IDCard_Hand_View.images) {
        [MBProgressHUD py_showSuccess:@"请输手持身份证图片" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }else {
        [self UploadingImage];
    }
}

- (NSMutableArray *)imageArray {
    if (!_imageArray) {
        _imageArray = [[NSMutableArray alloc] init];
    }
    return _imageArray;
}

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

- (void)setCardState {
    self.IDCard_Hand_View.photosState = PYPhotosViewStateWillCompose;
    self.IDCard_Hand_View.hideDeleteView = NO;
    self.IDCard_Positive_View.photosState = PYPhotosViewStateWillCompose;
    self.IDCard_Positive_View.hideDeleteView = NO;
    self.IDCard_Back_View.photosState = PYPhotosViewStateWillCompose;
    self.IDCard_Back_View.hideDeleteView = NO;
}

- (UIImageView *)icon_View {
    if (!_icon_View) {
        _icon_View = [[UIImageView alloc] init];
        _icon_View.image = [UIImage imageNamed:@"icon_touxiang"];
        _icon_View.layer.cornerRadius = 20.0f;
        _icon_View.layer.masksToBounds = YES;
    }
    return _icon_View;
}

- (UIView *)setTableViewFooterView {
    UIView *contView = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view;
    });
    
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
        make.top.equalTo(contView.mas_top).offset(10.0f);
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
        make.top.equalTo(image_View_4);
        make.height.mas_offset(115.0f);
        make.left.equalTo(image_View_4.mas_right).offset(20.0f);
        make.right.equalTo(contView.mas_right).offset(-20.0f);
    }];
    
    [contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.IDCard_Hand_View.mas_bottom).offset(10.0);
    }];
    return contView;
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
        [self.icon_View sd_setImageWithURL:[NSURL URLWithString:self.My_Model.avatar]];
        return cell;
    }else {
        Mine_SetUP_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineSetUPCell];
        cell.Title_Label.text = self.Title_Array[indexPath.row];
        if (indexPath.row == 1) {// 姓名
            cell.SubTitle_Label.text = self.My_Model.realname;
        }else if (indexPath.row == 2) {//性别
            cell.SubTitle_Label.text = [self.My_Model.sex intValue] == 1 ? @"男" : @"女";
        }else if (indexPath.row == 3) {//年龄
            cell.SubTitle_Label.text = self.My_Model.age;
        }else if (indexPath.row == 4) {//手机号
            cell.SubTitle_Label.text = self.My_Model.phone;
        }else {//服务小区
            cell.SubTitle_Label.text = self.My_Model.village;
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0://头像
        {
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
            break;
        case 1://姓名
        {
            Mine_SetUP_PersonalData_Nickname_VC *PersonaVC = [[Mine_SetUP_PersonalData_Nickname_VC alloc] init];
            PersonaVC.Number = 5;
            PersonaVC.textStr = self.My_Model.realname;
            MJWeakSelf;
            PersonaVC.MineSetUPPersonaBlack = ^(NSString * _Nonnull TextStr) {
                weakSelf.My_Model.realname = TextStr;
                [weakSelf.tableView reloadData];
            };
            [PersonaVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:PersonaVC animated:YES];
        }
            break;
        case 2://性别
        {
            PickerView *pick = [[PickerView alloc] init];
            pick.delegate = self;
            pick.type = PickerViewTypeSex;
            [self.view addSubview:pick];
        }
            break;
        case 3://年龄
        {
            Mine_SetUP_PersonalData_Nickname_VC *PersonaVC = [[Mine_SetUP_PersonalData_Nickname_VC alloc] init];
            PersonaVC.Number = 6;
            PersonaVC.textStr = self.My_Model.age;
            MJWeakSelf;
            PersonaVC.MineSetUPPersonaBlack = ^(NSString * _Nonnull TextStr) {
                weakSelf.My_Model.age = TextStr;
                [weakSelf.tableView reloadData];
            };
            [PersonaVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:PersonaVC animated:YES];
        }
            break;
        case 4:// 我的手机号
        {
            Mine_SetUP_PersonalData_Nickname_VC *PersonaVC = [[Mine_SetUP_PersonalData_Nickname_VC alloc] init];
            PersonaVC.Number = 2;
            PersonaVC.textStr = self.My_Model.realname;
            MJWeakSelf;
            PersonaVC.MineSetUPPersonaBlack = ^(NSString * _Nonnull TextStr) {
                weakSelf.My_Model.realname = TextStr;
                [weakSelf.tableView reloadData];
            };
            [PersonaVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:PersonaVC animated:YES];
    
        }
            break;
            case 5://服务小区
        {
            Publish_Location_VC *LocationVC = [[Publish_Location_VC alloc] init];
            LocationVC.Number = 1;
            MJWeakSelf;
            LocationVC.PublishLocationVCBlock = ^(NSString * _Nonnull Address, NSString * _Nonnull lat, NSString * _Nonnull longStr, NSString * _Nonnull name, NSString * _Nonnull province, NSString * _Nonnull city, NSString * _Nonnull district) {
                weakSelf.My_Model.address = Address;
                weakSelf.My_Model.longitude = longStr;
                weakSelf.My_Model.latitude = lat;
                weakSelf.My_Model.city = city;
                weakSelf.My_Model.county = district;
                weakSelf.My_Model.province = province;
                weakSelf.My_Model.village = name;
                [weakSelf.tableView reloadData];
            };
            [self.navigationController pushViewController:LocationVC animated:YES];
        }
            break;
        default:
            break;
    }
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
        self.icon_View.image = [photos firstObject];
    }else if (self.Style_Photo == 2) {//身份证正面
        self.IDCard_Positive_View.images = [NSMutableArray arrayWithArray:photos];
    }else if (self.Style_Photo == 3) {//身份证反面
        self.IDCard_Back_View.images = [NSMutableArray arrayWithArray:photos];
    }else {//手持身份证
        self.IDCard_Hand_View.images = [NSMutableArray arrayWithArray:photos];
    }
//    self.icon_View.image = photos[0];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (self.Style_Photo == 1) {//头像
        self.icon_View.image = image;
    }else if (self.Style_Photo == 2) {//身份证正面
        self.IDCard_Positive_View.images = [NSMutableArray arrayWithArray:@[image]];
    }else if (self.Style_Photo == 3) {//身份证反面
        self.IDCard_Back_View.images = [NSMutableArray arrayWithArray:@[image]];;
    }else {//手持身份证
        self.IDCard_Hand_View.images = [NSMutableArray arrayWithArray:@[image]];;
    }
}
//进入拍摄页面点击取消按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark----PickerViewResultDelegate

- (void)pickerView:(UIView *)pickerView result:(NSString *)string {
    self.My_Model.sex = [string isEqualToString:@"男"] ? @"1" : @"2";
}
#pragma mark----PYPhotosViewDelegate

- (void)photosView:(PYPhotosView *)photosView didAddImageClickedWithImages:(NSMutableArray *)images {
    if ([photosView isEqual:self.IDCard_Positive_View]) {
        self.Style_Photo = 2;
    }else if ([photosView isEqual:self.IDCard_Back_View]) {
        self.Style_Photo = 3;
    }else {
        self.Style_Photo = 4;
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

#pragma mark----UPdata
- (void)LoadingDataSoure {
    /**
     快代扔服务信息
     waste/users/service
     uid
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_wasteUsersService parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSDictionary *infoDic = [responseObject objectForKey:@"info"];
            if (infoDic) {
                self.My_Model = [KDR_People_Model mj_objectWithKeyValues:infoDic];
                if (self.My_Model.just.length) {
                    self.IDCard_Positive_View.images = [NSMutableArray arrayWithArray:@[[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.My_Model.just]]]]];
                }
                if (self.My_Model.against.length) {
                     self.IDCard_Back_View.images = [NSMutableArray arrayWithArray:@[[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.My_Model.against]]]]];
                }
                if (self.My_Model.hand.length) {
                     self.IDCard_Hand_View.images = [NSMutableArray arrayWithArray:@[[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.My_Model.hand]]]]];
                }
            }
            [self.tableView reloadData];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

- (void)POSTWasteUsersServiceUps {
    /**
     waste/users/serviceUps
     uid
     $data['uid'] = input('uid');
     $data['avatar'] = input('avatar');
     $data['realname'] = input('realname');
     $data['phone'] = input('phone');
     $data['sex'] = input('sex');
     $data['age'] = input('age');
     $data['just'] = input('just');
     $data['against'] = input('against');
     $data['hand'] = input('hand');
     
     $data['invite'] = input('invite');
     $data['village'] = input('village');
     $data['address'] = input('address');
     $data['city'] = input('city');
     $data['latitude'] = input('latitude');
     $data['longitude'] = input('longitude');
     */
    
    
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:self.My_Model.avatar forKey:@"avatar"];
    [parm setObject:self.My_Model.realname forKey:@"realname"];
    [parm setObject:self.My_Model.phone forKey:@"phone"];
    [parm setObject:self.My_Model.sex forKey:@"sex"];
    [parm setObject:self.My_Model.age forKey:@"age"];
    [parm setObject:self.My_Model.just forKey:@"just"];
    [parm setObject:self.My_Model.against forKey:@"against"];
    [parm setObject:self.My_Model.hand forKey:@"hand"];
    [parm setObject:self.My_Model.invite forKey:@"invite"];
    [parm setObject:self.My_Model.village forKey:@"village"];
    [parm setObject:self.My_Model.address forKey:@"address"];
    [parm setObject:self.My_Model.city forKey:@"city"];
    [parm setObject:self.My_Model.latitude forKey:@"latitude"];
    [parm setObject:self.My_Model.longitude forKey:@"longitude"];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_wasteUsersServiceUps parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showSuccess:@"修改成功" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [MBProgressHUD py_showSuccess:@"修改失败" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [MBProgressHUD py_showError:@"操作失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

- (void)UploadingImage {
    UIImage *Photo = self.icon_View.image;
    
    dispatch_queue_t queue = dispatch_queue_create("Uploadimage", DISPATCH_QUEUE_CONCURRENT);
    //创建分组
    dispatch_group_t group = dispatch_group_create();
    [SVProgressHUD showWithStatus:@"上传中。。。"];
    //添加任务,并且把任务放在同一分组下
    dispatch_group_async(group, queue, ^{
        dispatch_group_enter(group);
        UploadParam *image = [[UploadParam alloc] init];
        image.data = UIImageJPEGRepresentation(Photo, 0.1);
        image.name = @"file";
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        image.filename = str;
        image.mimeType = @".jpg";
        [[HttpRequest sharedInstance] uploadWithURLString:URL_userFiles parameters:nil uploadParam:@[image] success:^(NSDictionary * _Nonnull success) {
            if ([[success objectForKey:@"status"] intValue]) {
                self.My_Model.avatar = [success objectForKey:@"url"];
                [self.imageArray addObject:[success objectForKey:@"url"]];
//                [self.parm setObject:[success objectForKey:@"url"] forKey:@"avatar"];
            }
            dispatch_group_leave(group);
            NSLog(@"==================1%@",success);
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
        image.data = UIImageJPEGRepresentation(self.IDCard_Positive_View.images[0], 0.1);
        image.name = @"file";
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        image.filename = str;
        image.mimeType = @".jpg";
        [[HttpRequest sharedInstance] uploadWithURLString:URL_userFiles parameters:nil uploadParam:@[image] success:^(NSDictionary * _Nonnull success) {
            if ([[success objectForKey:@"status"] intValue]) {
                self.My_Model.just = [success objectForKey:@"url"];
                [self.imageArray addObject:[success objectForKey:@"url"]];
//                [self.parm setObject:[success objectForKey:@"url"] forKey:@"just"];
            }
            dispatch_group_leave(group);
            NSLog(@"==================2%@",success);
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
        image.data = UIImageJPEGRepresentation(self.IDCard_Back_View.images[0], 0.1);
        //        image.data = UIImagePNGRepresentation(self.IDCard_Back_View.images[0]);
        image.name = @"file";
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        image.filename = str;
        image.mimeType = @".jpg";
        [[HttpRequest sharedInstance] uploadWithURLString:URL_userFiles parameters:nil uploadParam:@[image] success:^(NSDictionary * _Nonnull success) {
            if ([[success objectForKey:@"status"] intValue]) {
                self.My_Model.against = [success objectForKey:@"url"];
                [self.imageArray addObject:[success objectForKey:@"url"]];
//                [self.parm setObject:[success objectForKey:@"url"] forKey:@"against"];
            }
            dispatch_group_leave(group);
            NSLog(@"==================3%@",success);
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
        image.data = UIImageJPEGRepresentation(self.IDCard_Hand_View.images[0], 0.1);
        //        image.data = UIImagePNGRepresentation(self.IDCard_Hand_View.images[0]);
        image.name = @"file";
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        image.filename = str;
        image.mimeType = @".jpg";
        [[HttpRequest sharedInstance] uploadWithURLString:URL_userFiles parameters:nil uploadParam:@[image] success:^(NSDictionary * _Nonnull success) {
            if ([[success objectForKey:@"status"] intValue]) {
                self.My_Model.hand = [success objectForKey:@"url"];
                [self.imageArray addObject:[success objectForKey:@"url"]];
//                [self.parm setObject:[success objectForKey:@"url"] forKey:@"hand"];
            }
            dispatch_group_leave(group);
            NSLog(@"==================4%@",success);
        } failure:^(NSError * _Nonnull error) {
            NSLog(@"%@",error);
            [MBProgressHUD py_showError:@"上传失败" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            dispatch_group_leave(group);
        }];
    });
    //添加分组内的最后一个任务
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"%lu",(unsigned long)self.imageArray.count);
        if (self.imageArray.count == 4) {
            [self POSTWasteUsersServiceUps];
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

@end
