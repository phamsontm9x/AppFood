//
//  InfoDetailDishCell.m
//  AppFood
//
//  Created by ThanhSon on 4/6/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "InfoDetailDishCell.h"
#import "NewDetailDishTbvCell.h"

@interface InfoDetailDishCell() <UITableViewDelegate, UITableViewDataSource, NewDetailDishTbvCellDelegate>

@end

@implementation InfoDetailDishCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initVar];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self layoutIfNeeded];
}

#pragma mark - InitUI

- (void)initVar {
    if (!_parentVC) {
        _parentVC = [[NewDetailDishVC alloc] init];
    }
    
    if (!self.rootVC) {
        self.rootVC = [[NewDetailDishVC alloc] init];
    }
    
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
            break;
        }
        case 2: {
            cell = [tableView dequeueReusableCellWithIdentifier:@"NDInfoHeaderCell"];
            cell.lblTitle.text = @"VIDEO (YOUTUBE CODE)";
            break;
        }
        case 3: {
            cell = [tableView dequeueReusableCellWithIdentifier:@"NDInfoYoutubeCell"];
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

- (void)newDetailDishTbvCell:(NewDetailDishTbvCell *)cell btnChoseDishAvatar:(UIButton *)btn {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"App Food" message:@"Choose your dish's avatar" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *actionCamera = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //
    }];
    
    UIAlertAction *actionLibrary = [UIAlertAction actionWithTitle:@"Photo Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //
    }];
    
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //
    }];
    
    [alert addAction:actionCamera];
    [alert addAction:actionLibrary];
    [alert addAction:actionCancel];
     
    [self.rootVC presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Action



@end
