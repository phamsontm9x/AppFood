//
//  DishListVC.m
//  AppFood
//
//  Created by ThanhSon on 3/15/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "DishListVC.h"
#import "DetailDishDto.h"
#import "BaseCell.h"
#import "DetailDishVC.h"



@interface DishListVC () <UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *_listDish;
}

@end

@implementation DishListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _listDish = [[NSMutableArray alloc] init];
    [self getDataFromServer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getDataFromServer {
    
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *encodedUrlAsString = [ServerURL stringByAddingPercentEncodingWithAllowedCharacters:set];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    [[session dataTaskWithURL:[NSURL URLWithString:encodedUrlAsString]
            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                if (!error) {
                    [self parseDataFromJson:data];
                }
            }] resume];
}

- (void)parseDataFromJson:(NSData *)data {
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                            options:NSJSONReadingMutableContainers
                                                           error:nil];
    NSArray *arrData = [json objectForKey:_typeDto._id];
    for (NSDictionary *dic in arrData) {
        DetailDishDto *dto = [[DetailDishDto alloc] initWithData:dic];
        [_listDish addObject:dto];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
       [_tbvDish reloadData];
    });
    
}

#pragma mark UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  _listDish.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseCell * cell = [_tbvDish dequeueReusableCellWithIdentifier:@"Cell"];
    
    DetailDishDto *dto = _listDish[indexPath.row];
    cell.lblTitle.text = dto.name;
    cell.lblSubTitle.text = dto.desc;
    
    if (indexPath.row % 2 == 0) {
        cell.vBackground.backgroundColor = RGB(0xDEE7BE);
    } else {
        cell.vBackground.backgroundColor = RGB(0xAAC9BB);
    }
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:dto.url]
                 placeholderImage:[UIImage imageNamed:@"none.9"]];
    //cell.imgIcon.image = [UIImage imageNamed:menuDto.img];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DishListVC * vc = VCFromSB(DishListVC,SB_ListFood);
    [self presentViewController:vc animated:YES completion:nil];
}

@end
