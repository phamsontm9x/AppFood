//
//  SignUpVC.h
//  AppFood
//
//  Created by HHumorous on 3/16/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "BaseVC.h"
#import "HButton.h"

@interface SignUpVC : BaseVC

@property (nonatomic, weak) IBOutlet UITextField *tfEmail;
@property (nonatomic, weak) IBOutlet UITextField *tfPassword;
@property (nonatomic, weak) IBOutlet UITextField *tfRePassword;
@property (nonatomic, weak) IBOutlet HButton *btnLogin;
@property (nonatomic, weak) IBOutlet HButton *btnRegister;

@end
