			//
//  UserVC.m
//  AppFood
//
//  Created by Nguyen on 4/28/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "UserVC.h"
#import "UserCell.h"
#import "AvatarDto.h"
#import "UIView+Util.h"
#import "UserDto.h"
#import "API.h"
#import "AppDelegate.h"
#import "AlertInputFormVC.h"

@interface UserVC () <UserCellDelegate, UITextFieldDelegate, UITableViewDelegate,UIImagePickerControllerDelegate, UITableViewDataSource> {
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
    [self updateData];
    // Do any additional setup after loading the view.
}

- (void)initVar {
    
    if (!_userDto) {
        _userDto = Config.userDto;
    }
}

- (void)refeshData {
    [_tbvUser addPullRefreshAtVC:self toReloadAction:@selector(updateData)];
    
}

- (void)updateData {
    
    _gender = _userDto.gender == YES ? @"Male" : @"Female";
    
    _arrTitle = @[@"Full Name", @"Birthday", @"Gender", @"Email", @"Phone", @"Address"];
    _arrInfo = @[_userDto.fullName, _userDto.birthday, _gender, _userDto.email, _userDto.phone, _userDto.address];
    [_tbvUser reloadData];
}


#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
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
        [cell.imgAvatar sd_setImageWithURL:[NSURL URLWithString: _userDto.image] placeholderImage:[UIImage imageNamed:@"logo"]];
        cell.delegate = self;
        
        return cell;
    } else {
        UserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserInfoCell"];
        [cell.vBack roundCornersOnTopLeft:YES topRight:YES bottomLeft:YES bottomRight:YES radius:10 andShadow:YES];
        cell.lblTitle.text = _arrTitle[row];
        cell.lblSubTitle.text = _arrInfo[row];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (section == 0) {
        //
    } else {
        if (row == 0) {
            [self editFullName];
        } else if (row == 1) {
            [self editBirthday];
        } else if (row == 2) {
            [self editGender];
        } else if (row == 4) {
            [self editPhone];
        } else if (row == 5) {
            [self editAddress];
        }
    }
}

#pragma mark - UserCellDelegate

- (void)userCell:(UserCell *)cell didChooseAvatar:(UIButton *)btn {
    NSIndexPath *indexPath = [self.tbvUser indexPathForCell:cell];
    NSInteger section = indexPath.section;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"App Food" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *actionCamera = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openCameraAction];
    }];
    
    UIAlertAction *actionLibrary = [UIAlertAction actionWithTitle:@"Photo Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openPhotoAction];
    }];
    
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:actionCamera];
    [alert addAction:actionLibrary];
    [alert addAction:actionCancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Action

- (void) editFullName {
    [AlertInputFormVC showAlertInputOneForm:@"Full Name" oldText:_userDto.fullName nameAction:@"Done" fromVC:self callback:^(NSString *content) {
        _userDto.fullName = content;
        [self updateInfoUser:_userDto];
        [_tbvUser reloadData];
    }];
}

- (void) editAddress {
    [AlertInputFormVC showAlertInputOneForm:@"Address" oldText:_userDto.address nameAction:@"Done" fromVC:self callback:^(NSString *content) {
        _userDto.phone = content;
        [self updateInfoUser:_userDto];
        [_tbvUser reloadData];
    }];
}

- (void) editPhone {
    [AlertInputFormVC showAlertInputType:INPUT_STYLE_NUMBER_PHONE oldText:_userDto.phone placeHolder:@"Phone Number" keyboardType:UIKeyboardTypeNumberPad btnDoneTitle:@"Done" fromVC:self callback:^(NSString *content) {
        _userDto.address = content;
        [self updateInfoUser:_userDto];
        [_tbvUser reloadData];
    }];
}

- (void) editBirthday {
    
}

- (void) editGender {
    
}

- (void)openCameraAction {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *_picker = [[UIImagePickerController alloc] init];
        _picker.allowsEditing = YES;
        _picker.delegate = self;
        _picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:_picker animated:YES completion:nil];
    }else {
        NSLog(@"You are working on simulator");
    }
}

- (void)openPhotoAction {
    UIImagePickerController *_picker = [[UIImagePickerController alloc] init];
    _picker.allowsEditing = YES;
    _picker.delegate = self;
    [_picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:_picker animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        [self setImageAvatarFood:image];
    }];
}

- (void)setImageAvatarFood:(UIImage *)image {
    _userDto.imgAvatar = image;
    AvatarDto *avatar = [[AvatarDto  alloc] init];
    avatar.name = @"AvatarFood123.jpg";
    avatar.fileContent = UIImageJPEGRepresentation(_userDto.imgAvatar, 1);
    [API createAvatarFile:avatar callback:^(BOOL success, AvatarDto *data) {
        if (success) {
            _userDto.image = SF(@"https://cookbook-server.herokuapp.com/%@",data.path);
            [self updateInfoUser:_userDto];
            [self updateData];
        }
    }];
    

}

#pragma mark - API

- (void)updateInfoUser:(UserDto *)dto {
    [App showLoading];

    [API updateInfoUser:dto callback:^(BOOL success, id data) {
        [App hideLoading];
        if (success) {
            _userDto = data;
            [Config updateUser:data];
            [self updateData];
        }
    }];
}

#pragma mark - SlideNavigationController

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

@end
