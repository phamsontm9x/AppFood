//
//  MainVC.m
//  AppFood
//
//  Created by ThanhSon on 3/8/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "MainVC.h"

@interface MainVC ()

@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showPanel:NO animation:NO];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"Main_Menu"]) {
        _menuVC = segue.destinationViewController;
    } else {
        _contentNV = segue.destinationViewController;
    }
}

- (IBAction)btnMenu:(id)btn {
    [self showPanel:_conLeftPanel.constant == 0 ? NO : YES animation:YES];
    [_menuVC.tbvMenu reloadData];
}

#pragma mark - Show/Hide Menu
- (void)showPanel:(BOOL)isShow {

}

- (void)showPanel:(BOOL)isShow animation:(BOOL)animation {
    _conLeftPanel.constant = isShow ? 0 : -MAX([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    _vMask.hidden = !isShow;
    if(animation) {
        [UIView animateWithDuration:0.35 animations:^{
            [self.view layoutIfNeeded];
            _vMask.alpha = (isShow ? 1 : 0);
        } completion:^(BOOL finished) {
            _vMask.hidden = !isShow;
        }];
        
    } else {
        [self.view layoutIfNeeded];
    }
    
}
    
@end
