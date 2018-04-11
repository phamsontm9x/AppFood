//
//  InfoDetailDishCell.h
//  AppFood
//
//  Created by ThanhSon on 4/6/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "BaseColCell.h"
#import "NewDetailDishVC.h"

@interface InfoDetailDishCell : BaseColCell

@property (nonatomic, weak) IBOutlet UITableView *tbvInfo;
@property (nonatomic, strong) NewDetailDishVC *parentVC;

@end
