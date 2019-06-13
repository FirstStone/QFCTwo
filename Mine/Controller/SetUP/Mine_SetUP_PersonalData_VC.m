//
//  Mine_SetUP_PersonalData_VC.m
//  QFC
//
//  Created by tiaoxin on 2019/4/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_SetUP_PersonalData_VC.h"
#define CellID_MineSetUPCell @"MineSetUPCell"
#define CellID_MineSetUPTitleimageCell @"MineSetUPTitleimageCell"
@interface Mine_SetUP_PersonalData_VC ()<UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate, TZImagePickerControllerDelegate, PickerViewResultDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *Title_Array;

@property (nonatomic, strong) UIImageView *icon_View;

@property (nonatomic, strong) Mine_UserMessage_Model *My_Model;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *Sure_BT;

@end

@implementation Mine_SetUP_PersonalData_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.Title_Array = @[@"头像", @"昵称", @"性别", @"生日", @"故乡", @"我的标签"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_SetUP_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MineSetUPCell];
    [self.tableView registerClass:[Mine_SetUP_Title_image_Cell class] forCellReuseIdentifier:CellID_MineSetUPTitleimageCell];
    [self LoadingDataSoure];
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


- (IBAction)LiftButtonPOP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)SureButtonClick:(id)sender {
    [self UploadImageToBacker:self.icon_View.image];
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
        switch (indexPath.row) {
            case 1://昵称
            {
                cell.SubTitle_Label.text = self.My_Model.nickname;
            }
                break;
            case 2://性别
            {
                cell.SubTitle_Label.text = [self.My_Model.sex intValue] == 1 ? @"男" : @"女";
            }
                break;
            case 3://生日
            {
                cell.SubTitle_Label.text = [NSString stringWithFormat:@"%@-%@-%@", self.My_Model.year, self.My_Model.month, self.My_Model.day];
            }
                break;
            case 4://故乡
            {
                cell.SubTitle_Label.text = [NSString stringWithFormat:@"%@ %@ %@", self.My_Model.province, self.My_Model.city, self.My_Model.county];
            }
                break;
            default://我的标签
            {
                cell.SubTitle_Label.text = self.My_Model.signature;
            }
                break;
        }
        return cell;
    }
    
    /*else if (indexPath.row == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableviewCellfirst"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableviewCellfirst"];
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
                imageView.image = [UIImage imageNamed:@"icon_Mine_SetUP_erweima_hui"];
                imageView;
            });
            [cell.contentView addSubview:icon_ImageView];
            [icon_ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_offset(CGSizeMake(20.0f, 20.0f));
                make.centerY.equalTo(title_Label.mas_centerY);
                make.right.equalTo(cell.contentView.mas_right).offset(-10.0f);
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
    }*/
    /*if (indexPath.row == 0) {
        Mine_SetUP_Title_image_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineSetUPTitleimageCell];
        if (!cell) {
            cell = [[Mine_SetUP_Title_image_Cell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellID_MineSetUPTitleimageCell];
        }
        cell.title_Label.text = self.Title_Array[indexPath.row];
        return cell;
    }else if (indexPath.row == 1) {
        Mine_SetUP_Title_image_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineSetUPTitleimageCell];
        if (!cell) {
            cell = [[Mine_SetUP_Title_image_Cell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellID_MineSetUPTitleimageCell];
            [cell.photo_ImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.size.mas_offset(CGSizeMake(30.0f, 30.0f));
                make.centerY.equalTo(cell.title_Label.mas_centerY);
                make.right.equalTo(cell.contentView.mas_right).offset(-10.0);
            }];
        }
        cell.title_Label.text = self.Title_Array[indexPath.row];
        cell.icon_ImageView.hidden = YES;
        cell.photo_ImageView.image = [UIImage imageNamed:@"icon_Mine_SetUP_erweima_hui"];
        return cell;
    }else {
        Mine_SetUP_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineSetUPCell];
        cell.Title_Label.text = self.Title_Array[indexPath.row];
        return cell;
    }
    
     XBMyPlayerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    //cell右箭头
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    XBPlayModel *model = [self.dataArray objectAtIndex:indexPath.row];
    [cell setupUI:model]; //数据赋值*/
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0://头像
        {
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
        case 1://昵称
        {
            Mine_SetUP_PersonalData_Nickname_VC *PersonaVC = [[Mine_SetUP_PersonalData_Nickname_VC alloc] init];
            PersonaVC.textStr = self.My_Model.nickname;
            MJWeakSelf;
            PersonaVC.MineSetUPPersonaBlack = ^(NSString * _Nonnull TextStr) {
                weakSelf.My_Model.nickname = TextStr;
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
            pick.tag = 23474;
            [self.view addSubview:pick];
        }
            break;
        case 3://生日
        {
            PickerView *pick = [[PickerView alloc] init];
            pick.delegate = self;
            pick.type = PickerViewTypeBirthday;
            pick.tag = 23475;
            [self.view addSubview:pick];
        }
            break;
        case 4://故乡
        {
            PickerView *pick = [[PickerView alloc] init];
            pick.delegate = self;
            pick.type = PickerViewTypeCity;
            pick.tag = 23476;
            [self.view addSubview:pick];
        }
            break;
        default://我的标签
        {
            Mine_SetUP_MyLabel_VC *MyLabelVC = [[Mine_SetUP_MyLabel_VC alloc] init];
            MyLabelVC.textStr = self.My_Model.signature;
            MJWeakSelf;
            MyLabelVC.MineSetUPBlack = ^(NSString * _Nonnull TextStr) {
                weakSelf.My_Model.signature = TextStr;
                [weakSelf.tableView reloadData];
            };
            [MyLabelVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:MyLabelVC animated:YES];
        }
            break;
    }
}

