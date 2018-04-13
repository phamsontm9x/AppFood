//
//  NewDetailDishVC.m
//  AppFood
//
//  Created by ThanhSon on 4/6/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "NewDetailDishVC.h"
#import "BaseColCell.h"

@interface NewDetailDishVC () <UICollectionViewDelegate, UICollectionViewDataSource> {
    NSArray *_arrCell;
}

@end

@implementation NewDetailDishVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - InitUI
- (void)initUI {
    _arrCell = @[@"InfoDetailDishCell",
                 @"IngredientDetailDishCell",
                 @"StepsDetailDishCell",
                 @"TypeDetailDishCell"];
    [_clvContent reloadData];
}



#pragma mark - UICollectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _arrCell.count;
}

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return collectionView.frame.size;
}

- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BaseColCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_arrCell[indexPath.row] forIndexPath:indexPath];
    
    cell.rootVC = self;
    
    return cell;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger index = (_clvContent.contentOffset.x / _clvContent.frame.size.width);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = (_clvContent.contentOffset.x / _clvContent.frame.size.width);
}


#pragma mark - MenuScrollDelegate
-(void)scrollMenuDidSelectedIndex:(NSIndexPath *)index {
    [_clvContent setContentOffset:CGPointMake(index.row * _clvContent.frame.size.width, 0) animated:YES];
}

@end
