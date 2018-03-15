//
//  ListDishDto.h
//  AppFood
//
//  Created by ThanhSon on 3/15/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "BaseDto.h"

@interface ListDishDto : BaseDto

@property (nonatomic, strong) NSString *_id;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *name;

- (id)initWithID:(NSString *)_id Image:(NSString *)strImg andName:(NSString*)name;

@end
