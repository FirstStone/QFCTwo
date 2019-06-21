//
//  Mine_SetUP_PersonalData_Nickname_VC.h
//  QFC
//
//  Created by tiaoxin on 2019/6/10.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Basic_ViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^MineSetUPPersonalDataNicknameVCBlack)(NSString *TextStr);
@interface Mine_SetUP_PersonalData_Nickname_VC : Basic_ViewController

@property (strong, nonatomic) IBOutlet UINavigationBar *Navigation;

@property (nonatomic, assign) NSInteger Number;

@property (nonatomic, strong) NSString *textStr;

@property (nonatomic, copy) MineSetUPPersonalDataNicknameVCBlack MineSetUPPersonaBlack;

@end

NS_ASSUME_NONNULL_END
