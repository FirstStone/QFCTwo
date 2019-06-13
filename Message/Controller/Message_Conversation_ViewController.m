//
//  Message_Conversation_ViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/6/13.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Message_Conversation_ViewController.h"

@interface Message_Conversation_ViewController ()

@end

@implementation Message_Conversation_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *userName = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid]];
    [[EMClient sharedClient] loginWithUsername:userName
                                      password:@"123456"
                                    completion:^(NSString *aUsername, EMError *aError) {
                                        if (!aError) {
                                            NSLog(@"登录成功");
                                        } else {
                                            NSLog(@"登录失败");
                                        }
                                    }];
}


@end
