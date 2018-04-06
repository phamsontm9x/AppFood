//
//  DishListVC.m
//  AppFood
//
//  Created by ThanhSon on 3/15/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "DishListVC.h"
#import "DetailDishDto.h"
#import "DishListCell.h"
#import "DetailDishVC.h"
#import "API.h"
#import "UIView+Util.h"

@interface DishListVC () <UITableViewDelegate, UITableViewDataSource> {
    ListDishDetailDto *_listData;
}

@end

@implementation DishListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    [_tbvDish addPullRefreshAtVC:self toReloadAction:@selector(getDataFromServer)];
    [self getDataFromServer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI {
    _listData = [[ListDishDetailDto alloc] init];
    self.navigationItem.title = _typeDto.name;
}

- (void)getDataFromServer {
 
    if (![_tbvDish.refreshCtrl isRefreshing]) {
        [App showLoading];
    }
    [API getListDishDetail:_typeDto callback:^(BOOL success, id data) {
        [App hideLoading];
        [_tbvDish hideIndicator];
        if (success) {
            _listData = data;
            [_tbvDish reloadData];
        }
    }];
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
    DishListCell * cell = [_tbvDish dequeueReusableCellWithIdentifier:@"Cell"];
    
    DetailDishDto *dto = _listData.list[indexPath.row];
    cell.lblTitle.text = dto.name;
    cell.lblSubTitle.text = dto.decriptions;
    [cell.imgAvatar roundCornersOnTopLeft:YES topRight:YES bottomLeft:YES bottomRight:YES radius:cell.imgAvatar.frame.size.height/2];
    cell.lblTimer.text = dto.time;
    
    [cell.imgIcon sd_setImageWithURL:[NSURL URLWithString:dto.image]
                 placeholderImage:[UIImage imageNamed:@"none.9"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailDishVC * vc = VCFromSB(DetailDishVC,SB_ListFood);
    vc.fooddish = _listData.list[indexPath.row];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
