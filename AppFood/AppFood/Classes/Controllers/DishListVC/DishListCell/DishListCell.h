//
//  DishListCell.h
//  AppFood
//
//  Created by HHumorous on 4/5/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "BaseCell.h"


@class DishListCell;

@protocol DishListCellDelegate <NSObject>

- (void)dishListCell:(DishListCell*)cell didSelectedSave:(UIButton*)btn;
- (void)dishListCell:(DishListCell*)cell didSelectedShare:(UIButton*)btn;

@end

@interface DishListCell : BaseCell

@property (nonatomic, weak) IBOutlet UIView *vTimer;
@property (nonatomic, weak) IBOutlet UIView *vTimerInside;
@property (nonatomic, weak) IBOutlet UILabel *lblTimer;
@property (nonatomic, weak) IBOutlet UILabel *lblUsername;
@property (nonatomic, weak) IBOutlet UIImageView *imgAvatar;
@property (nonatomic, weak) IBOutlet UIButton *btnSave;


@property (nonatomic, weak) id <DishListCellDelegate> delegate;

@end
