//
//  MenuDto.h
//  AppFood
//
//  Created by ThanhSon on 3/9/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "BaseDto.h"
@class BaseDto;
@class MenuDto;

@interface MenuDto : BaseDto

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSString *img;

- (id)initWithTitle:(NSString *)title andImage:(NSString *)strImg;

@end


@interface MenuListDto : BaseDto

@property (nonatomic, strong) NSMutableArray <MenuDto*> *list;

@end

