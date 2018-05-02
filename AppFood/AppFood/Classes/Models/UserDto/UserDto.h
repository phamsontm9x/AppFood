//
//  UserDto.h
//  AppFood
//
//  Created by ThanhSon on 3/16/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "BaseDto.h"
#import <UIKit/UIKit.h>

@interface UserDto : BaseDto

@property (nonatomic, strong) NSString *_id;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *phone;
@property (assign, nonatomic) BOOL gender;
@property (nonatomic, strong) NSString *birthday;
@property (nonatomic, strong) NSString *created;
@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) UIImage *imgAvatar;

@end
