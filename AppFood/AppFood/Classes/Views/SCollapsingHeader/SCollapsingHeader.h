//
//  SCollapsingHeader.h
//  AppFood
//
//  Created by ThanhSon on 4/3/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "BaseVC.h"

@interface SCollapsingHeader : BaseVC

@property (nonatomic, weak) IBOutlet UIView *vHeaderView;
@property (nonatomic, weak) IBOutlet BaseTBV * tbvContent;

@property (nonatomic, weak) IBOutlet UIView *vNav;
@property (nonatomic, weak) IBOutlet UIView *vHeaderTbv;

@property (nonatomic, weak) IBOutlet UIButton *btnBack;
@property (nonatomic, weak) IBOutlet UIButton *btnReload;
@property (nonatomic, weak) IBOutlet UIButton *btnShare;

@property (nonatomic, weak) IBOutlet UILabel *lblHeader;

@property (weak, nonatomic) IBOutlet UIVisualEffectView *vEff;



@end
