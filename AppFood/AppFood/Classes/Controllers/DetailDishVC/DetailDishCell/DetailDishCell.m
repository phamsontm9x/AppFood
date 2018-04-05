//
//  DetailDishCell.m
//  AppFood
//
//  Created by HHumorous on 3/26/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "DetailDishCell.h"

@implementation DetailDishCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initialize];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)initialize{
    
    _vContent.clipsToBounds = YES;
    
    _vBanner = [[NSBundle mainBundle] loadNibNamed:@"HBanner" owner:self options:nil].lastObject;
    
    [_vContent insertSubview:_vBanner atIndex:0];
    _vBanner.translatesAutoresizingMaskIntoConstraints = NO;
    if (_vContent) {
        [self addConstraintFourEdge:_vContent andView:_vBanner];
    }
    
    [self setNeedsUpdateConstraints];
    [self layoutIfNeeded];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)addConstraintFourEdge:(UIView*)viewParent andView:(UIView*)viewChild{
    viewChild.translatesAutoresizingMaskIntoConstraints = NO;
    [viewParent addConstraint:[NSLayoutConstraint constraintWithItem:viewParent
                                                           attribute:(NSLayoutAttributeTop)
                                                           relatedBy:(NSLayoutRelationEqual)
                                                              toItem:viewChild
                                                           attribute:(NSLayoutAttributeTop)
                                                          multiplier:1
                                                            constant:0]];
    
    [viewParent addConstraint:[NSLayoutConstraint constraintWithItem:viewParent
                                                           attribute:(NSLayoutAttributeLeft)
                                                           relatedBy:(NSLayoutRelationEqual)
                                                              toItem:viewChild
                                                           attribute:(NSLayoutAttributeLeft)
                                                          multiplier:1
                                                            constant:0]];
    
    [viewParent addConstraint:[NSLayoutConstraint constraintWithItem:viewParent
                                                           attribute:(NSLayoutAttributeBottom)
                                                           relatedBy:(NSLayoutRelationEqual)
                                                              toItem:viewChild
                                                           attribute:(NSLayoutAttributeBottom)
                                                          multiplier:1
                                                            constant:0]];
    
    [viewParent addConstraint:[NSLayoutConstraint constraintWithItem:viewParent
                                                           attribute:(NSLayoutAttributeRight)
                                                           relatedBy:(NSLayoutRelationEqual)
                                                              toItem:viewChild
                                                           attribute:(NSLayoutAttributeRight)
                                                          multiplier:1
                                                            constant:0]];
}

@end
