//
//  DetailDishVC.m
//  AppFood
//
//  Created by ThanhSon on 3/9/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "DetailDishVC.h"
#import "DetailDishCell.h"


typedef enum : NSUInteger {
    Youtube = 0,
    Desc,
    Material,
    Step,
} Section;

@interface DetailDishVC () <UITableViewDataSource, UITableViewDelegate, UIWebViewDelegate> {
    
    NSArray *arrTitle;
    NSArray *arrIcon;
    
}

@end

@implementation DetailDishVC

- (void)viewDidLoad
{
    _label.text = _fooddish.name;
    [super viewDidLoad];
    
    [self initHeader];
    [self initVar];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)initVar {
    arrTitle = @[@"Video", @"Description", @"Material", @"Step"];
    arrIcon = @[@"youtube", @"description", @"material", @"step"];
    if (!_fooddish) {
        _fooddish = [[DetailDishDto alloc] init];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void) initHeader {
    [self.headerView setDelegate:self];
    [self.headerView setCollapsingConstraint:_headerHeight];
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: _fooddish.image]];
        if ( data == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            // WARNING: is the cell still using the same data by this point??
            _headerImageView.image = [UIImage imageWithData: data];
        });
    });
    //    [self.headerView setCollapsingConstraint:_headerTop];
    //    [self.headerView setCollapsingConstraint:_tableViewTop];
    
    [self.headerView addFadingSubview:self.button1 fadeBy:0.3];
    [self.headerView addFadingSubview:self.button2 fadeBy:0.3];
    [self.headerView addFadingSubview:self.button3 fadeBy:0.3];
    
    NSArray *attrs;
    double r = 16.0;
    attrs    = @[
                 [MGTransform transformAttribute:MGAttributeX byValue:-r],
                 [MGTransform transformAttribute:MGAttributeY byValue:-r],
                 [MGTransform transformAttribute:MGAttributeWidth byValue:2 * r],
                 [MGTransform transformAttribute:MGAttributeHeight byValue:2 * r],
                 [MGTransform transformAttribute:MGAttributeCornerRadius byValue:r],
                 [MGTransform transformAttribute:MGAttributeFontSize byValue:12.0]
                 ];
    [self.headerView addTransformingSubview:self.button4 attributes:attrs];
    
    // Push this button closer to the bottom-right corner since the header view's height
    // is resizing.
    attrs = @[
              [MGTransform transformAttribute:MGAttributeX byValue:10.0],
              [MGTransform transformAttribute:MGAttributeY byValue:13.0],
              [MGTransform transformAttribute:MGAttributeWidth byValue:-32.0],
              [MGTransform transformAttribute:MGAttributeHeight byValue:-32.0]
              ];
    [self.headerView addTransformingSubview:self.button5 attributes:attrs];
    
    attrs = @[
              [MGTransform transformAttribute:MGAttributeY byValue:-30.0],
              [MGTransform transformAttribute:MGAttributeWidth byValue:-30.0],
              [MGTransform transformAttribute:MGAttributeHeight byValue:-20.0],
              [MGTransform transformAttribute:MGAttributeFontSize byValue:-10.]
              ];
    [self.headerView addTransformingSubview:self.label attributes:attrs];
}

#pragma mark -
#pragma mark Tableview data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return arrTitle.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case Step:
            return _fooddish.content.count;
        case Material:
            return _fooddish.materials.count;
            break;
        default:
            return 1;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    switch (section) {
        case Youtube:
            return 250;
            break;
        case Desc:
            return 150;
            break;
            
        default:
            return UITableViewAutomaticDimension;
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    DetailDishCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailDishHeaderCell"];
    cell.lblTitle.text = arrTitle[section];
    cell.imageIcon.image = [UIImage imageNamed:arrIcon[section]];
    
    return cell;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    DetailDishCell *cell;
    switch (section) {
        case Youtube: {
            cell = [tableView dequeueReusableCellWithIdentifier:@"DetailDishYoutubeCell"];
            cell.wvYoutube.allowsInlineMediaPlayback = YES;
            cell.wvYoutube.delegate = self;
            cell.wvYoutube.mediaPlaybackRequiresUserAction = NO;
            cell.wvYoutube.mediaPlaybackAllowsAirPlay = YES;
            cell.wvYoutube.scrollView.bounces = NO;
            
            NSString *linkUrl = _fooddish.youtube;
            NSString *embemdHTML = SF(@"<iframe width=""%f"" height=""%f"" src=""%@"" frameborder=""0"" allow=""autoplay; encrypted-media"" allowfullscreen></iframe>",cell.wvYoutube.frame.size.width, cell.wvYoutube.frame.size.height, linkUrl);
            [cell.wvYoutube loadHTMLString:embemdHTML baseURL:nil];
            cell.backgroundColor = [UIColor darkGrayColor];
            
            return cell;
        }
        case Desc: {
            cell = [tableView dequeueReusableCellWithIdentifier:@"DetailDishDescCell"];
            cell.lblSubTitle.text = _fooddish.decriptions;
            return cell;
        }
        case Material: {
            cell = [tableView dequeueReusableCellWithIdentifier:@"DetailDishMaterialCell"];
            
            if (row == 0) {
                cell.lblMaterial.text = @"Material";
                cell.lblAmount.text = @"Amount";
                cell.lblMaterial.textAlignment = NSTextAlignmentCenter;
                cell.lblAmount.textAlignment = NSTextAlignmentCenter;
                cell.lblAmount.font = [UIFont fontWithName:@"Helvetica Bold Oblique" size:14];
                cell.lblMaterial.font = [UIFont fontWithName:@"Helvetica Bold Oblique" size:14];

            } else {
                cell.lblMaterial.text = _fooddish.materials[row - 1].material;
                cell.lblAmount.text = _fooddish.materials[row - 1].amount;
                cell.lblAmount.textAlignment = NSTextAlignmentRight;
                cell.lblAmount.font = [UIFont fontWithName:@"Helvetica" size:14];
                cell.lblMaterial.font = [UIFont fontWithName:@"Helvetica" size:14];
                cell.lblMaterial.textAlignment = NSTextAlignmentLeft;
            }
            return cell;
        }
        default: {
            cell = [tableView dequeueReusableCellWithIdentifier:@"DetailDishDescCell"];
            cell.lblSubTitle.text = _fooddish.material;
            return cell;
        }
    }
    
    return cell;
}

#pragma mark -
#pragma mark Scroll View Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.headerView collapseWithScroll:scrollView];
    
    NSLog(@"V:|-(%.2f)-header(%.2f)-(%.2f)-|",
          _headerTop.constant,
          _headerHeight.constant,
          _tableViewTop.constant);
}

- (IBAction)btnDismisDetail:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark Collapsing Header Delegate

- (void)headerDidCollapseToOffset:(double)offset
{
    NSLog(@"collapse %.4f", offset);
}
- (void)headerDidFinishCollapsing
{
    NSLog(@"collapsed!!!");
}
- (void)headerDidExpandToOffset:(double)offset
{
    NSLog(@"expand %.4f", offset);
}
- (void)headerDidFinishExpanding
{
    NSLog(@"expanded!!!");
}
@end
