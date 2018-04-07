//
//  MenuVC.h
//  AppFood
//
//  Created by ThanhSon on 3/8/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "BaseVC.h"
#import "BaseTBV.h"
#import "BaseCell.h"
#import "SupportVC.h"
#import "AppDelegate.h"

@interface MenuVC : BaseVC

@property (nonatomic, weak) IBOutlet BaseTBV *tbvMenu;
@property (nonatomic, weak) IBOutlet UIImageView *imageAvatar;
@property (nonatomic, weak) IBOutlet UILabel *lblUserName;
@property (nonatomic, weak) IBOutlet UIButton *btnLogout;
@property (nonatomic, weak) IBOutlet UIView *vUser;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *csRightView;

@end
