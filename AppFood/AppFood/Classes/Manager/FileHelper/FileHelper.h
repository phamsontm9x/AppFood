//
//  FileHelper.h
//  AppFood
//
//  Created by machnguyen_uit on 4/28/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailDishDto.h"

@interface FileHelper : NSObject


+ (void)saveFoodToFavorate:(DetailDishDto*)dto;
+ (ListDishDetailDto*)getListFavorite;
+ (void)removeFavorite:(DetailDishDto*)dto;
+ (void)removeAllFavorite;

@end
