//
//  SignInVC.h
//  AppFood
//
//  Created by HHumorous on 3/16/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "BaseVC.h"
#import "HButton.h"

@interface SignInVC : BaseVC

@property (nonatomic, weak) IBOutlet UITextField *tfEmail;
@property (nonatomic, weak) IBOutlet UITextField *tfPassword;
@property (nonatomic, weak) IBOutlet HButton *btnLogin;
@property (nonatomic, weak) IBOutlet HButton *btnRegister;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *csHeight;

@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *password;


@end
