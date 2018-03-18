//
//  BaseTBV.h
//  AppFood
//
//  Created by ThanhSon on 3/8/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "define.h"

@interface BaseTBV : UITableView

@property (nonatomic, strong) UIRefreshControl *refreshCtrl;

- (void)addPullRefreshAtVC:(id)vc toReloadAction:(SEL)action;

- (void)showIndicator;
- (void)hideIndicator;
- (BOOL)isRefreshing;

@end
