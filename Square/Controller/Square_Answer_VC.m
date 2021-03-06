//
//  Square_Answer_VC.m
//  QFC
//
//  Created by tiaoxin on 2019/6/5.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Square_Answer_VC.h"

@interface Square_Answer_VC ()<PYPhotosViewDelegate, TZImagePickerControllerDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate, UITextViewDelegate, PublishTipViewDelegate>

@property (nonatomic, strong) YMTextView *Text_View;

@property (nonatomic, strong) PYPhotosView *photoView;

@property (nonatomic, strong) CustomBT *Address_BT;

@property (nonatomic, strong) CustomBT *Power_BT;

@property (nonatomic, strong) Publish_Tip_View *Tip_View;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *Publish_BT;

@property (nonatomic, strong) UIView *BackView;

@property (nonatomic, strong) NSString *Label_String;

@property (nonatomic, strong) NSString *textViewText;

@property (nonatomic, strong) NSMutableDictionary *Sure_parm;

@property (nonatomic, strong) NSString *setting_type;

@property (nonatomic, strong) NSString *type_id;

@end

@implementation Square_Answer_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.setting_type = @"1";
    [self setUPUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (IBAction)BackBTClick:(id)sender {
    [self.My_Nav popViewControllerAnimated:YES];
}


- (void)setUPUI {
    [self.view addSubview:self.BackView];
    [self.BackView addSubview:self.Text_View];
    [self.BackView addSubview:self.photoView];
    [self.BackView addSubview:self.Address_BT];
    [self.Text_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.BackView.mas_left).offset(10.0f);
        make.top.equalTo(self.BackView.mas_top).offset(10.0f);
        
        make.right.equalTo(self.BackView.mas_right).offset(-10.0f);
        make.height.offset(100.0f);
    }];
    [self.photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.BackView.mas_left).offset(10.0f);
        make.right.equalTo(self.BackView.mas_right).offset(-10.0f);
        make.top.equalTo(self.Text_View.mas_bottom).offset(10.0f);
        make.height.offset(115.0f);
    }];
    [self.Address_BT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.BackView.mas_left).offset(10.0f);
        make.top.equalTo(self.photoView.mas_bottom).offset(12.0f);
//        make.width.offset(65.0f);
        make.height.offset(17.0f);
    }];
    
    [self.BackView addSubview:self.Power_BT];
    [self.Power_BT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(65.0f, 17.0f));
        make.right.equalTo(self.BackView.mas_right).offset(-10.0f);
        make.top.equalTo(self.Address_BT.mas_top);
    }];
    [self.BackView addSubview:self.Tip_View];
    [self.Tip_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(91.0f, 149.0f));
        make.bottom.equalTo(self.Power_BT.mas_top).offset(- 5.0f);
        make.right.equalTo(self.Power_BT.mas_right);
    }];
    [self.BackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        if (is_IPhone_X) {
            make.top.equalTo(self.view.mas_top).offset(98.0f);
        }else {
            make.top.equalTo(self.view.mas_top).offset(74.0f);
        }
        make.bottom.equalTo(self.Power_BT.mas_bottom).offset(10.0f);
    }];
    
    
}

#pragma mark----懒加载

- (NSMutableDictionary *)Sure_parm {
    if (!_Sure_parm) {
        _Sure_parm = [[NSMutableDictionary alloc] init];
    }
    return _Sure_parm;
}

- (UIView *)BackView {
    if (!_BackView) {
        _BackView = [[UIView alloc] init];
        _BackView.backgroundColor = [UIColor whiteColor];
    }
    return _BackView;
}


