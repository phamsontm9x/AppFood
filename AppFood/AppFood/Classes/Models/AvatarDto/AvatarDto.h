//
//  AvatarDto.h
//  AppFood
//
//  Created by ThanhSon on 4/30/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "BaseDto.h"

@interface AvatarDto : BaseDto

@property (nonatomic, strong) NSData *fileContent;
@property (nonatomic, strong) NSString *_boundary;
@property (nonatomic, strong) NSString *_id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *path;

@end
