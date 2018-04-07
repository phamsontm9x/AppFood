//
//  NDInfoDetailCell.h
//  AppFood
//
//  Created by HHumorous on 4/7/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "BaseCell.h"

@interface NDInfoDetailCell : BaseCell

@property (nonatomic, weak) IBOutlet UILabel *lblDuration;
@property (nonatomic, weak) IBOutlet UITextView *tviewDesc;
@property (nonatomic, weak) IBOutlet UITextField *tfLink;
@property (nonatomic, weak) IBOutlet UIImageView *imgAvatar;

@end
