//
//  AppDelegate.m
//  AppFood
//
//  Created by ThanhSon on 3/8/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "AppDelegate.h"
#import "MenuVC.h"
#import "WelcomeVC.h"
#import "DishTypeListVC.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //
    _configure = [[Configure alloc] init];
    BOOL isLogin = [_configure checkLogin];
    
    //Init SlideNav

    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];

    MenuVC *leftMenu = (MenuVC*)[mainStoryboard
                                                                 instantiateViewControllerWithIdentifier: @"MenuVC"];


    [SlideNavigationController sharedInstance].leftMenu = leftMenu;
    [SlideNavigationController sharedInstance].menuRevealAnimationDuration = 0.3;
    [SlideNavigationController sharedInstance].portraitSlideOffset = 100;
    [SlideNavigationController sharedInstance].enableShadow = YES;
    
    BaseVC *vc;
    if (isLogin) {
         vc = VCFromSB(DishTypeListVC, SB_ListFood);
    } else {
         vc = VCFromSB(WelcomeVC, SB_Login);
    }
    [AppNav popToRootAndSwitchToViewController:vc withSlideOutAnimation:NO
                                 andCompletion:nil];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Loading

- (void)showLoading{
    [self showLoadingAction];
}

- (void)showLoadingAction {
    if(![MBProgressHUD HUDForView:_window]) {
        [MBProgressHUD showHUDAddedTo:_window animated:YES];
    }
}

- (void)hideLoading {
    [self performSelector:@selector(hideLoadingAction) withObject:nil afterDelay:0.25];
}

- (void) hideLoadingAction {
    [MBProgressHUD hideHUDForView:_window animated:YES];
}

@end
