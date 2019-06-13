//
//  Mine_SetUP_MyAddress_Cell.h
//  QFC
//
//  Created by tiaoxin on 2019/4/18.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class Mine_SetUP_MyAddress_Model;

@protocol MineSetUPMyAddressCellDelegate <NSObject>

- (void)MineSetUPMyAddressCellEditButtonClick:(Mine_SetUP_MyAddress_Model *)modle button:(UIButton *)BT;
- (void)MineSetUPMyAddressCellDelectButtonClick:(Mine_SetUP_MyAddress_Model *)modle button:(UIButton *)BT;

- (void)MineSetUPMyAddressCellDefaltButtonClick:(Mine_SetUP_MyAddress_Model *)modle button:(UIButton *)BT;


@end

@interface Mine_SetUP_MyAddress_Cell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *Name_Label;

@property (strong, nonatomic) IBOutlet UILabel *Phone_Label;

@property (strong, nonatomic) IBOutlet UILabel *Address_Label;

@property (strong, nonatomic) IBOutlet UIButton *Default_BT;

@property (strong, nonatomic) IBOutlet UIButton *Edit_BT;

@property (strong, nonatomic) IBOutlet UIButton *Delect_BT;

- (void)setModelToCell:(Mine_SetUP_MyAddress_Model *)model;

@property (nonatomic, assign) id <MineSetUPMyAddressCellDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
