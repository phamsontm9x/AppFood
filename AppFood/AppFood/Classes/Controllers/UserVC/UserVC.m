//
//  UserVC.m
//  AppFood
//
//  Created by Nguyen on 4/28/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "UserVC.h"
#import "UserCell.h"
#import "UIView+Util.h"
#import "UserDto.h"
#import "API.h"
#import "AppDelegate.h"

@interface UserVC () <UserCellDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource> {
    NSArray *_arrTitle;
    NSArray *_arrInfo;
    NSString *_gender;
    UserDto *_userDto;
}

@end

@implementation UserVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initVar];
    // Do any additional setup after loading the view.
}

- (void)initVar {
    if (!_userDto) {
        _userDto = Config.userDto;
    }
    _gender = _userDto.gender == YES ? @"Male" : @"Female";
    
    _arrTitle = @[@"Full Name", @"Birthday", @"Gender", @"Email", @"Phone", @"Address"];
//    _arrInfo = @[_userDto.fullName, _userDto.birthday, _gender, _userDto.email, _userDto.phone, _userDto.address];
    _arrInfo = @[_userDto.fullName, _userDto.fullName, _userDto.fullName, _userDto.email, _userDto.fullName, _userDto.fullName];
}

#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return VALCond(section == 1, 6, 1);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = indexPath.section;
    
    if (section == 0) {
        return 120;
    } else {
        return 60;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return VALCond(section == 1, 30, 15);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCellNull"];
    
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (section == 0) {
        UserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserAvatarCell"];
        
        [cell.imgAvatar roundCornersOnTopLeft:YES topRight:YES bottomLeft:YES bottomRight:YES radius:cell.imgAvatar.frame.size.height/2 andShadow:YES];
        [cell.vBack roundCornersOnTopLeft:YES topRight:YES bottomLeft:YES bottomRight:YES radius:10 andShadow:YES];
        cell.delegate = self;
        
        return cell;
    } else if (section == 1) {
        UserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserInfoCell"];
        [cell.vBack roundCornersOnTopLeft:YES topRight:YES bottomLeft:YES bottomRight:YES radius:10 andShadow:YES];
        cell.lblTitle.text = _arrTitle[row];
        cell.tfEdit.text = _arrInfo[row];
        
        return cell;
    } else {
        UserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserButtonCell"];
        [cell.btnAction roundCornersOnTopLeft:YES topRight:YES bottomLeft:YES bottomRight:YES radius:10 andShadow:YES];
        cell.delegate = self;
        
        return cell;
    }
}

#pragma mark - UserCellDelegate

- (void)userCell:(UserCell *)cell didChooseAvatar:(UIButton *)btn {
    NSIndexPath *indexPath = [self.tbvUser indexPathForCell:cell];
    NSInteger section = indexPath.section;
    
    if (section == 0) {
        //
    } else {
        [self updateInfoUser];
    }
}

#pragma mark - API

- (void)updateInfoUser {
    [App showLoading];
    
    _userDto.fullName = @"Nhat Anh";
    _userDto.phone = @"0989888888";
    _userDto.gender = YES;
    _userDto.birthday = @"12/12/1996";
    
    [API updateInfoUser:_userDto callback:^(BOOL success, id data) {
        [App hideLoading];
        if (success) {
            _userDto = data;
            Config.userDto = data;
            [_tbvUser reloadData];
        }
    }];
}

#pragma mark - SlideNavigationController

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

@end
