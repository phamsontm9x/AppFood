//
//  NewDetailDishVC.h
//  AppFood
//
//  Created by ThanhSon on 4/6/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "BaseVC.h"
#import "DetailDishDto.h"

@interface NewDetailDishVC : BaseVC

@property (nonatomic, weak) IBOutlet UICollectionView *clvContent;
@property (weak, nonatomic) IBOutlet UIPageControl *pgIndicator;
@property (nonatomic, strong) DetailDishDto *dataDto;
@property (nonatomic, strong) NSString *categoryId;

@end
