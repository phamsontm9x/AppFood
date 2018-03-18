//
//  DishListVC.h
//  AppFood
//
//  Created by ThanhSon on 3/15/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "BaseVC.h"
#import "ListDishDto.h"

@interface DishListVC : BaseVC

@property (nonatomic, strong) DishTypeDto *typeDto;
@property (nonatomic, weak) IBOutlet BaseTBV *tbvDish;

@end
