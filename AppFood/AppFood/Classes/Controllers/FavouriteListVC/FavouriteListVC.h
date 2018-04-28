//
//  FavouriteListVC.h
//  AppFood
//
//  Created by ThanhSon on 3/9/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "BaseVC.h"
#import "ListDishDto.h"

@interface FavouriteListVC : BaseVC <SlideNavigationControllerDelegate>

@property (nonatomic, strong) DishTypeDto *typeDto;
@property (nonatomic, weak) IBOutlet BaseTBV *tbvDishFavorite;

@end
