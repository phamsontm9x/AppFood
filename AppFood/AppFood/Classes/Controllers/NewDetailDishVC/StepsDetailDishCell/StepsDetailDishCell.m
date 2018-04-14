//
//  StepsDetailDishCell.m
//  AppFood
//
//  Created by ThanhSon on 4/6/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "StepsDetailDishCell.h"
#import "NewDetailDishTbvCell.h"
#import "DetailDishDto.h"
#import "UIView+Util.h"

@interface StepsDetailDishCell() <UITableViewDelegate, UITableViewDataSource, NewDetailDishTbvCellDelegate> {
    NSMutableArray *_arrRowData;
    BOOL isEditing;
}

@end

@implementation StepsDetailDishCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initVar];
    
    [_tbvStep setEditing:YES animated:YES];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self layoutIfNeeded];
}

#pragma mark - InitUI

- (void)initVar {
    _arrRowData = [[NSMutableArray alloc] init];
    _tbvStep.allowsSelectionDuringEditing = YES;
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
    NSInteger totalRow = 2 + _arrRowData.count;
    
    if (row == 0) {
        return 40;
    } else if (row == totalRow - 1)
        return 35;
    else {
        return 200;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    NSInteger totalRow = 2 + _arrRowData.count;
    NewDetailDishTbvCell *cell;
    
    if (row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"NDStepHeaderCell"];
        cell.lblTitle.text = @"COOK STEPS";
    } else if (row == totalRow - 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"NDStepAddCell"];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"NDStepDetailCell"];
        [cell.vStep roundCornersOnTopLeft:YES topRight:YES bottomLeft:YES bottomRight:YES radius:cell.vStep.frame.size.width/2];
        [cell.tviewDesc roundCornersOnTopLeft:YES topRight:YES bottomLeft:YES bottomRight:YES radius:6];
        cell.lblTitle.text = SF(@"%ld", row);
        cell.btnDelete.tag = row;
        cell.delegate = self;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_arrRowData removeObjectAtIndex:row - 1];
        [_tbvStep deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        [_arrRowData addObject:@""];
        [_tbvStep insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    NSInteger totalRow = 2 + _arrRowData.count;
    
    if (row == totalRow - 1) {
        return YES;
    }
    return NO;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;
    NSInteger totalRow = 2 + _arrRowData.count;
    
    if (row == totalRow - 1) {
        return UITableViewCellEditingStyleInsert;
    }
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    NSInteger totalRow = 1 + _arrRowData.count;
    
    [_tbvStep deselectRowAtIndexPath:indexPath animated:YES];
    
    if (row >= totalRow) {
        [self tableView:tableView commitEditingStyle:UITableViewCellEditingStyleInsert forRowAtIndexPath:indexPath];
    }
}

#pragma mark - NewDetailDishTbvCellDelegate

- (void)newDetailDishTbvCell:(NewDetailDishTbvCell *)cell onBtnPressed:(UIButton *)btn {
    [_tbvStep performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:btn.tag inSection:0];
        [_tbvStep deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [_arrRowData removeObjectAtIndex:btn.tag -1];
    } completion:^(BOOL finished) {
         [_tbvStep reloadData];
    }];
}

#pragma mark - Action

- (IBAction)btnNextPressed:(UIButton *)btn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(indexCell:selectBtnNext:orBtnBack:)]) {
        
        [self.delegate indexCell:2 selectBtnNext:YES orBtnBack:NO];
    }
}

- (IBAction)btnBackPressed:(UIButton *)btn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(indexCell:selectBtnNext:orBtnBack:)]) {
        
        [self.delegate indexCell:2 selectBtnNext:NO orBtnBack:YES];
    }
}

@end
