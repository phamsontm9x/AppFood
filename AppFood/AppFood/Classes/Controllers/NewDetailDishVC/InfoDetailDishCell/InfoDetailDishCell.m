//
//  InfoDetailDishCell.m
//  AppFood
//
//  Created by ThanhSon on 4/6/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "InfoDetailDishCell.h"
#import "NewDetailDishTbvCell.h"

@interface InfoDetailDishCell() <UITableViewDelegate, UITableViewDataSource, NewDetailDishTbvCellDelegate, UIImagePickerControllerDelegate, BaseColCellDelegate, UITextFieldDelegate> {
    
    UIImage *imgAvatar;
    NSString *nameDish;
    NSString *linkDish;
}

@end

@implementation InfoDetailDishCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initVar];
    [self updateUI];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self layoutIfNeeded];
}

#pragma mark - InitUI

- (void)initVar {
    
    imgAvatar = [UIImage imageNamed:@"banner"];
}

- (void)updateUI {
    [_tbvInfo reloadData];
}

#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    
    switch (row) {
        case 0:
        case 2:
        case 4:
            return 40;
            break;
        case 1:
            return 350;
        case 3:
            return 35;
        default:
            return 30;
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    NewDetailDishTbvCell *cell;
    
    switch (row) {
        case 0: {
            cell = [tableView dequeueReusableCellWithIdentifier:@"NDInfoHeaderCell"];
            cell.lblTitle.text = @"AVATAR";
            break;
        }
        case 1: {
            cell = [tableView dequeueReusableCellWithIdentifier:@"NDInfoDesCell"];
            cell.delegate = self;
            cell.tfLink.delegate = self;
            cell.tfLink.tag = 0;
            cell.imgAvatar.image = imgAvatar;
            break;
        }
        case 2: {
            cell = [tableView dequeueReusableCellWithIdentifier:@"NDInfoHeaderCell"];
            cell.lblTitle.text = @"VIDEO (YOUTUBE CODE)";
            break;
        }
        case 3: {
            cell = [tableView dequeueReusableCellWithIdentifier:@"NDInfoYoutubeCell"];
            cell.tfLink.delegate = self;
            cell.tfLink.tag = 1;
            break;
        }
        case 4: {
            cell = [tableView dequeueReusableCellWithIdentifier:@"NDInfoHeaderCell"];
            cell.lblTitle.text = @"TIME";
            break;
        }
        case 5: {
            cell = [tableView dequeueReusableCellWithIdentifier:@"NDInfoTimeCell"];
            break;
        }
            
        default:
            break;
    }
    return cell;
}

#pragma mark - NewDetailDishCellDelegate

- (void)newDetailDishTbvCell:(NewDetailDishTbvCell *)cell onBtnPressed:(UIButton *)btn {
    
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
     
    [self.rootVC presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Action

- (void)openCameraAction {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *_picker = [[UIImagePickerController alloc] init];
        _picker.allowsEditing = YES;
        _picker.delegate = self.rootVC;
        _picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self.rootVC presentViewController:_picker animated:YES completion:nil];
    }else {
        NSLog(@"You are working on simulator");
    }
}

- (void)openPhotoAction {
    UIImagePickerController *_picker = [[UIImagePickerController alloc] init];
    _picker.allowsEditing = YES;
    _picker.delegate = self;
    [_picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self.rootVC presentViewController:_picker animated:YES completion:nil];
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

#pragma mark - Other

- (void)setImageAvatarFood:(UIImage *)image {
    imgAvatar = image;
    [_tbvInfo reloadData];
}

#pragma mark - BaseCollCellDelegate
- (IBAction)btnNextPressed:(UIButton *)btn {
    self.dataDto.imgAvatar = imgAvatar;
    self.dataDto.name = nameDish;
    self.dataDto.youtube = linkDish;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(indexCell:selectBtnNext:orBtnBack:)]) {
        [self.delegate indexCell:0 selectBtnNext:YES orBtnBack:NO];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 0) {
        nameDish = textField.text;
    } else {
        linkDish = textField.text;
    }
}
@end
