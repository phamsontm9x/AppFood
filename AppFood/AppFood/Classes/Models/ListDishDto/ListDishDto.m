//
//  ListDishDto.m
//  AppFood
//
//  Created by ThanhSon on 3/15/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "ListDishDto.h"

@implementation ListDishDto

- (id)initWithID:(NSString *)_id Image:(NSString *)strImg andName:(NSString*)name {
    self = [super init];
    
    __id = _id;
    _img = strImg;
    _name = name;
    
    return self;
}

@end
