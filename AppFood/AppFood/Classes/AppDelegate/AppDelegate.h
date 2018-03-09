//
//  AppDelegate.h
//  AppFood
//
//  Created by ThanhSon on 3/8/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "define.h"
#import "BaseNV.h"
#import "MainVC.h"

@class MainVC;


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) BaseNV *rootNV;
@property (nonatomic, strong) MainVC *mainVC;


@end

