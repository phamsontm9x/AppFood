//
//  DetailDishDto.m
//  AppFood
//
//  Created by ThanhSon on 3/15/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "DetailDishDto.h"

@implementation DetailDishDto

- (id)initWithID:(NSString*)_id Image:(NSString*)strImg Name:(NSString*)name Desc:(NSString*)desc URL:(NSString*)url Material:(NSString*)material andMaking:(NSString*)making {
    self = [super init];
    
    __id = _id;
    _image = strImg;
    _name = name;
    _decriptions = desc;
    _url = url;
    _material = material;
    _making = making;
    
    return self;
    
}

-(id)initWithData:(NSDictionary *)dic {
    self = [super init];
    if (dic) {
        if ([dic isKindOfClass:[NSDictionary class]]) {
            IO(_id);
            IO(image);
            IO(name);
            IO(decriptions);
            IO(url);
            IO(material);
            IO(making);
            IO(categoryId);
        }
    }
    return self;
}

- (NSMutableDictionary *)getJSONObject {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    return dic;
}

- (id )getJSONObjectWithMethod:(NSInteger)method{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];

    return dic;
    
}

@end

@implementation ListDishDetailDto

- (instancetype)init {
    self = [super init];
    _list = [[NSMutableArray alloc] init];
    return self;
}

- (id)initWithData:(NSDictionary *)dic {
    self = [super init];
    IAObj(list, dic, DetailDishDto);
    return self;
}

@end
