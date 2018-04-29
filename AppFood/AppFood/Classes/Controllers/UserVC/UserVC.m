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

@interface UserVC () <UserCellDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource> {
    NSArray *_arrTitle;
}

@end

@implementation UserVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initVar];
    // Do any additional setup after loading the view.
}

- (void)initVar {
    _arrTitle = @[@"Full Name", @"Birthday", @"Gender", @"Email", @"Phone", @"Address"];
}

#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return VALCond(section == 0, 1, 6);
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
    return VALCond(section == 0, 15, 30);
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
    } else {
        UserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserInfoCell"];
        [cell.vBack roundCornersOnTopLeft:YES topRight:YES bottomLeft:YES bottomRight:YES radius:10 andShadow:YES];
        cell.lblTitle.text = _arrTitle[row];
        
        return cell;
    }
}

#pragma mark - UserCellDelegate

- (void)userCell:(UserCell *)cell didChooseAvatar:(UIButton *)btn {
    
}

#pragma mark - SlideNavigationController

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

@end
