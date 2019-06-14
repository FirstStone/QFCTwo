//
//  Mine_MyOrder_UserTuikuan_ViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/6/13.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_MyOrder_UserTuikuan_ViewController.h"

@interface Mine_MyOrder_UserTuikuan_ViewController ()<PYPhotosViewDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate, TZImagePickerControllerDelegate, PickerViewResultDelegate>

@property (strong, nonatomic) IBOutlet UILabel *OrderNumber_Label;

@property (strong, nonatomic) IBOutlet UILabel *Time_Label;

@property (strong, nonatomic) IBOutlet UIView *Reason_View;

@property (strong, nonatomic) IBOutlet UILabel *Price_Label;

@property (strong, nonatomic) IBOutlet UITextField *Text_Label;

@property (strong, nonatomic) IBOutlet PYPhotosView *photoView;

@property (strong, nonatomic) IBOutlet UILabel *Reason_Label;

@end

@implementation Mine_MyOrder_UserTuikuan_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.OrderNumber_Label.text = self.MyOrder.ordersn;
    self.Time_Label.text = self.MyOrder.createtime;
    self.Price_Label.text = [NSString stringWithFormat:@"¥%@", self.MyOrder.actual_price];
    self.photoView.photoWidth = (SCREEN_WIDTH - 40.0f)/3.0f;
    self.photoView.photoHeight = 115.0f;
    self.photoView.photosMaxCol = 3.0f;
    self.photoView.imagesMaxCountWhenWillCompose = 3;
    self.photoView.delegate = self;
    UITapGestureRecognizer *TapZer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ReasonViewButtonClick:)];
    [self.Reason_View addGestureRecognizer:TapZer];
    
}

- (IBAction)LiftButtonPOP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)SureButtonClick:(id)sender {
    if (self.photoView.images.count && ![self.Reason_Label.text isEqualToString:@"请选择"]) {
        [self setImageToBacker];
    }else if (![self.Reason_Label.text isEqualToString:@"请选择"]) {
        [self LoadingDataSoure:@""];
    }else {
        [MBProgressHUD py_showError:@"请选择退款原因" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }
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
            TZImagePickerController *imagePickerController = [[TZImagePickerController alloc] initWithMaxImagesCount:3 delegate:self];
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
    [MBProgressHUD py_showLoading:@"正在提交..." toView:nil];
    [[HttpRequest sharedInstance] uploadWithURLString:URL_commom_moreFiles parameters:nil uploadParam:imageArray success:^(NSDictionary * _Nonnull success) {
        NSLog(@"%@", success);
//        [self.Sure_parm setObject:[success objectForKey:@"list"] forKey:@"imgurl"];
        [self LoadingDataSoure:[success objectForKey:@"list"]];
        
        
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD setAnimationDelay:0.7f];
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

#pragma mark----UPdata
- (void)LoadingDataSoure:(NSString *)imageURL {
    /**
     订单退款
     URL : https://www.txkuaiyou.com/index/orders/orderRefund
     参数 :
     orderid
     订单ID
     uid
     用户ID
     cause
     退款原因
     remark
     备注
     cause_img
     图片 逗号隔开
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:self.MyOrder.order_ID forKey:@"orderid"];
    [parm setObject:self.Reason_Label.text forKey:@"cause"];
    [parm setObject:self.Text_Label.text forKey:@"remark"];
    [parm setObject:imageURL forKey:@"cause_img"];
    [[HttpRequest sharedInstance] postWithURLString:URL_orders_orderRefund parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        [MBProgressHUD setAnimationDelay:0.7f];
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showError:@"申请已提交" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [MBProgressHUD py_showError:@"提交失败" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD setAnimationDelay:0.7f];
        [MBProgressHUD py_showError:@"操作失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

- (void)ReasonViewButtonClick:(UIGestureRecognizer *)Zer {
    PickerView *pick = [[PickerView alloc] init];
    pick.delegate = self;
    pick.type = PickerViewTypeReason;
    [self.view addSubview:pick];
}

#pragma mark----PickerViewResultDelegate

- (void)pickerView:(UIView *)pickerView result:(NSString *)string {
    self.Reason_Label.text = string;
}

@end
