//
//  Mine_RunErrands_ServiceViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/4/28.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_RunErrands_ServiceViewController.h"
#define CellID_MineSetUPCell @"MineSetUPCell"
#define CellID_MineSetUPTitleimageCell @"MineSetUPTitleimageCell"

@interface Mine_RunErrands_ServiceViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *Title_Array;

@property (nonatomic, strong) UIImageView *icon_View;

@property (nonatomic, strong) Mine_MyShopStore_Model *Shop_Model;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *Sure_BT;


@end

@implementation Mine_RunErrands_ServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.Title_Array = @[@"头像", @"手机号", @"联系地址"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_SetUP_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MineSetUPCell];
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
        [self.icon_View sd_setImageWithURL:[NSURL URLWithString:self.Shop_Model.avatar]];
        return cell;
    }else {
        Mine_SetUP_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineSetUPCell];
        cell.Title_Label.text = self.Title_Array[indexPath.row];
        if (indexPath.row == 1) {
            cell.SubTitle_Label.text = self.Shop_Model.phone;
        } else {
            cell.SubTitle_Label.text = self.Shop_Model.address;
        }
        return cell;
    }
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
            break;
        case 1://手机号
        {
            Mine_SetUP_PersonalData_Nickname_VC *PersonaVC = [[Mine_SetUP_PersonalData_Nickname_VC alloc] init];
            PersonaVC.Number = 2;
            PersonaVC.textStr = self.Shop_Model.phone;
            MJWeakSelf;
            PersonaVC.MineSetUPPersonaBlack = ^(NSString * _Nonnull TextStr) {
                weakSelf.Shop_Model.phone = TextStr;
                [weakSelf.tableView reloadData];
            };
            [PersonaVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:PersonaVC animated:YES];
        }
            break;
        case 2://联系地址
        {
            Publish_Location_VC *LocationVC = [[Publish_Location_VC alloc] init];
            MJWeakSelf;
            LocationVC.PublishLocationVCBlock = ^(NSString * _Nonnull Address, NSString * _Nonnull lat, NSString * _Nonnull longStr) {
                weakSelf.Shop_Model.address = Address;
                weakSelf.Shop_Model.longitude = longStr;
                weakSelf.Shop_Model.latitude = lat;
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
    //   NSMutableArray *imageArr = self.photoView.images.count > 0 ? [self.photoView.images copy] : [[NSMutableArray alloc] init];
    self.icon_View.image = photos[0];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.icon_View.image = image;
}

#pragma mark----UPdata
- (void)LoadingDataSoure {
    /**
     服务上信息获取
     URL : https://www.txkuaiyou.com/index/centres/serviceInfo
     参数 :
     uid
     用户ID
     type
     服务商类型
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:@"1" forKey:@"type"];
    [[HttpRequest sharedInstance] postWithURLString:URL_centres_serviceInfo parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSDictionary *infoDic = [responseObject objectForKey:@"info"];
            if (infoDic) {
                self.Shop_Model = [Mine_MyShopStore_Model mj_objectWithKeyValues:infoDic];
            }
            [self.tableView reloadData];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

#pragma mark----UPdata

- (void)UploadImageToBacker:(UIImage *)Photo {
    self.Sure_BT.enabled = YES;
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

- (void)UPdataSoureSeleMessage:(NSString *)imageURL {
    /**
     跑腿信息修改
     URL : https://www.txkuaiyou.com/index/centres/UpServiceInfo
     参数 :
     serviceid
     服务商ID
     type
     1
     phone
     手机号
     avatar
     头像
     address
     地址
     longitude
     经度
     latitude
     纬度
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"serviceid"];
    [parm setObject:@"1" forKey:@"type"];
    [parm setObject:self.Shop_Model.phone forKey:@"phone"];
    [parm setObject:imageURL forKey:@"avatar"];
    [parm setObject:self.Shop_Model.longitude forKey:@"longitude"];
    [parm setObject:self.Shop_Model.latitude forKey:@"latitude"];
    [[HttpRequest sharedInstance] postWithURLString:URL_centres_UpServiceInfo parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showError:@"信息修改成功" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"操作失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}



@end
