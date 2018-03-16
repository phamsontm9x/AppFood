//
//  ListDishDto.h
//  AppFood
//
//  Created by ThanhSon on 3/15/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "BaseDto.h"

@class DishTypeDto;

@interface DishTypeDto : BaseDto

@property (nonatomic, strong) NSString *_id;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *created;

- (id)initWithID:(NSString *)_id Image:(NSString *)strImg andName:(NSString*)name;

@end

@interface ListDishTypeDto : BaseDto

@property (nonatomic, strong) NSMutableArray <DishTypeDto *>*list;

@end
