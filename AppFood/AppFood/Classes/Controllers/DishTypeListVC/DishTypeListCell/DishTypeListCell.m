//
//  DishTypeListCell.m
//  AppFood
//
//  Created by HHumorous on 4/5/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "DishTypeListCell.h"

@implementation DishTypeListCell

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _vImgBackground.layer.cornerRadius = _vImgBackground.frame.size.height/2;
    _vTitleBackground.layer.cornerRadius = _vTitleBackground.frame.size.height/2;
}

@end

