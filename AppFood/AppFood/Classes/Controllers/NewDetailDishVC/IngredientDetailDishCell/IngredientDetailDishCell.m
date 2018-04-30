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
#import "MaterialsDetailDishDto.h"

@interface IngredientDetailDishCell() <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate> {
    NSMutableArray *_arrRowData;
    BOOL isEditing;
    NSMutableArray *listData;
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
    listData = [[NSMutableArray alloc] init];
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
        MaterialsDetailDishDto *data = listData[row -1];
        cell = [tableView dequeueReusableCellWithIdentifier:@"NDIngredientDetailCell"];
        cell.tfAmout.text = data.amount;
        cell.tfName.text = data.material;
        cell.tfAmout.delegate = self;
        cell.tfName.delegate = self;
        cell.tfAmout.tag = row;
        cell.tfName.tag = row ;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_arrRowData removeObjectAtIndex:row - 1];
        [listData removeObjectAtIndex:(row -1)];
        [_tbvIngredient deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        MaterialsDetailDishDto *dto = [[MaterialsDetailDishDto alloc] init];
        [listData addObject:dto];
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

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSIndexPath *index = [NSIndexPath indexPathForRow:textField.tag inSection:0];
    NewDetailDishTbvCell *cell = [_tbvIngredient cellForRowAtIndexPath:index];
    MaterialsDetailDishDto *data = listData[textField.tag - 1];
    if (textField == cell.tfName) {
        data.material = cell.tfName.text;
    } else {
        data.amount = cell.tfAmout.text;
    }
}

#pragma mark - Action

- (IBAction)btnNextPressed:(UIButton *)btn {
    
    self.dataDto.materials = listData;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(indexCell:selectBtnNext:orBtnBack:)]) {
        
        [self.delegate indexCell:1 selectBtnNext:YES orBtnBack:NO];
    }
}

- (IBAction)btnBackPressed:(UIButton *)btn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(indexCell:selectBtnNext:orBtnBack:)]) {
        
        [self.delegate indexCell:1 selectBtnNext:NO orBtnBack:YES];
    }
}

@end
