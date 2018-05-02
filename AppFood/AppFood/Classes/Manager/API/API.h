//
//  API.h
//  AppFood
//
//  Created by ThanhSon on 3/14/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDto.h"
#import "define.h"
#import "UIKit/UIKit.h"

#define API [_API shared]

@class AvatarDto;
@class UserDto;
@class DetailDishDto;
@class ListDishDto;
@class DishTypeDto;
@class CommentDto;

typedef void (^APICallback)(BOOL success, id data);

@interface _API : NSObject

+ (_API*) shared;


- (void) processAPI:(NSString*)route
          serverURL:(NSString*)server
             method:(NSInteger)methodType
             header:(NSDictionary*)headers
               body:(id)body
       successClass:(Class)successClass
           callback:(APICallback)callback;
- (void) processAPI:(NSString*)route
             method:(NSInteger)methodType
             header:(NSDictionary*)headers
               body:(id)body
       successClass:(Class)successClass
           callback:(APICallback)callback;

#pragma mark - ListFood
- (void)getListTypeDish:(APICallback)callback;
- (void)getListDishDetail:(DishTypeDto*)dto callback:(APICallback)callback;
- (void)createTypeDish:(DishTypeDto *)dto callback:(APICallback)callback;
- (void)getDishDetail:(NSString *)foodId callback:(APICallback)callback;
- (void)updateFavoriteFoodDetail:(DetailDishDto *)foodId callback:(APICallback)callback;
- (void)createDetailDish:(DetailDishDto *)dto callback:(APICallback)callback;

#pragma mark - Login
- (void)login:(UserDto*)user callback:(APICallback)callback;
- (void)registerAccount:(UserDto*)user callback:(APICallback)callback;
- (void)updateInfoUser:(UserDto *)dto callback:(APICallback)callback;

#pragma mark - Image
- (void)createAvatarFile:(AvatarDto*)avatar callback:(APICallback)callback;

#pragma mark - Comment
- (void)writeComment:(CommentDto *)dto callback:(APICallback)callback;
- (void)getAllComment:(NSString *)foodId callback:(APICallback)callback;

@end
