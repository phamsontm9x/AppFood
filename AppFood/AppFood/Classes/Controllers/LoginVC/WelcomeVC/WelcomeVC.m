//
//  WelcomeVC.m
//  AppFood
//
//  Created by HHumorous on 3/16/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "WelcomeVC.h"
#import "SignInVC.h"
#import "SignUpVC.h"

@interface WelcomeVC ()

@end

@implementation WelcomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onBtnLoginClicked:(HButton*)btn {
    SignInVC *vc = VCFromSB(SignInVC, SB_Login);
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)onBtnSignUpClicked:(HButton*)btn {
    SignUpVC *vc = VCFromSB(SignUpVC, SB_Login);
    [self.navigationController pushViewController:vc animated:YES];
}

@end
