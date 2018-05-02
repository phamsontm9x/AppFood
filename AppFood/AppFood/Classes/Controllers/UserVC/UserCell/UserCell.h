//
//  UserCell.h
//  AppFood
//
//  Created by Nguyen on 4/28/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "BaseCell.h"
#import "UserVC.h"

@class UserCell;
@class NewDetailDishVC;

@protocol UserCellDelegate <NSObject>

- (void)userCell:(UserCell*)cell didChooseAvatar:(UIButton*)btn;

@end

@interface UserCell : BaseCell

@property (nonatomic, weak) IBOutlet UIImageView *imgAvatar;
@property (nonatomic, weak) IBOutlet UITextField *tfEdit;
@property (nonatomic, weak) IBOutlet UIView *vBack;
@property (nonatomic, strong) UserVC *rootVC;

@property (nonatomic, weak) id <UserCellDelegate> delegate;

@end
