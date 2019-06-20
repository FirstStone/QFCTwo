//
//  Mine_SettledIn_RunErrands_ViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/4/24.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_SettledIn_RunErrands_ViewController.h"

@interface Mine_SettledIn_RunErrands_ViewController ()<PYPhotosViewDelegate, TZImagePickerControllerDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate, PickerViewResultDelegate, UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollerView;
@property (strong, nonatomic) IBOutlet UIButton *Sure_BT;


@property (nonatomic, strong) LabelAndTextField *RunErrands_Name_View;
@property (nonatomic, strong) LabelAndTextField *RunErrands_Sex_View;
@property (nonatomic, strong) LabelAndTextField *RunErrands_Order_View;
@property (nonatomic, strong) LabelAndTextField *RunErrands_PhoneNumber_View;
@property (nonatomic, strong) LabelAndTextField *RunErrands_Address_View;

@property (nonatomic, strong) PickerView *sex_pickView;
@property (nonatomic, strong) UIImageView *RunErrands_PhotoView;

@property (nonatomic, strong) PYPhotosView *IDCard_Positive_View;
@property (nonatomic, strong) PYPhotosView *IDCard_Back_View;
@property (nonatomic, strong) PYPhotosView *IDCard_Hand_View;
/**1 头像 2 身份证正面 3 身份证反面 4 手持身份证*/
@property (nonatomic, assign) NSInteger Style_Photo;

@property (nonatomic, strong) NSMutableArray *imageArray;

@property (nonatomic, strong) NSMutableDictionary *parm;

@property (nonatomic, strong) NSArray *sex_Array;

@end

@implementation Mine_SettledIn_RunErrands_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUPUI];
}
- (NSMutableArray *)imageArray {
    if (!_imageArray) {
        _imageArray = [[NSMutableArray alloc] init];
    }
    return _imageArray;
}

- (NSArray *)sex_Array {
    if (!_sex_Array) {
        _sex_Array = [[NSArray alloc] init];
        _sex_Array = @[@"男", @"女"];
    }
    return _sex_Array;
}

- (PickerView *)sex_pickView {
    if (!_sex_pickView) {
        _sex_pickView = [[PickerView alloc] init];
        _sex_pickView.delegate = self;
        _sex_pickView.type = PickerViewTypeSex;
    }
    return _sex_pickView;
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
    //头像
    UIView *RunErrandsView = [self getRunErrandsPhotoView];
    [contView addSubview:RunErrandsView];
    [RunErrandsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(contView);
        make.height.offset(50.0f);
    }];
    [contView addSubview:self.RunErrands_Name_View];
    [self.RunErrands_Name_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(RunErrandsView);
        make.top.equalTo(RunErrandsView.mas_bottom);
    }];
    [contView addSubview:self.RunErrands_Sex_View];
    [self.RunErrands_Sex_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.RunErrands_Name_View);
        make.top.equalTo(self.RunErrands_Name_View.mas_bottom);
    }];
    [contView addSubview:self.RunErrands_Order_View];
    [self.RunErrands_Order_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.RunErrands_Name_View);
        make.top.equalTo(self.RunErrands_Sex_View.mas_bottom);
    }];
    [contView addSubview:self.RunErrands_PhoneNumber_View];
    [self.RunErrands_PhoneNumber_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.RunErrands_Name_View);
        make.top.equalTo(self.RunErrands_Order_View.mas_bottom);
    }];
    [contView addSubview:self.RunErrands_Address_View];
    [self.RunErrands_Address_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.RunErrands_Name_View);
        make.top.equalTo(self.RunErrands_PhoneNumber_View.mas_bottom);
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
        make.top.equalTo(self.RunErrands_Address_View.mas_bottom).offset(10.0f);
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

- (LabelAndTextField *)RunErrands_Name_View {
    if (!_RunErrands_Name_View) {
        _RunErrands_Name_View = [[LabelAndTextField alloc] init];
        _RunErrands_Name_View.Title_Label.text = @"姓    名：";
        _RunErrands_Name_View.Text_Field.placeholder = @"请输入姓名";
    }
    return _RunErrands_Name_View;
}

- (LabelAndTextField *)RunErrands_Sex_View {
    if (!_RunErrands_Sex_View) {
        _RunErrands_Sex_View = [[LabelAndTextField alloc] init];
        _RunErrands_Sex_View.Title_Label.text = @"性    别：";
        _RunErrands_Sex_View.Text_Field.placeholder = @"请输入性别";
        _RunErrands_Sex_View.Text_Field.delegate = self;
        _RunErrands_Sex_View.Text_Field.tag = 7947477;
    }
    return _RunErrands_Sex_View;
}

