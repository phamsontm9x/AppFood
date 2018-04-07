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
#import "UserDto.h"
#import "WelcomeVC.h"
#import "UIView+Util.h"

typedef enum : NSUInteger {
    List = 0,
    Favourite,
    MoreApp,
    Update,
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
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI {
    [_imageAvatar roundCornersOnTopLeft:YES topRight:YES bottomLeft:YES bottomRight:YES radius:_imageAvatar.frame.size.height/2];
    [_btnLogout roundCornersOnTopLeft:YES topRight:YES bottomLeft:YES bottomRight:YES radius:_btnLogout.frame.size.height/2];
    _vUser.layer.cornerRadius = 10;
    _lblUserName.text = App.configure.userDto.fullName;
    _csRightView.constant = PORTRANIT_SLIDE_OFFSET + 10;
}

#pragma mark initListMenu

- (void)initMenu {
    _listMenu = [[MenuListDto alloc] init];
    // ListFood
    [_listMenu.list addObject:[[MenuDto alloc] initWithTitle:@"Danh Mục" andImage:@"danhmuc"]];
    [_listMenu.list addObject:[[MenuDto alloc] initWithTitle:@"Danh Sách Món Ăn Yêu Thích" andImage:@"favourite"]];
    [_listMenu.list addObject:[[MenuDto alloc] initWithTitle:@"Ứng dụng hay" andImage:@"ungdung"]];
    [_listMenu.list addObject:[[MenuDto alloc] initWithTitle:@"Kiểm tra bản cập nhật" andImage:@"update"]];
    [_listMenu.list addObject:[[MenuDto alloc] initWithTitle:@"Về chúng tôi" andImage:@"info"]];
}

#pragma mark Action
- (IBAction)btnLogout:(id)sender {
    App.configure.userDto = nil;
    [Config.defaults removeObjectForKey:@"UserDto"];
    [Config.defaults removeObjectForKey:@"token"];
    WelcomeVC *vc = VCFromSB(WelcomeVC, SB_Login);
    [AppNav popToRootAndSwitchToViewController:vc withSlideOutAnimation:YES
                                 andCompletion:nil];
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
    } else {

    }
}

@end