- (Publish_Tip_View *)Tip_View {
    if (!_Tip_View) {
        _Tip_View = [[Publish_Tip_View alloc] init];
        _Tip_View.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_Tip_BackView"]];
        /// 添加四边阴影效果
        // 阴影颜色
        _Tip_View.layer.shadowColor = [UIColor blackColor].CGColor;
        // 阴影偏移，默认(0, -3)
        _Tip_View.layer.shadowOffset = CGSizeMake(0,0);
        // 阴影透明度，默认0
        _Tip_View.layer.shadowOpacity = 0.5;
        // 阴影半径，默认3
        _Tip_View.layer.shadowRadius = 2;
        _Tip_View.hidden = YES;
        _Tip_View.delegate = self;
    }
    return _Tip_View;
}


- (YMTextView *)Text_View {
    if (!_Text_View) {
        _Text_View = [[YMTextView alloc] init];
        _Text_View.placeholder = @"记录这个瞬间，晒你想晒的...";
        _Text_View.placeholderColor = [UIColor lightGrayColor];
        _Text_View.backgroundColor = [UIColor whiteColor];
        _Text_View.delegate = self;
    }
    return _Text_View;
}

- (PYPhotosView *)photoView {
    if (!_photoView) {
        _photoView = [[PYPhotosView alloc] init];
        _photoView.photoWidth = (SCREEN_WIDTH - 40.0f)/3.0f;
        _photoView.photoHeight = 115;
        _photoView.photosMaxCol = 3.0f;
        _photoView.imagesMaxCountWhenWillCompose = 9;
        _photoView.delegate = self;
    }
    return _photoView;
}