#pragma mark----PickerViewResultDelegate
- (void)pickerView:(UIView *)pickerView result:(NSString *)string {
    if (pickerView.tag == 23474) {//性别
        if ([string containsString:@"男"]) {
            self.My_Model.sex = @"1";
        }else {
            self.My_Model.sex = @"2";
        }
        [self.tableView reloadData];
    }else if (pickerView.tag == 23475){//年月日
        NSArray * GoodsArray = [string componentsSeparatedByString:@"-"];
        self.My_Model.year = GoodsArray[0];
        self.My_Model.month = GoodsArray[1];
        self.My_Model.day = GoodsArray[2];
        [self.tableView reloadData];
    }else if (pickerView.tag == 23476){//故乡
        NSArray * GoodsArray = [string componentsSeparatedByString:@"-"];
        self.My_Model.province = GoodsArray[0];
        self.My_Model.city = GoodsArray[1];
        self.My_Model.county = GoodsArray[2];
        [self.tableView reloadData];
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
    //   NSMutableArray *imageArr = self.photoView.images.count > 0 ? [self.photoView.images copy] : [[NSMutableArray alloc] init];
    self.icon_View.image = photos[0];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.icon_View.image = image;
}


#pragma mark----UPdata
/**
 修改个人信息获取数据
 URL : https://www.txkuaiyou.com/index/centres/FindUserInfo
 参数 :
 uid
 用户ID
 */
- (void)LoadingDataSoure {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_centres_FindUserInfo parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSDictionary *DicDataSoure = [responseObject objectForKey:@"info"];
            self.My_Model = [Mine_UserMessage_Model mj_objectWithKeyValues:DicDataSoure];
            [self.icon_View sd_setImageWithURL:[NSURL URLWithString:self.My_Model.avatar]];
        }
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

/**
 修改个人信息
 URL : https://www.txkuaiyou.com/index/centres/UpFindUserInfo
 参数 :
 uid
 用户ID
 birthday
 出生日期  2222-22-22
 hometown
 故乡   山东 菏泽 曹县
 avatar
 头像
 nickname
 昵称
 sex
 1男2女
 signature
 签名
 */
- (void)UPdataSoureSeleMessage:(NSString *)imageURL {
    self.Sure_BT.enabled = YES;
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:[NSString stringWithFormat:@"%@-%@-%@", self.My_Model.year, self.My_Model.month, self.My_Model.day] forKey:@"birthday"];
    [parm setObject:[NSString stringWithFormat:@"%@ %@ %@", self.My_Model.province, self.My_Model.city, self.My_Model.county] forKey:@"hometown"];
    [parm setObject:imageURL forKey:@"avatar"];
    [parm setObject:self.My_Model.nickname forKey:@"nickname"];
    [parm setObject:self.My_Model.sex forKey:@"sex"];
    [parm setObject:self.My_Model.signature forKey:@"signature"];
    [[HttpRequest sharedInstance] postWithURLString:URL_centres_UpFindUserInfo parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        self.Sure_BT.enabled = YES;
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
//            NSDictionary *DicDataSoure = [responseObject objectForKey:@"info"];
            [MBProgressHUD py_showError:@"修改成功" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
//            self.My_Model = [Mine_UserMessage_Model mj_objectWithKeyValues:DicDataSoure];
//            [self.icon_View sd_setImageWithURL:[NSURL URLWithString:self.My_Model.avatar]];
        }else {
            [MBProgressHUD py_showError:@"修改失败" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        self.Sure_BT.enabled = NO;
        [MBProgressHUD py_showError:@"操作失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

#pragma mark----DataSoureToBacker

- (void)UploadImageToBacker:(UIImage *)Photo {
    UploadParam *image = [[UploadParam alloc] init];
    image.data = UIImagePNGRepresentation(Photo);
    image.name = @"file";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    image.filename = str;
    image.mimeType = @".jpg";
    [[HttpRequest sharedInstance] uploadWithURLString:URL_userFiles parameters:nil uploadParam:@[image] success:^(NSDictionary * _Nonnull success) {
        NSLog(@"%@", success);
        if ([success objectForKey:@"status"]) {
            [self UPdataSoureSeleMessage:[success objectForKey:@"url"]];
        }else {
            [MBProgressHUD py_showError:@"上传失败" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
    } failure:^(NSError * _Nonnull error) {
        self.Sure_BT.enabled = NO;
        NSLog(@"%@",error);
        [MBProgressHUD py_showError:@"上传失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

@end
