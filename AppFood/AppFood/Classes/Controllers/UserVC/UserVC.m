//
//  UserVC.m
//  AppFood
//
//  Created by Nguyen on 4/28/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "UserVC.h"

@interface UserVC ()

@end

@implementation UserVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SlideNavigationController

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

@end
