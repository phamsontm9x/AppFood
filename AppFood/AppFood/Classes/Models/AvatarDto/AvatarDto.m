//
//  AvatarDto.m
//  AppFood
//
//  Created by ThanhSon on 4/30/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "AvatarDto.h"

@implementation AvatarDto

- (instancetype)init {
    self = [super init];
    __boundary = SF(@"----AppFood---%d", arc4random());
    
    return self;
    
}

- (id)initWithData:(NSDictionary *)dic {
    self = [super init];
    
    if (dic) {
        if ([dic isKindOfClass:[NSDictionary class]]) {
            IO(_id);
            IO(path);
        } else if ([dic isKindOfClass:[NSString class]]) {
            __id = (NSString*)dic;
        }
    }
    
    return self;
}

- (id )getJSONObjectWithMethod:(NSInteger)method {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    if (method== METHOD_POST) {
        StartForm();
        FormFile(name, @"application/octet-stream", fileContent);
        EndForm();
        
        return data;
    }
    return dic;
}

@end
