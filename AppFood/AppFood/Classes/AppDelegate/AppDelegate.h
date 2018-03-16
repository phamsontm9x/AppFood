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


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) Configure *configure;

- (void) showLoading;
- (void) hideLoading;

@end

