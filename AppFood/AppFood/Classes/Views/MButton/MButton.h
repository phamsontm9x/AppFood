//
//  MButton.h
//  AppFood
//
//  Created by hhumorous on 2/20/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>
#import "define.h"

//IB_DESIGNABLE

@class CodeBrowseDto;

@interface MButton : UIButton

@property (copy, nonatomic) IBInspectable NSString *styleName;
@property (copy, nonatomic) IBInspectable NSString *text;
@property (assign, nonatomic) IBInspectable BOOL isChecked;

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *bgColor;

- (void) setFont:(UIFont*)font;

- (void) setCorneradius:(CGFloat)corneradius;
- (void) setStyleDefault;
- (void) setStyleBlue;
- (void) setStyleOrange;
- (void) setStyleWhite;
- (void) setStyleClear;
- (void) setStyleAvatar;
- (void) setStyleButtonCircle;
- (void) setStyleCircleGray;
- (void) setStyleWeightScore ;
- (void) setStyleCircleBlue;
- (void) setStyleCircleOrange;
- (void) setStyleCircle;
- (void) setStyleButtonWithCornerRadius:(CGFloat)radius colorTitle:(UIColor*)color
                        colorbacground:(UIColor*)colorBackground;
- (void) setStyleAvatarWithBackgroundColor:(UIColor*)color
                               borderColor:(UIColor*)borderColor
                                 textColor:(UIColor*)textColor;

- (void) setStyleBlueSquare;
- (void) setStyleBlueSquare:(CGFloat)radius;
- (void) setStyleBlueSquareWithTitle:(NSString*)title;
- (void) setStyleClearSquare;
- (void) setStyleClearSquareBlu;
- (void) setStyleGraySquare;
- (void) setStyleGraySquareWithTitle:(NSString*)title;
- (void) setStyleRoundGray: (UIColor*)color;
- (void) setStyleCircalClear:(UIColor *)color;
- (void) setStyleButtonCircle:(UIColor *)color;
    
- (void) setStyleRoundClear:(UIColor*)color;
- (void) setStylebackgroudGray:(UIColor *)color;
- (void) setStyleRound;

- (void) setStyleMenuIsSelected;
- (void) setStyleMenuNonSelect;

- (void) setStyleCheckButton;
- (void) setStyleNoneCheckButton;
- (void) setStyleClearWithTitleBlue;
- (void) setCircleAvatar:(UIImage*)img;

#pragma mark - Edit
- (void) setStyleEdit;

#pragma mark - Delete
- (void) setStyleDelete;
- (void) setStyleDeleteRed;

#pragma mark - Add
- (void) setStyleAddBlue;

#pragma mark - Selection Style
- (void)setStyleTickSquare;
- (void)setStyleTickOval;
- (void)setStyleTickArrow;

- (void)setImageSD:(NSString *)strURL placeHolder:(NSString *)placeHolderImage name:(NSString *)name;
- (void)setImage:(NSString*)strURL placeHolder:(NSString*)placeHolderImage name:(NSString*)name;
- (void)setImage:(NSString*)strURL placeHolder:(NSString*)placeHolderImage name:(NSString*)name textColor:(UIColor*)textColor backGroundColor:(UIColor*)bgColor;
- (void)setName:(NSString *)name textColor:(UIColor*)textColor backGroundColor:(UIColor*)bgColor borderCoor:(UIColor*)border;
- (void)setImageWithType:(NSInteger)type;
- (void)setImageForFile:(CodeBrowseDto*)file;

- (void)setLabelNumber:(NSInteger)number;

@end