- (LabelAndTextField *)RunErrands_Order_View {
    if (!_RunErrands_Order_View) {
        _RunErrands_Order_View = [[LabelAndTextField alloc] init];
        _RunErrands_Order_View.Title_Label.text = @"年    龄：";
        _RunErrands_Order_View.Text_Field.placeholder = @"请输入年龄";
        _RunErrands_Order_View.Text_Field.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _RunErrands_Order_View;
}

- (LabelAndTextField *)RunErrands_PhoneNumber_View {
    if (!_RunErrands_PhoneNumber_View) {
        _RunErrands_PhoneNumber_View = [[LabelAndTextField alloc] init];
        _RunErrands_PhoneNumber_View.Title_Label.text = @"手 机 号：";
        _RunErrands_PhoneNumber_View.Text_Field.placeholder = @"请输入手机号";
        _RunErrands_PhoneNumber_View.Text_Field.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _RunErrands_PhoneNumber_View;
}

- (LabelAndTextField *)RunErrands_Address_View {
    if (!_RunErrands_Address_View) {
        _RunErrands_Address_View = [[LabelAndTextField alloc] init];
        _RunErrands_Address_View.Title_Label.text = @"服务地址：";
        _RunErrands_Address_View.Text_Field.placeholder = @"请输入服务地址";
        _RunErrands_Address_View.Text_Field.tag = 7947476;
        _RunErrands_Address_View.Text_Field.delegate = self;
    }
    return _RunErrands_Address_View;
}

- (UIImageView *)RunErrands_PhotoView {
    if (!_RunErrands_PhotoView) {
        _RunErrands_PhotoView = [[UIImageView alloc] init];
        _RunErrands_PhotoView.image = [UIImage imageNamed:@"icon_touxiang"];
        _RunErrands_PhotoView.layer.cornerRadius = 18.0f;
        _RunErrands_PhotoView.layer.masksToBounds = YES;
    }
    return _RunErrands_PhotoView;
}

//店铺头像
- (UIView *)getRunErrandsPhotoView {
    UIView *contView = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view;
    });
    UILabel *title_lable = ({
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:14.0f weight:UIFontWeightBold];
        label.textColor = QFC_Color_333333;
        label.text = @"头    像：";
        label;
    });
    [contView addSubview:title_lable];
    [title_lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contView.mas_left).offset(20.0f);
        make.top.bottom.equalTo(contView);
    }];
    [contView addSubview:self.RunErrands_PhotoView];
    [self.RunErrands_PhotoView mas_makeConstraints:^(MASConstraintMaker *make) {
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
        self.RunErrands_PhotoView.image = [photos firstObject];
    }else if (self.Style_Photo == 2) {//身份证正面
        self.IDCard_Positive_View.images = [NSMutableArray arrayWithArray:photos];
    }else if (self.Style_Photo == 3) {//身份证反面
        self.IDCard_Back_View.images = [NSMutableArray arrayWithArray:photos];
    }else {//手持身份证
        self.IDCard_Hand_View.images = [NSMutableArray arrayWithArray:photos];
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (self.Style_Photo == 1) {//头像
        self.RunErrands_PhotoView.image = image;
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

#pragma mark----DataSoureToBacker

- (void)UploadImageToBacker:(UIImage *)Photo group:(dispatch_group_t *)group {
    UploadParam *image = [[UploadParam alloc] init];
    image.data = UIImagePNGRepresentation(Photo);
    image.name = @"file";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    image.filename = str;
    image.mimeType = @".jpg";
    [[HttpRequest sharedInstance] uploadWithURLString:URL_userFiles parameters:nil uploadParam:@[image] success:^(NSDictionary * _Nonnull success) {
        [self.imageArray addObject:success];
        NSLog(@"%@",success);
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [MBProgressHUD py_showError:@"上传失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

- (IBAction)SureBTClick:(id)sender {
    if (!self.RunErrands_Name_View.Text_Field.text.length) {
        [MBProgressHUD py_showSuccess:@"请输入姓名" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }else if (!self.RunErrands_Sex_View.Text_Field.text.length) {
        [MBProgressHUD py_showSuccess:@"请输入性别" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }else if (!self.RunErrands_Order_View.Text_Field.text.length) {
        [MBProgressHUD py_showSuccess:@"请输入年龄" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }else if (!self.RunErrands_PhoneNumber_View.Text_Field.text.length) {
        [MBProgressHUD py_showSuccess:@"请输入手机号" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }else if (!self.RunErrands_Address_View.Text_Field.text.length) {
        [MBProgressHUD py_showSuccess:@"请输入服务地址" toView:nil];
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

- (void)UploadingImage {
    UIImage *Photo = self.RunErrands_PhotoView.image;
    
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
    //添加分组内的最后一个任务
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if (self.imageArray.count == 4) {
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
 //服务商入驻 跑腿入驻    just身份证正面 against身份证反面  hand手持  sex1男2女
 Route::rule('errandenter/:uid/:realname/:avatar/:sex/:age/:phone/:address/:just/:against/:hand/','index/Users/errandEnter');

 */

#pragma mark----UPdata
- (void)setDataSoureToBacker {
    [self.parm setObject:self.RunErrands_Name_View.Text_Field.text forKey:@"realname"];
    [self.parm setObject:self.RunErrands_Order_View.Text_Field.text forKey:@"age"];
    [self.parm setObject:self.RunErrands_PhoneNumber_View.Text_Field.text forKey:@"phone"];
    [self.parm setObject:self.RunErrands_Address_View.Text_Field.text forKey:@"address"];
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
            [MBProgressHUD setAnimationDelay:0.7f];
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
    self.RunErrands_Sex_View.Text_Field.text = string;
    [self.parm setObject:[self.RunErrands_Sex_View.Text_Field.text isEqualToString:@"男"] ? @"1" : @"2" forKey:@"sex"];
}

#pragma mark----UITextFieldDelegate
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
//
//    return YES;
//}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField.tag == 7947477) {//性别
        PickerView *pick = [[PickerView alloc] init];
        pick.delegate = self;
        pick.type = PickerViewTypeSex;
        [self.view addSubview:pick];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField.tag ==  7947476) {//地址
        Publish_Location_VC *LocationVC = [[Publish_Location_VC alloc] init];
        //    MJWeakSelf;
        LocationVC.PublishLocationVCBlock = ^(NSString * _Nonnull Address, NSString * _Nonnull lat, NSString * _Nonnull longStr) {
            //        [weakSelf.Sure_parm setObject:Address forKey:@"address"];
            textField.text = Address;
        };
        [self.navigationController pushViewController:LocationVC animated:YES];
        return NO;
    }else {
        return YES;
    }
}
@end
