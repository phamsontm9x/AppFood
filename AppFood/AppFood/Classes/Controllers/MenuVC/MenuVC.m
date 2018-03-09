//
//  MenuVC.m
//  AppFood
//
//  Created by ThanhSon on 3/8/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "MenuVC.h"

@interface MenuVC () <UITableViewDelegate, UITableViewDataSource, BaseCellDelegate> {
    
}

@end

@implementation MenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewCell

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseCell * cell = [_tbvMenu dequeueReusableCellWithIdentifier:@"MenuCell"];
    cell.lblTitle.text = @"Title...";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SupportVC *vc = VCFromSB(SupportVC, @"Support");
    
    // AppShare [UIApplication sharedApplication]
    // App ((AppDelegate*)AppShare.delegate)
    
    if(vc) {
        [App.mainVC showPanel:NO animation:NO];
        [App.mainVC.contentNV setViewControllers:@[vc] animated:NO];
    }
    
}

@end