- (CustomBT *)Address_BT {
    if (!_Address_BT) {
        _Address_BT = [[CustomBT alloc] init];
        [_Address_BT setTitle:@"你在哪里" forState:UIControlStateNormal];
        [_Address_BT setImage:[UIImage imageNamed:@"icon_dingwei_hui"] forState:UIControlStateNormal];
        _Address_BT.BTStyle = ImageLeftTitleRight;
        _Address_BT.ImageTopTitleBottom_MultipliedBy = 0.6f;
        _Address_BT.ImageORTitle_Interval = 5.0f;
        _Address_BT.titleLabel.textAlignment = NSTextAlignmentLeft;
        _Address_BT.Interval = 5.0f;
        [_Address_BT setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _Address_BT.titleLabel.font = [UIFont systemFontOfSize:9.0f];
        _Address_BT.layer.cornerRadius = 9.0f;
        _Address_BT.backgroundColor = QFC_BackColor_Gray;
        [_Address_BT addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _Address_BT.tag = 498758;
    }
    return _Address_BT;
}

- (CustomBT *)Power_BT {
    if (!_Power_BT) {
        _Power_BT = [[CustomBT alloc] init];
        [_Power_BT setTitle:@"  全部可见" forState:UIControlStateNormal];
        [_Power_BT setImage:[UIImage imageNamed:@"icon_Xia_hui"] forState:UIControlStateNormal];
        _Power_BT.BTStyle = ImageRightTitleLeft;
        _Power_BT.ImageTopTitleBottom_MultipliedBy = 0.6f;
        _Power_BT.ImageORTitle_Interval = 5.0f;
        _Power_BT.titleLabel.textAlignment = NSTextAlignmentLeft;
        _Power_BT.Interval = 5.0f;
        [_Power_BT setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _Power_BT.titleLabel.font = [UIFont systemFontOfSize:9.0f];
        _Power_BT.layer.cornerRadius = 9.0f;
        _Power_BT.backgroundColor = QFC_BackColor_Gray;
        [_Power_BT addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _Power_BT.tag = 498757;
    }
    return _Power_BT;
}

#pragma mark----PYPhotosViewDelegate

- (void)photosView:(PYPhotosView *)photosView didAddImageClickedWithImages:(NSMutableArray *)images {
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
            TZImagePickerController *imagePickerController = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
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
    //   NSMutableArray *imageArr = self.photoView.images.count > 0 ? [self.photoView.images copy] : [[NSMutableArray alloc] init];
    
    NSMutableArray *imageArr = [[NSMutableArray alloc] init];
    if (self.photoView.images.count) {
        imageArr = self.photoView.images;
    }
    [imageArr addObjectsFromArray:photos];
    self.photoView.images = imageArr;
    [self.photoView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset([self.photoView sizeWithPhotoCount:self.photoView.images.count photosState:0]);
    }];
    //    self.photoView.images = [NSMutableArray arrayWithArray:photos];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //    NSMutableArray *imageArr = self.photoView.images.count > 0 ? [self.photoView.images copy] : [[NSMutableArray alloc] init];
    //    [imageArr addObject:image];
    //    self.photoView.images = imageArr;
    NSMutableArray *imageArr = [[NSMutableArray alloc] init];
    if (self.photoView.images.count) {
        imageArr = self.photoView.images;
    }
    [imageArr addObject:image];
    self.photoView.images = imageArr;
    [self.photoView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset([self.photoView sizeWithPhotoCount:self.photoView.images.count photosState:0]);
    }];
    //    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 * 删除图片按钮触发时调用此方法
 * imageIndex : 删除的图片在之前图片数组的位置
 */
- (void)photosView:(PYPhotosView *)photosView didDeleteImageIndex:(NSInteger)imageIndex {
    [self.photoView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset([self.photoView sizeWithPhotoCount:self.photoView.images.count photosState:0]);
    }];
}

//进入拍摄页面点击取消按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark----ButtonClick
- (void)ButtonClick:(UIButton *)button {
    switch (button.tag) {
        case 498757://广场可见
        {
            button.selected = !button.selected;
            if (button.selected) {
                self.Tip_View.hidden = NO;
            }else {
                self.Tip_View.hidden = YES;
            }
        }
            break;
        case 498758://位置
        {
            Publish_Location_VC *LocationVC = [[Publish_Location_VC alloc] init];
            MJWeakSelf;
            LocationVC.PublishLocationVCBlock = ^(NSString * _Nonnull Address, NSString * _Nonnull lat, NSString * _Nonnull longStr, NSString * _Nonnull name, NSString * _Nonnull province, NSString * _Nonnull city, NSString * _Nonnull district) {
                [weakSelf.Address_BT setTitle:Address forState:UIControlStateNormal];
                [weakSelf.Sure_parm setObject:Address forKey:@"address"];
                [weakSelf.Sure_parm setObject:longStr forKey:@"longitude"];
                [weakSelf.Sure_parm setObject:lat forKey:@"latitude"];
            };
            [self.navigationController pushViewController:LocationVC animated:YES];
        }
            break;
        case 498759://添加标签
        {
            Publish_Lable_VC *LabelVC = [[Publish_Lable_VC alloc] init];
            MJWeakSelf;
            LabelVC.publickBlock = ^(NSString * _Nonnull LabelString) {
                weakSelf.Label_String = LabelString;
                [weakSelf.Sure_parm setObject:LabelString forKey:@"label"];
                [weakSelf getNSAttributedString];
            };
            [self.navigationController pushViewController:LabelVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (void)ClassifyButtonClick:(UIButton *)button {
    if (button.tag == 694840) {
        return;
    }
    if (button.tag == 694844) {
        self.photoView.hidden = YES;
        [self.photoView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(0);
        }];
    }else {
        self.photoView.hidden = NO;
        if (self.photoView.images.count) {
            [self.photoView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.size.mas_offset([self.photoView sizeWithPhotoCount:self.photoView.images.count photosState:0]);
            }];
        }else {
            [self.photoView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.offset(115.0f);
            }];
        }
    }
}


- (IBAction)PublishButtonClick:(id)sender {
    if (!self.textViewText.length) {
        [MBProgressHUD py_showError:@"请输入发布内容" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
        return;
    }else {
        if (self.photoView.images.count) {
            [self setImageToBacker];
        }else {
            [self addDataSoureToBacker];
        }
    }
}

- (void)setImageToBacker {
    NSMutableArray *imageArray = [[NSMutableArray alloc] init];
    for (UIImage *photo in self.photoView.images) {
        UploadParam *image = [[UploadParam alloc] init];
        image.data = UIImagePNGRepresentation(photo);
        image.name = @"file[]";
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        image.filename = str;
        image.mimeType = @".jpg";
        [imageArray addObject:image];
    }
    [[HttpRequest sharedInstance] uploadWithURLString:URL_commom_moreFiles parameters:nil uploadParam:imageArray success:^(NSDictionary * _Nonnull success) {
        NSLog(@"%@", success);
        [self.Sure_parm setObject:[success objectForKey:@"list"] forKey:@"imgurl"];
        [self addDataSoureToBacker];
        
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

#pragma mark----UPdata
 /**
 社区广场 回答问题
 URL : https://www.txkuaiyou.com/index/Plazas/answerQuestion
 参数 :
 content
 内容
 uid
 用户ID
 address
 定位地址
 longitude
 经度
 latitude
 纬度
 id
 问题ID
 imgurl
 图片 [图片1url,图片2url]
 setting
 1所有可看2广场3主页4自己
 */
- (void)addDataSoureToBacker {
    [self.Sure_parm setObject:self.textViewText forKey:@"content"];
    [self.Sure_parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [self.Sure_parm setObject:self.setting_type forKey:@"setting"];
    [self.Sure_parm setObject:self.Answerid forKey:@"id"];
    [[HttpRequest sharedInstance] postWithURLString:URL_Plazas_answerQuestion parameters:self.Sure_parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showError:@"发布成功" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"发布失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}


- (void)getNSAttributedString {
    NSArray * LabelArray = [self.Label_String componentsSeparatedByString:@","];
    NSString *LabelString = @"";
    for (NSString *Str in LabelArray) {
        if (LabelString.length) {
            LabelString = [NSString stringWithFormat:@"%@#%@", LabelString,Str];
        }else {
            LabelString = [NSString stringWithFormat:@"%@#%@", LabelString,Str];
        }
    }
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:self.Text_View.text];
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, noteStr.length)];
    // 改变颜色
    NSMutableAttributedString * redStr = [[NSMutableAttributedString alloc] initWithString:LabelString];
    [redStr addAttribute:NSForegroundColorAttributeName value:QFC_Color_32CCF2 range:NSMakeRange(0, redStr.length)];
    // 改变字体大小及类型
    //    [noteStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-BoldOblique" size:27] range:range];
    // 为label添加Attributed
    self.Text_View.font = [UIFont systemFontOfSize:16.0f weight:UIFontWeightMedium];
    [noteStr appendAttributedString:redStr];
    [self.Text_View setAttributedText:noteStr];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    self.textViewText = textView.text;
    [self getNSAttributedString];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    textView.textColor = [UIColor blackColor];
    textView.text = self.textViewText;
}

#pragma mark----PublishTipViewDelegate
- (void)PublishTipViewButtonClick:(NSInteger)index {
    switch (index) {
        case 0:
        {
            [self.Power_BT setTitle:@"  全部可见" forState:UIControlStateNormal];
            [self.Sure_parm setObject:@"1" forKey:@"setting"];
            self.setting_type = @"1";
        }
            break;
        case 1:
        {
            [self.Power_BT setTitle:@"  广场可见" forState:UIControlStateNormal];
            [self.Sure_parm setObject:@"2" forKey:@"setting"];
            self.setting_type = @"2";
        }
            break;
        case 2:
        {
            [self.Power_BT setTitle:@"  主页可见" forState:UIControlStateNormal];
            [self.Sure_parm setObject:@"3" forKey:@"setting"];
            self.setting_type = @"3";
        }
            break;
        default:
        {
            [self.Power_BT setTitle:@"  自己可见" forState:UIControlStateNormal];
            [self.Sure_parm setObject:@"4" forKey:@"setting"];
            self.setting_type = @"4";
        }
            break;
    }
    self.Tip_View.hidden = YES;
}





@end
