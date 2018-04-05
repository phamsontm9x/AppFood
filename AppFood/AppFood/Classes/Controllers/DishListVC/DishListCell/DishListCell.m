//
//  DishListCell.m
//  AppFood
//
//  Created by HHumorous on 4/5/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "DishListCell.h"

@implementation DishListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutSubviews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.vBackground.layer.cornerRadius = 10;
    self.vTimer.layer.cornerRadius = 8;
    self.vTimerInside.layer.cornerRadius = 7;
}

@end
