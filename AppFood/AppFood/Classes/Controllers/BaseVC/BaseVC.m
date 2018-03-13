//
//  BaseVC.m
//  AppFood
//
//  Created by ThanhSon on 3/8/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "BaseVC.h"
#import "AppDelegate.h"
#import "MainVC.h"

@interface BaseVC ()

@end

@implementation BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Demo Nav
- (void)setTitleNav:(NSString *)title andImgButton:(UIImage*)imgBtn {
    self.navigationItem.title = title;
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithImage:imgBtn style:UIBarButtonItemStyleDone target:self action:@selector(selectedRightButton)];
    self.navigationItem.rightBarButtonItem = btn;
    
    // set if need
    UINavigationController *nav = self.navigationController;
    if(nav) {
        NSString *strMenu = @"back";
        if(nav.viewControllers.count <= 1) {
            if(!nav.presentingViewController) {
                // menu
                strMenu = @"menu";
            }
        }
        UIBarButtonItem *btnMenu = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:strMenu] style:UIBarButtonItemStyleDone target:self action:@selector(selectedLeftButton)];
        self.navigationItem.leftBarButtonItem = btnMenu;
    }
}

- (void)setButtonLeft {
    
}

- (void)selectedRightButton {

}
    
- (void)selectedLeftButton {
    UINavigationController *nav = self.navigationController;
    if(nav) {
        if(nav.viewControllers.count <= 1) {
            if(!nav.presentingViewController) {
                // menu
                [App.mainVC showMenu];
            }
        }
    }
}

@end
