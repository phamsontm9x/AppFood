//
//  DishTypeListVC.m
//  AppFood
//
//  Created by ThanhSon on 3/9/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "DishTypeListVC.h"
#import "DetailDishVC.h"

@interface DishTypeListVC ()

@end

@implementation DishTypeListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitleNav:@"ListFood" andImgButton:[UIImage imageNamed:@"menu"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnDetailTest:(id)sender {
    DetailDishVC * vc = VCFromSB(DetailDishVC,SB_ListFood);
    [self.navigationController pushViewController:vc animated:YES];
}

@end
