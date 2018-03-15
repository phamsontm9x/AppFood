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
#import "ListDishDto.h"
#import "DishListVC.h"

@interface DishTypeListVC () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {
    
    NSMutableArray * _arrDishType;
}

@end

@implementation DishTypeListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (void)initData {
    
    self.navigationItem.title = @"Danh Mục";
    
    NSArray * _arrName = @[@"Thịt Heo", @"Thịt Vịt", @"Rau Củ", @"Thịt Bò", @"Đậu phụ", @"Thịt Gà", @"Hải sản", @"Trứng"];
    NSArray * _arrImg = @[@"thitheo", @"thitvit", @"raucu", @"thitbo", @"dauphu", @"thitga", @"haisankhac", @"trung"];
    NSArray * _idDishType = @[@"Heo", @"Vit", @"Rau", @"Bo", @"Dau", @"Ga", @"HS", @"Trung"];
    
    _arrDishType = [[NSMutableArray alloc] init];
    for (int i = 0; i < _arrName.count ; i++) {
        [_arrDishType addObject: [[ListDishDto alloc] initWithID:_idDishType[i] Image:_arrImg[i] andName:_arrName[i]]];
    }
    [_clvListFood reloadData];
}

#pragma mark - CollectionView

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    float size = collectionView.frame.size.width/2 - 4;
    return CGSizeMake(size, size);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(2, 2, 2, 2);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 4;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 4;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _arrDishType.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DishListCell *cell = [_clvListFood dequeueReusableCellWithReuseIdentifier:@"DishListCell" forIndexPath:indexPath];
    ListDishDto *dto = _arrDishType[indexPath.row];
    cell.lblTitle.text = dto.name;
    cell.imgFood.image = [UIImage imageNamed:dto.img];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DishListVC * vc = VCFromSB(DishListVC,SB_ListFood);
    ListDishDto *dto = _arrDishType[indexPath.row];
    vc.typeDto = dto;

    [self.navigationController pushViewController:vc animated:YES];
}
@end
