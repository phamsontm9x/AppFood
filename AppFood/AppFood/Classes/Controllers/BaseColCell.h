//
//  BaseColCell.h
//  AppFood
//
//  Created by ThanhSon on 4/6/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseVC.h"
@class InfoDetailDishCell;
@class IngredientDetailDishCell;
@class StepsDetailDishCell;
@class TypeDetailDishCell;

@protocol BaseColCellDelegate <NSObject>
@optional

- (void)indexCell:(NSInteger )index selectBtnNext:(BOOL)btnNext orBtnBack:(BOOL)btnBack;

@end

@interface BaseColCell : UICollectionViewCell

@property (nonatomic, strong) BaseVC *rootVC;
@property (nonatomic, strong) id<BaseColCellDelegate> delegate;

@end
