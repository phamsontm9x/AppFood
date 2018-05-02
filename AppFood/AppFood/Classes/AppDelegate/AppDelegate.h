//
//  AppDelegate.h
//  AppFood
//
//  Created by ThanhSon on 3/8/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "define.h"
#import "SlideNavigationController.h"
#import "Configure.h"
#import "BaseVC.h"

@class BaseVC;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) Configure *configure;
@property (nonatomic, strong) BaseVC *mainVC;

- (void) showLoading;
- (void) hideLoading;


@end

