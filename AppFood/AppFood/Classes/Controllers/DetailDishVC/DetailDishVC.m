//
//  DetailDishVC.m
//  AppFood
//
//  Created by ThanhSon on 3/9/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "DetailDishVC.h"
#import "DetailDishCell.h"

#define offset_HeaderStop 180
#define offset_B_LabelHeader 100
#define distance_W_LabelHeader 20

typedef enum : NSUInteger {
    Desc = 0,
    Info,
    Ingredients,
    Step,
    Youtube,
    
} Section;

@interface DetailDishVC () <UITableViewDataSource, UITableViewDelegate, UIWebViewDelegate, UIScrollViewDelegate, HBannerDelegate> {
    
}

@end

@implementation DetailDishVC

- (void)viewDidLoad
{
    [self initUIHeader];
    [super viewDidLoad];
    
    [self initVar];
}

- (void)initUIHeader {
    [_vHeaderTbv setFrame:CGRectMake(0, 0, SWIDTH, 200)]; // include (200 + size View 60)
    _tbvContent.tableHeaderView = _vHeaderTbv;
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: _fooddish.image]];
    _imgHeaderView.image = [UIImage imageWithData: imageData];
    _vHeaderView.clipsToBounds = YES;
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)initVar {
    if (!_fooddish) {
        _fooddish = [[DetailDishDto alloc] init];
    }
}

#pragma mark -
#pragma mark Tableview data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case Info:
            return 0;
        case Step:
            return _fooddish.content.count + 1;
        case Ingredients:
            return _fooddish.materials.count + 1;
            break;
        default:
            return 1;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return VALCond(section == Info, 50, 0);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    switch (section) {
        case Desc:
            return 110;
        case Youtube:
            return 250;
        case Step:
            return VALCond(indexPath.row == 0, 40, 400);
        default:
            return 40;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    DetailDishCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InfoHeaderCell"];
    cell.lblIngredients.text = SF(@"%ld",_fooddish.materials.count);
    
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    DetailDishCell *cell;
    switch (section) {
        case Desc: {
            cell = [tableView dequeueReusableCellWithIdentifier:@"DescCell"];
            cell.lblFullName.text = _fooddish.name;
            cell.lblSubTitle.text = _fooddish.decriptions;
            return cell;
        }
        case Ingredients: {
            if (row == 0) {
                cell = [tableView dequeueReusableCellWithIdentifier:@"IngredientHeaderCell"];
                [self roundedConners:UIRectCornerTopRight|UIRectCornerTopLeft withRadius:10 for:cell.vBackground];
                
            } else {
                cell = [tableView dequeueReusableCellWithIdentifier:@"IngredientRowCell"];
                cell.lblTitle.text = _fooddish.materials[row - 1].material;
                cell.lblSubTitle.text = _fooddish.materials[row - 1].amount;
                if (_fooddish.materials.count == row) {
                    cell.csBotRow.constant = 5;
                    [self roundedConners:UIRectCornerBottomLeft|UIRectCornerBottomRight withRadius:10 for:cell.vBackground];
                    cell.lineView.hidden = YES;
                    [cell layoutSubviews];
                    [cell layoutIfNeeded];
                }
            }
            
            return cell;
        }
        case Youtube: {
            cell = [tableView dequeueReusableCellWithIdentifier:@"YoutubeCell"];
            cell.wvYoutube.allowsInlineMediaPlayback = YES;
            cell.wvYoutube.delegate = self;
            cell.wvYoutube.mediaPlaybackRequiresUserAction = NO;
            cell.wvYoutube.mediaPlaybackAllowsAirPlay = YES;
            cell.wvYoutube.scrollView.bounces = NO;
            
            NSString *linkUrl = _fooddish.youtube;
            NSString *embemdHTML = SF(@"<iframe width=""%f"" height=""%f"" src=""%@"" frameborder=""0"" allow=""autoplay; encrypted-media"" allowfullscreen></iframe>",cell.wvYoutube.frame.size.width, cell.wvYoutube.frame.size.height, linkUrl);
            [cell.wvYoutube loadHTMLString:embemdHTML baseURL:nil];
            
            return cell;
        }
        case Step: {
            if (row == 0) {
                cell = [tableView dequeueReusableCellWithIdentifier:@"HeaderCell"];
                cell.lblTitle.text = @"COOK STEPS";
            } else {
                cell = [tableView dequeueReusableCellWithIdentifier:@"StepRowCell"];
                [cell.vBanner setDataDisplay:_fooddish.content[row - 1].arrImage];
                [cell.vBanner setMaxPageControlNumber:_fooddish.content[row - 1].arrImage.count];
                cell.vBanner.delegate = self;
                
                NSMutableAttributedString *att = [[NSMutableAttributedString alloc] init];
                
                NSString *stepNum = SF(@"Step %ld :\t", row);
                NSString *stepContent = _fooddish.content[row - 1].step;
                
                [att appendAttributedString:[[NSAttributedString alloc] initWithString:stepNum attributes:@{NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Bold" size:13]}]];
                [att appendAttributedString:[[NSAttributedString alloc] initWithString:stepContent]];
                
                cell.lblSubTitle.attributedText = att;
            }
            
            return cell;
        }
        default: {
            cell = [tableView dequeueReusableCellWithIdentifier:@"IngredientRowCell"];
            cell.lblSubTitle.text = _fooddish.material;
            return cell;
        }
    }
    
    return cell;
}

#pragma mark - Action
- (IBAction)onBtnBackClicked:(UIButton *)btn {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - ScrollDeletage

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < 0) {
        [self collapHeaderWithContentOffSetPull:scrollView.contentOffset.y];
    } else {
        [self collapHeaderWithContentOffSetUpDown:scrollView.contentOffset.y];
    }
    
}

- (void)collapHeaderWithContentOffSetPull :(float)offset {
    float height = _vHeaderView.bounds.size.height;
    float scale = -(offset) / height + 1;
    float headerSizevariation = ((height * scale) - height)/2.0;
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0, headerSizevariation, 0);
    transform = CATransform3DScale(transform, scale ,scale, 0);
    _vHeaderView.layer.transform = transform;
}

- (void)collapHeaderWithContentOffSetUpDown :(float)offset {
    //    float height = _vHeaderView.bounds.size.height;
    //    float scale = -(offset) / height + 1;
    CATransform3D transform = CATransform3DIdentity;
    // Header -----------
    
    transform = CATransform3DTranslate(transform, 0, MAX(-offset_HeaderStop, -offset),0);
    
    _vHeaderView.layer.transform = transform;
    
    //  ------------ Label
    
    CATransform3D labelTransform = CATransform3DMakeTranslation(0, MAX(-distance_W_LabelHeader, offset_B_LabelHeader - offset), 0);
    _lblHeader.layer.transform = labelTransform;
    
    //ViewHeader eff
    _vEff.alpha = MIN(1.0, (offset - offset_B_LabelHeader)/distance_W_LabelHeader);
    
}

- (void)roundedConners:(UIRectCorner )corners withRadius:(CGFloat )radius for:(UIView *)view {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *mask = [[CAShapeLayer alloc] init];
    mask.path = path.CGPath;
    view.layer.mask = mask;
}

@end
