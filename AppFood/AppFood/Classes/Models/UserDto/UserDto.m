//
//  UserDto.m
//  AppFood
//
//  Created by ThanhSon on 3/16/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "UserDto.h"

@implementation UserDto

-(id)initWithData:(NSDictionary *)dic {
    self = [super init];
    if (dic) {
        if ([dic isKindOfClass:[NSDictionary class]]) {
            IO(_id);
            IO(email);
            IO(password);
            IO(fullName);
            IO(created);
        }
    }
    return self;
}

- (NSMutableDictionary *)getJSONObject {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    JO(_id);
    JO(email);
    JO(password);
    JO(fullName);
    JO(created);
    return dic;
}

- (id )getJSONObjectWithMethod:(NSInteger)method{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if (method == METHOD_POST) {
        JO(email);
        JO(password);
    } else if (method == METHOD_POST_2) {
        JO(email);
        JO(password);
        JO(fullName);
    } else {
        JO(_id);
        JO(email);
        JO(password);
        JO(fullName);
        JO(created);
    }
    return dic;
}


@end
