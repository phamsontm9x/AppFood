//
//  DishListCell.h
//  AppFood
//
//  Created by HHumorous on 4/5/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "BaseCell.h"

@interface DishListCell : BaseCell

@property (nonatomic, weak) IBOutlet UIView *vTimer;
@property (nonatomic, weak) IBOutlet UIView *vTimerInside;
@property (nonatomic, weak) IBOutlet UILabel *lblTimer;
@property (nonatomic, weak) IBOutlet UILabel *lblUsername;
@property (nonatomic, weak) IBOutlet UIImageView *imgAvatar;
@property (nonatomic, weak) IBOutlet UIButton *btnSave;

@end
