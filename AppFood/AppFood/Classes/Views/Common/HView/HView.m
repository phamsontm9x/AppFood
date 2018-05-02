//
//  HView.m
//  Gito
//
//  Created by NguyenMach-MAC on 10/5/16.
//  Copyright © 2016 Horical. All rights reserved.
//

#import "HView.h"
#import "define.h"

@implementation HView


- (void)setStyleName:(NSString *)styleName {

    if ([styleName isEqualToString:@"header"]) {
        [self setBackgroudVHeader];
        
    } else if ([styleName isEqualToString:@"boderV"]) {
        [self setStyleViewSelectDown];
    
    } else if ([styleName isEqualToString:@"bdv"]) {
        [self setStyleViewBorder];
    
    }  else if ([styleName isEqualToString:@"grayColor"]) {
        [self setBackgroudGray];
        
    } else if ([styleName isEqualToString:@"grayColorCF"]) {
        [self setBackgroudGrayCF];
    }
    else if ([styleName isEqualToString:@"boderOnly"]) {
        [self setStyleBorderOnly];
    
    }  else if ([styleName isEqualToString:@"grayColorDef"]) {
        [self setBackgroudGrayDef];
        
    }
}

- (void)setBackgroudVHeader {
    self.backgroundColor = MAINCOLOR;
}

- (void) setStyleViewSelectDown{
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    [self setBackgroundColor:RGBA(0xF2F2F2,1)];
}

- (void) setStyleViewBorder{
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
    [self setBackgroundColor:MAINCOLOR];
}

- (void) setStyleBorderOnly{
    self.layer.cornerRadius = 7;
    self.layer.masksToBounds = YES;
    
}

- (void) setBackgroudGray {
    [self setBackgroundColor:RGBA(0xF2F2F2, 1)];
    
}
- (void) setBackgroudGrayCF {
    [self setBackgroundColor:RGBA(0xCFCFCF, 1)];
    
}

- (void) setBackgroudGrayDef {
    [self setBackgroundColor:[UIColor grayColor]];
    
}

- (void) setBackgroudLightGray {
    [self setBackgroundColor:[UIColor lightGrayColor]];
    
}

@end
