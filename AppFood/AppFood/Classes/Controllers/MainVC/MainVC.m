//
//  MainVC.m
//  AppFood
//
//  Created by ThanhSon on 3/8/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "MainVC.h"

@interface MainVC () <UIGestureRecognizerDelegate> {
    UILongPressGestureRecognizer *_dragGesture;
    CGFloat _originDragX;
    CGFloat _originLeftX;
}

@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showPanel:NO animation:NO];
    // Do any additional setup after loading the view.
    [self initLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initLayout {
    BaseVC *vc = VCFromSB(DishTypeListVC,@"ListFood");
    [App.mainVC showPanel:NO animation:NO];
    [App.mainVC.contentNV setViewControllers:@[vc] animated:NO];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"Main_Menu"]) {
        _menuVC = segue.destinationViewController;
    } else {
        _contentNV = segue.destinationViewController;
    }
}

- (void)showMenu {
    [self showPanel:_conLeftPanel.constant == 0 ? NO : YES animation:YES];
    [_menuVC.tbvMenu reloadData];
}

#pragma mark - Show/Hide Menu

#pragma mark - Show/Hide Panel
- (IBAction)hidePannel{
    [self showPanel:NO];
}

- (void)showPanel:(BOOL)isShow {
    [self showPanel:isShow animation:YES];
}

- (void)showPanel:(BOOL)isShow animation:(BOOL)animation {
    
    _conLeftPanel.constant = isShow ? 0 : -MAX(SWIDTH, SHEIGHT);
    if(animation) {
        [UIView animateWithDuration:0.35 animations:^{
            [self.view layoutIfNeeded];
            _vMask.alpha = (isShow ? 1 : 0);
        } completion:^(BOOL finished) {
            if(finished) {
                _vMask.hidden = !isShow;
            }
        }];
        
    } else {
        [self.view layoutIfNeeded];
    }
    
    if(isShow) {
        _vMask.hidden = NO;
        
    }else{
        _vMask.hidden = YES;
    }
}

#pragma mark - Gesture
- (void) onDragEvent:(UILongPressGestureRecognizer*)gesture {
    
    NSInteger state = gesture.state;
    CGPoint p = [gesture locationInView:gesture.view];
    CGFloat width = _vLeftPanel.frame.size.width;
    
    if(state == UIGestureRecognizerStateBegan) {
        _originDragX = p.x;
        _originLeftX = _conLeftPanel.constant;
        _vMask.hidden = NO;
        [UIView animateWithDuration:0.18 animations:^{
            _vMask.alpha = 1.0;
        }];
        
    } else if(state == UIGestureRecognizerStateChanged) {
        CGFloat delta = p.x - _originDragX;
        
        // [-width, 0]
        CGFloat newX = _originLeftX + delta;
        newX = MAX(-width, MIN(0, newX));
        _conLeftPanel.constant = newX;
        [self.view layoutIfNeeded];
        
    } else if(state == UIGestureRecognizerStateEnded ||
              state == UIGestureRecognizerStateFailed ||
              state == UIGestureRecognizerStateCancelled) {
        BOOL needShowing = (_conLeftPanel.constant > -width/2.0);
        [self showPanel:needShowing];
    }
}

    
@end
