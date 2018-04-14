//
//  TypeDetailDishCell.m
//  AppFood
//
//  Created by ThanhSon on 4/6/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "TypeDetailDishCell.h"

@implementation TypeDetailDishCell

#pragma mark - Action

- (IBAction)btnBackPressed:(UIButton *)btn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(indexCell:selectBtnNext:orBtnBack:)]) {
        
        [self.delegate indexCell:3 selectBtnNext:NO orBtnBack:YES];
    }
}

@end
