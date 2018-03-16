//
//  DetailDishDto.h
//  AppFood
//
//  Created by ThanhSon on 3/15/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "BaseDto.h"
#import "ListDishDto.h"

@class DetailDishDto;

@interface DetailDishDto : BaseDto

@property (nonatomic, strong) NSString *_id;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *decriptions;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *material;
@property (nonatomic, strong) NSString *making;
@property (nonatomic, strong) NSString *categoryId;


- (id)initWithID:(NSString*)_id Image:(NSString*)strImg Name:(NSString*)name Desc:(NSString*)desc URL:(NSString*)url Material:(NSString*)material andMaking:(NSString*)making;

@end

@interface ListDishDetailDto : BaseDto

@property (nonatomic, strong) NSMutableArray <DetailDishDto *>*list;

@end


