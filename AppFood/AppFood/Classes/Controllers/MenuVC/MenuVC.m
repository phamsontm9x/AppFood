//
//  MenuVC.m
//  AppFood
//
//  Created by ThanhSon on 3/8/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "MenuVC.h"
#import "MenuDto.h"
#import "DishTypeListVC.h"
#import "SupportVC.h"
#import "FavouriteListVC.h"

typedef enum : NSUInteger {
    List = 0,
    Favourite,
    Support,
} MenuList;

@interface MenuVC () <UITableViewDelegate, UITableViewDataSource, BaseCellDelegate> {
    MenuListDto *_listMenu;
}

@end

@implementation MenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initMenu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark initListMenu

- (void)initMenu {
    _listMenu = [[MenuListDto alloc] init];
    // ListFood
    [_listMenu.list addObject:[[MenuDto alloc] initWithTitle:@"ListFood" andImage:@"list"]];
    [_listMenu.list addObject:[[MenuDto alloc] initWithTitle:@"Favourite food" andImage:@"favourite"]];
    [_listMenu.list addObject:[[MenuDto alloc] initWithTitle:@"Support" andImage:@"support"]];
}

#pragma mark - UITableViewCell

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  _listMenu.list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseCell * cell = [_tbvMenu dequeueReusableCellWithIdentifier:@"MenuCell"];
    
    MenuDto *menuDto = _listMenu.list[indexPath.row];
    cell.lblTitle.text = menuDto.title;
    cell.imgIcon.image = [UIImage imageNamed:menuDto.img];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BaseVC *vc;
    
    if (indexPath.row == List) {
        vc = VCFromSB(DishTypeListVC,@"ListFood");
    } else if (indexPath.row == Favourite) {
        vc = VCFromSB(FavouriteListVC, @"ListFood");
    } else {
        vc = VCFromSB(SupportVC, @"Support");
    }
    
    if(vc) {
        [AppNav popToRootAndSwitchToViewController:vc withSlideOutAnimation:YES
                                     andCompletion:nil];
    }
}

@end
