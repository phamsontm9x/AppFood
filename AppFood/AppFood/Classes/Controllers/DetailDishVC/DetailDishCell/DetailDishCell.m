//
//  DetailDishCell.m
//  AppFood
//
//  Created by HHumorous on 3/26/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "DetailDishCell.h"

@implementation DetailDishCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.vBackground.layer.cornerRadius = self.vBackground.frame.size.height/2 - 2;
    
    [self layoutSubviews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
