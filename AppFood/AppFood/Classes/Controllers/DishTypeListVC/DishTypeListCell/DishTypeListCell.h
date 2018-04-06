//
//  DishTypeListCell.h
//  AppFood
//
//  Created by HHumorous on 4/5/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DishTypeListCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UILabel *lblTitle;
@property (nonatomic, weak) IBOutlet UIImageView *imgFood;
@property (nonatomic, weak) IBOutlet UIView *vImgBackground;
@property (nonatomic, weak) IBOutlet UIView *vTitleBackground;

@end
