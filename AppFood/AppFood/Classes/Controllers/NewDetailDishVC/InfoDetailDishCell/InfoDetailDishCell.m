//
//  InfoDetailDishCell.m
//  AppFood
//
//  Created by ThanhSon on 4/6/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "InfoDetailDishCell.h"
#import "NewDetailDishTbvCell.h"
#import "AlertInputFormVC.h"

@interface InfoDetailDishCell() <UITableViewDelegate, UITableViewDataSource, NewDetailDishTbvCellDelegate, UIImagePickerControllerDelegate, BaseColCellDelegate, UITextFieldDelegate> {
    
    UIImage *imgAvatar;
    NSString *nameDish;
    NSString *linkDish;
    NSString *desDish;
    NSString *timerDish;
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
    
    desDish = @"";
    linkDish = @"";
    nameDish = @"";
    timerDish = @"";
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
            cell.lblSubTitle.text = nameDish;
            cell.tviewDesc.text = desDish;
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
            cell.lblSubTitle.text = linkDish;
            cell.delegate = self;
            break;
        }
        case 4: {
            cell = [tableView dequeueReusableCellWithIdentifier:@"NDInfoHeaderCell"];
            cell.lblTitle.text = @"TIME";
            break;
        }
        case 5: {
            cell = [tableView dequeueReusableCellWithIdentifier:@"NDInfoTimeCell"];
            cell.delegate = self;
            cell.lblDuration.text = SF(@"%@ minutes", timerDish);
            break;
        }
            
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    
    switch (row) {
        case 3: {
            [AlertInputFormVC showAlertInputOneForm:@"Enter link" oldText:linkDish nameAction:@"Done" fromVC:self.rootVC callback:^(NSString *content) {
                linkDish = content;
                [self updateUI];
            }];
        }
        case 5: {
            [AlertInputFormVC showAlertInputType:INPUT_STYLE_ONE oldText:timerDish placeHolder:@"Timer" keyboardType:UIKeyboardTypeNumberPad btnDoneTitle:@"Done" fromVC:self.rootVC callback:^(NSString *content) {
                timerDish = content;
                [self updateUI];
            }];
        }
        default:
            break;
    }
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
    self.dataDto.time = timerDish;
    self.dataDto.decriptions = desDish;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(indexCell:selectBtnNext:orBtnBack:)]) {
        [self.delegate indexCell:0 selectBtnNext:YES orBtnBack:NO];
    }
}

- (void)newDetailDishTbvCell:(NewDetailDishTbvCell *)cell onEditDesPressed:(UIButton *)btn {
    [AlertInputFormVC showAlertInputOneForm:@"Enter description" oldText:desDish nameAction:@"Done" fromVC:self.rootVC callback:^(NSString *content) {
        desDish = content;
        [self updateUI];
    }];
}

- (void)newDetailDishTbvCell:(NewDetailDishTbvCell *)cell onEditNamePressed:(UIButton *)btn {
    [AlertInputFormVC showAlertInputOneForm:@"Enter name" oldText:nameDish nameAction:@"Done" fromVC:self.rootVC callback:^(NSString *content) {
        nameDish = content;
        [self updateUI];
    }];
}


@end
