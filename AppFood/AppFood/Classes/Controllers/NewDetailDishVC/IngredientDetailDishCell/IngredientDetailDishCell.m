//
//  IngredientDetailDishCell.m
//  AppFood
//
//  Created by ThanhSon on 4/6/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "IngredientDetailDishCell.h"
#import "NewDetailDishTbvCell.h"
#import "DetailDishDto.h"

@interface IngredientDetailDishCell() <UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *_arrRowData;
    BOOL isEditing;
}

@end

@implementation IngredientDetailDishCell

-(void)awakeFromNib {
    [super awakeFromNib];
    [self initVar];
    
    [_tbvIngredient setEditing:YES animated:YES];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    [self layoutIfNeeded];
}

#pragma mark - InitUI

- (void)initVar {
    _arrRowData = [[NSMutableArray alloc] init];
    _tbvIngredient.allowsSelectionDuringEditing = YES;
    isEditing = YES;
}



#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2 + _arrRowData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    
    switch (row) {
        case 0:
            return 40;
            break;
        default:
            return 35;
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    NSInteger totalRow = 2 + _arrRowData.count;
    NewDetailDishTbvCell *cell;
    
    if (row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"NDIngredientHeaderCell"];
        cell.lblTitle.text = @"INGREDIENTS";
    } else if (row == totalRow - 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"NDIngredientAddCell"];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"NDIngredientDetailCell"];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_arrRowData removeObjectAtIndex:row - 1];
        [_tbvIngredient deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        [_arrRowData addObject:@""];
        [_tbvIngredient insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    
    if (row == 0) {
        return NO;
    }
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;
    NSInteger totalRow = 2 + _arrRowData.count;
    
    if (row == 0) {
        return UITableViewCellEditingStyleNone;
    }
    else {
        if (row == totalRow - 1) {
            return UITableViewCellEditingStyleInsert;
        } else {
            return UITableViewCellEditingStyleDelete;
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    NSInteger totalRow = 1 + _arrRowData.count;
    
    [_tbvIngredient deselectRowAtIndexPath:indexPath animated:YES];
    
    if (row >= totalRow) {
        [self tableView:tableView commitEditingStyle:UITableViewCellEditingStyleInsert forRowAtIndexPath:indexPath];
    }
}

@end
