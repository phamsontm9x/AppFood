//
//  DetailDishCell.h
//  AppFood
//
//  Created by HHumorous on 3/26/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "BaseCell.h"

@interface DetailDishCell : BaseCell

@property (nonatomic, weak) IBOutlet UIWebView *wvYoutube;
@property (nonatomic, weak) IBOutlet UIImageView *imageIcon;
@property (nonatomic, weak) IBOutlet UILabel *lblMaterial;
@property (nonatomic, weak) IBOutlet UILabel *lblAmount;

@end
