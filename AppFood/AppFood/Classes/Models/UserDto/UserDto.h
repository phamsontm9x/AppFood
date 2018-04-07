//
//  UserDto.h
//  AppFood
//
//  Created by ThanhSon on 3/16/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "BaseDto.h"

@interface UserDto : BaseDto

@property (nonatomic, strong) NSString *_id;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, strong) NSString *created;

@end
