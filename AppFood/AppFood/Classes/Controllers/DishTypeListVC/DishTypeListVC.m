//
//  DishTypeListVC.m
//  AppFood
//
//  Created by ThanhSon on 3/9/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "DishTypeListVC.h"
#import "DetailDishVC.h"
#import "DishListCell.h"

@interface DishTypeListVC () <UICollectionViewDelegate, UICollectionViewDataSource> {
    
    NSArray *_arrFood;
}

@end

@implementation DishTypeListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    // Do any additional setup after loading the view.
    [self setTitleNav:@"ListFood" andImgButton:[UIImage imageNamed:@"menu"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initData {
    _arrFood = @[@"Ga", @"Vit", @"Heo", @"Bo"];
}

#pragma mark - CollectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _arrFood.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DishListCell *cell = [_clvListFood dequeueReusableCellWithReuseIdentifier:@"DishListCell" forIndexPath:indexPath];
    
    cell.lblTitle.text = _arrFood[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DetailDishVC * vc = VCFromSB(DetailDishVC,SB_ListFood);
    
    vc.txtDishName = _arrFood[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
