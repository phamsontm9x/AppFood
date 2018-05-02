//
//  HView.h
//  Gito
//
//  Created by NguyenMach-MAC on 10/5/16.
//  Copyright © 2016 Horical. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Util.h"
#import "MButton.h"

@interface HView : UIView

@property (copy, nonatomic) IBInspectable NSString *styleName;

- (void) setBackgroudVHeader;
- (void) setStyleViewSelectDown;
- (void) setStyleViewBorder;
- (void) setBackgroudGray;
- (void) setBackgroudGrayDef;
- (void) setBackgroudLightGray;
@end
