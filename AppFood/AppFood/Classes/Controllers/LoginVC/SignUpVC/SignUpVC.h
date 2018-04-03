//
//  SignUpVC.h
//  AppFood
//
//  Created by HHumorous on 3/16/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "BaseVC.h"
#import "MButton.h"

@interface SignUpVC : BaseVC

@property (nonatomic, weak) IBOutlet UITextField *tfEmail;
@property (nonatomic, weak) IBOutlet UITextField *tfPassword;
@property (nonatomic, weak) IBOutlet UITextField *tfRePassword;
@property (nonatomic, weak) IBOutlet UITextField *tfFullName;
@property (nonatomic, weak) IBOutlet MButton *btnLogin;
@property (nonatomic, weak) IBOutlet MButton *btnRegister;

@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *repassword;
@property (nonatomic, strong) NSString *fullName;

@end
