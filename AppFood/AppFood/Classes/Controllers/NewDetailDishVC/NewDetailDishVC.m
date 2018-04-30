//
//  NewDetailDishVC.m
//  AppFood
//
//  Created by ThanhSon on 4/6/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "NewDetailDishVC.h"
#import "BaseColCell.h"

@interface NewDetailDishVC () <UICollectionViewDelegate, UICollectionViewDataSource, BaseColCellDelegate> {
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
    _dataDto = [[DetailDishDto alloc] init];
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
    
    cell.dataDto = self.dataDto;
    cell.rootVC = self;
    cell.delegate = self;
    
    return cell;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //NSInteger index = (_clvContent.contentOffset.x / _clvContent.frame.size.width);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //NSInteger index = (_clvContent.contentOffset.x / _clvContent.frame.size.width);
}


#pragma mark - MenuScrollDelegate
-(void)scrollMenuDidSelectedIndex:(NSInteger )index {
    [_clvContent setContentOffset:CGPointMake(index * _clvContent.frame.size.width, 0) animated:YES];
}

#pragma mark - BaseColDelagate
- (void)indexCell:(NSInteger)index selectBtnNext:(BOOL)btnNext orBtnBack:(BOOL)btnBack {
    if (btnNext) {
        [self scrollMenuDidSelectedIndex:index+1];
    } else {
        [self scrollMenuDidSelectedIndex:index-1];
    }
}

@end
