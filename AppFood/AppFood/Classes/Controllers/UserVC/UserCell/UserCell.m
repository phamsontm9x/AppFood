//
//  UserCell.m
//  AppFood
//
//  Created by Nguyen on 4/28/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "UserCell.h"
#import "UIView+Util.h"

@implementation UserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)onBtnChooseAvatar:(UIButton*)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(userCell:didChooseAvatar:)]) {
        [_delegate userCell:self didChooseAvatar:sender];
    }else {
        NSLog(@"Please set DELEGATE for class: %@",[self class]);
    }
}

@end
