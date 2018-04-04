//
//  DetailDishVC.h
//  AppFood
//
//  Created by ThanhSon on 3/9/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "BaseVC.h"
#import "ListDishDto.h"
#import "DetailDishDto.h"

@interface DetailDishVC : BaseVC

@property (nonatomic, weak) IBOutlet UIView *vHeaderView;
@property (nonatomic, weak) IBOutlet BaseTBV * tbvContent;

@property (nonatomic, weak) IBOutlet UIView *vNav;
@property (nonatomic, weak) IBOutlet UIView *vHeaderTbv;
@property (nonatomic, weak) IBOutlet UIImageView *imgHeaderView;

@property (nonatomic, weak) IBOutlet UIButton *btnBack;
@property (nonatomic, weak) IBOutlet UIButton *btnReload;
@property (nonatomic, weak) IBOutlet UIButton *btnShare;

@property (nonatomic, weak) IBOutlet UILabel *lblHeader;

@property (weak, nonatomic) IBOutlet UIVisualEffectView *vEff;


@property (nonatomic, strong) DetailDishDto *fooddish;

@end


