//
//  FavouriteListVC.m
//  AppFood
//
//  Created by ThanhSon on 3/9/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "FavouriteListVC.h"
#import "DetailDishDto.h"
#import "DishListCell.h"
#import "DetailDishVC.h"
#import "API.h"
#import "UIView+Util.h"
#import "NewDetailDishVC.h"
#import "FileHelper.h"

@interface FavouriteListVC () <UITableViewDelegate, UITableViewDataSource,DishListCellDelegate> {
    ListDishDetailDto *_listData;
}

@end

@implementation FavouriteListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    [self updateData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    //    self.navigationController.navigationBar.alpha = 0.3;
}

- (void)initUI {
    self.navigationItem.title = _typeDto.name;
}

- (void)updateData {
    _listData = [FileHelper getListFavorite];
    [self.tbvDishFavorite reloadData];

}

#pragma mark UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  _listData.list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 400;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DishListCell * cell = [_tbvDishFavorite dequeueReusableCellWithIdentifier:@"Cell"];
    
    DetailDishDto *dto = _listData.list[indexPath.row];
    cell.lblTitle.text = dto.name;
    cell.lblSubTitle.text = dto.decriptions;
    [cell.imgAvatar roundCornersOnTopLeft:YES topRight:YES bottomLeft:YES bottomRight:YES radius:cell.imgAvatar.frame.size.height/2];
    cell.lblTimer.text = dto.time;
    
    [cell.imgIcon sd_setImageWithURL:[NSURL URLWithString:dto.image]
                    placeholderImage:[UIImage imageNamed:@"none.9"]];
    
    cell.delegate = self;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailDishVC * vc = VCFromSB(DetailDishVC,SB_ListFood);
    vc.fooddish = _listData.list[indexPath.row];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - DishListCellDelegate
- (void)dishListCell:(DishListCell *)cell didSelectedSave:(UIButton *)btn {
    NSIndexPath *indexPath = [self.tbvDishFavorite indexPathForCell:cell];
    NSInteger row = indexPath.row;
    
    DetailDishDto *dto = _listData.list[row];
    if (!dto.hasSave) {
        [FileHelper saveFoodToFavorate:dto];
    }else {
        [FileHelper removeFavorite:dto];
        [self updateData];
    }
}

- (void)dishListCell:(DishListCell *)cell didSelectedShare:(UIButton *)btn  {
    
}

#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu {
    return YES;
}

- (void)initNav {
    self.navigationItem.title = @"FavouriteList";
}

@end
