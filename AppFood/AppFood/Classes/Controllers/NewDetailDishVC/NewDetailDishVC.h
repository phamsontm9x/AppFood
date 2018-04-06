//
//  NewDetailDishVC.h
//  AppFood
//
//  Created by ThanhSon on 4/6/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "BaseVC.h"

@interface NewDetailDishVC : BaseVC

@property (nonatomic, weak) IBOutlet UICollectionView *clvContent;
@property (weak, nonatomic) IBOutlet UIPageControl *pgIndicator;

@end
