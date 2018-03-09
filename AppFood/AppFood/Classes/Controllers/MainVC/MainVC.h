//
//  MainVC.h
//  AppFood
//
//  Created by ThanhSon on 3/8/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "BaseVC.h"
#import "MenuVC.h"
#import "DishTypeList.h"

@class MenuVC;
@class BaseNV;

@interface MainVC : BaseVC

@property (nonatomic, weak) IBOutlet UIView *vLeftPanel;
@property (nonatomic, weak) IBOutlet UIView *vMain;
@property (nonatomic, weak) IBOutlet UIView *vGate;

@property (nonatomic, strong) MenuVC *menuVC;
@property (nonatomic, strong) BaseNV *contentNV;

@property (nonatomic, weak) IBOutlet UIView *vMask;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *conLeftPanel;

- (void)showPanel:(BOOL)isShow;
- (void)showPanel:(BOOL)isShow animation:(BOOL)animation;


@end
