//
//  DishTypeListCell.m
//  AppFood
//
//  Created by HHumorous on 4/5/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "DishTypeListCell.h"
#import "UIView+Util.h"

@implementation DishTypeListCell

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_vImgBackground roundCornersOnTopLeft:YES topRight:YES bottomLeft:YES bottomRight:YES radius:_vImgBackground.bounds.size.height/2];
    [_vTitleBackground roundCornersOnTopLeft:YES topRight:YES bottomLeft:YES bottomRight:YES radius:_vTitleBackground.bounds.size.height/2];
    [self layoutIfNeeded];
}

@end

