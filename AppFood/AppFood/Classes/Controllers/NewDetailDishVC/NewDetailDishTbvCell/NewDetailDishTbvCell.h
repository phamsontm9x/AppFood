//
//  NDInfoDetailCell.h
//  AppFood
//
//  Created by HHumorous on 4/7/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "BaseCell.h"
#import "DetailDishDto.h"
#import "NewDetailDishVC.h"

@class NewDetailDishTbvCell;

@protocol NewDetailDishTbvCellDelegate <NSObject>

- (void)newDetailDishTbvCell:(NewDetailDishTbvCell *)cell onBtnPressed:(UIButton *)btn;


@optional

@end

@interface NewDetailDishTbvCell : BaseCell




@property (nonatomic, weak) IBOutlet UILabel *lblDuration;
@property (nonatomic, weak) IBOutlet UITextView *tviewDesc;
@property (nonatomic, weak) IBOutlet UITextField *tfLink;
@property (nonatomic, weak) IBOutlet UIImageView *imgAvatar;

@property (nonatomic, weak) IBOutlet UITextField *tfName;
@property (nonatomic, weak) IBOutlet UITextField *tfAmout;

@property (nonatomic, weak) IBOutlet UIView *vStep;

@property (nonatomic, strong) id <NewDetailDishTbvCellDelegate> delegate;

@end
