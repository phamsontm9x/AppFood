//
//  NDInfoDetailCell.m
//  AppFood
//
//  Created by HHumorous on 4/7/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "NewDetailDishTbvCell.h"

@implementation NewDetailDishTbvCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)onBtnChoseDishAvatar:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(newDetailDishTbvCell:onBtnPressed:)]) {
        [_delegate newDetailDishTbvCell:self onBtnPressed:sender];
    }
}

- (IBAction)onBtnDeleteCell:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(newDetailDishTbvCell:onBtnPressed:)]) {
        [_delegate newDetailDishTbvCell:self onBtnPressed:sender];
    }
}

@end
