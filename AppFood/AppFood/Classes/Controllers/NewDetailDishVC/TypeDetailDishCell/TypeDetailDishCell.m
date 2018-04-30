//
//  TypeDetailDishCell.m
//  AppFood
//
//  Created by ThanhSon on 4/6/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "TypeDetailDishCell.h"
#import "AvatarDto.h"
#import "API.h"
#import "DetailDishDto.h"

@implementation TypeDetailDishCell

#pragma mark - Action

- (IBAction)btnBackPressed:(UIButton *)btn {
    
    AvatarDto *avatar = [[AvatarDto  alloc] init];
    avatar.name = @"AvatarFood123.jpg";
    avatar.fileContent = UIImageJPEGRepresentation(self.dataDto.imgAvatar, 1);
    [App showLoading];
    [API createAvatarFile:avatar callback:^(BOOL success, AvatarDto *data) {
        
        if (success) {
            self.dataDto.image = SF(@"https://cookbook-server.herokuapp.com/%@",data.path);
            [API createDetailDish:self.dataDto callback:^(BOOL success, id data) {
                [App hideLoading];
            }];
        }
    }];
    

    
//    if (self.delegate && [self.delegate respondsToSelector:@selector(indexCell:selectBtnNext:orBtnBack:)]) {
//
//        [self.delegate indexCell:3 selectBtnNext:NO orBtnBack:YES];
//    }
}

@end
