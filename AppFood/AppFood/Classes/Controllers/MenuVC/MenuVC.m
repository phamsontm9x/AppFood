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
#import "UserVC.h"
#import "NewDetailDishVC.h"

typedef enum : NSUInteger {
    List = 0,
    Favourite,
    MoreApp,
    AboutUs,
    Logout,
} MenuList;

@interface MenuVC () <UITableViewDelegate, UITableViewDataSource> {
    MenuListDto *_listMenu;
}

@end

@implementation MenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initMenu];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI {
    [_imageAvatar roundCornersOnTopLeft:YES topRight:YES bottomLeft:YES bottomRight:YES radius:_imageAvatar.frame.size.height/2];
    _vUser.layer.cornerRadius = 10;
    _lblUserName.text = Config.userDto.fullName;
    _csRightView.constant = PORTRANIT_SLIDE_OFFSET + 10;
}

#pragma mark initListMenu

- (void)initMenu {
    _listMenu = [[MenuListDto alloc] init];
    // ListFood
    [_listMenu.list addObject:[[MenuDto alloc] initWithTitle:@"List Food" andImage:@"danhmuc"]];
    [_listMenu.list addObject:[[MenuDto alloc] initWithTitle:@"Saved Food" andImage:@"favourite"]];
    [_listMenu.list addObject:[[MenuDto alloc] initWithTitle:@"Apps" andImage:@"ungdung"]];
    [_listMenu.list addObject:[[MenuDto alloc] initWithTitle:@"About us" andImage:@"info"]];
    [_listMenu.list addObject:[[MenuDto alloc] initWithTitle:@"Logout" andImage:@"logout"]];
}

#pragma mark Action

- (IBAction)btnCreatePressed:(id)sender {
    NewDetailDishVC *vc = VCFromSB(NewDetailDishVC, SB_NewDetail);
    [AppNav popToRootAndSwitchToViewController:vc withSlideOutAnimation:YES
                                 andCompletion:nil];
}

- (IBAction)btnProfilePressed:(id)sender {
    UserVC *vc = VCFromSB(UserVC, SB_Support);
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
        vc = VCFromSB(DishTypeListVC,SB_ListFood);
        [AppNav popToRootAndSwitchToViewController:vc withSlideOutAnimation:YES
                                     andCompletion:nil];
    } else if (indexPath.row == Favourite) {
        vc = VCFromSB(FavouriteListVC, SB_ListFood);
        [AppNav popToRootAndSwitchToViewController:vc withSlideOutAnimation:YES
                                     andCompletion:nil];
    } else if (indexPath.row == Logout){
        App.configure.userDto = nil;
        [Config.defaults removeObjectForKey:@"UserDto"];
        [Config.defaults removeObjectForKey:@"token"];
        WelcomeVC *vc = VCFromSB(WelcomeVC, SB_Login);
        [AppNav popToRootAndSwitchToViewController:vc withSlideOutAnimation:YES
                                     andCompletion:nil];
    } else {
        vc = VCFromSB(SupportVC, SB_Support);
        [AppNav popToRootAndSwitchToViewController:vc withSlideOutAnimation:YES
                                     andCompletion:nil];
    }
}

@end
