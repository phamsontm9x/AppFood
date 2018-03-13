//
//  BaseVC.h
//  AppFood
//
//  Created by ThanhSon on 3/8/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "define.h"

@interface BaseVC : UIViewController

- (void)setTitleNav:(NSString *)title andImgButton:(UIImage*)imgBtn;
- (void)selectedRightButton;
- (void)selectedLeftButton;

@end
