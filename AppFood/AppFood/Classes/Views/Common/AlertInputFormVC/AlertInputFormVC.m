//
//  AlertInputFormVC.m
//  Gito
//
//  Created by NguyenMach-MAC on 12/30/16.
//  Copyright © 2016 Horical. All rights reserved.
//

#import "AlertInputFormVC.h"
#import "HView.h"
#import "AppDelegate.h"
#import "define.h"
#import "BaseNV.h"

@interface AlertInputFormVC () <UITextFieldDelegate,AlertInputFormVCDelegate>{
    NSString *_strTf1, *_strTf2,*_strTf3;
    NSString *_strPlace1, *_strPlace2,*_strPlace3;
    NSString *_nameAction;
}



@end

@implementation AlertInputFormVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:0.5]];
    
    _tfInput1.delegate = self;
    _tfInput2.delegate = self;
    _tfInput3.delegate = self;
    _tfDecimalPad.delegate = self;
    
    [self initData];
    
}

- (void)initData {
    [_btnAction setTitle:_nameAction forState:UIControlStateNormal];
    
    _tfInput1.text = E(_strTf1);
    _tfInput2.text = E(_strTf2);
    _tfInput3.text = E(_strTf3);
    _tfDecimalPad.text = E(_strTf1);
    
    _tfInput1.placeholder = E(_strPlace1);
    _tfInput2.placeholder = E(_strPlace2);
    _tfInput3.placeholder = E(_strPlace3);
    _tfDecimalPad.placeholder = E(_strPlace1);
    
    switch (_type) {
            
        case INPUT_STYLE_EMAIL:
        case INPUT_STYLE_ONE:
        case INPUT_STYLE_ID:
        case INPUT_STYLE_NUMBER:
        case INPUT_STYLE_DECIMAL:
        case INPUT_STYLE_DOUBLE:
        case INPUT_STYLE_PERCENT:
        case INPUT_STYLE_1_10:
        case INPUT_STYLE_1_100:
        case INPUT_STYLE_NUMBER_PHONE:
        case INPUT_STYLE_BRANCH_NAME:
            case INPUT_STYLE_ACRONYM:

            
        {
            [self setStyleOneInput];
            break;
        }
            
        case INPUT_STYLE_TWO:
        case INPUT_STYLE_IP_ACCESS:
        {
            [self setStyleTwoInput];
            break;
        }
            
        default:
            break;
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    if(![_tfInput1 isFirstResponder]) {
        [_tfInput1 becomeFirstResponder];
    }
    [self registerKeyboardNotifications];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

    [self unregisterKeyboardNotifications];
}

- (void)setStyleDecimalPadInput {
    _conHVContent.constant = 130;
    _tfDecimalPad.hidden = YES;
    _tfInput1.keyboardType = UIKeyboardTypeDecimalPad;
    
    _tfInput1.hidden = NO;
    _vline1.hidden = NO;

    _tfInput2.hidden = YES;
    _tfInput3.hidden = YES;
    
    _vline2.hidden = YES;
    _vline3.hidden = YES;
}

- (void)setStyleOneInput {
    _conHVContent.constant = 130;
    
    _tfInput1.returnKeyType = UIReturnKeyDone;
    _tfDecimalPad.hidden = YES;
    
    _tfInput2.hidden = YES;
    _tfInput3.hidden = YES;
    
    _vline2.hidden = YES;
    _vline3.hidden = YES;
    
}

- (void)setStyleTwoInput {
    _conHVContent.constant = 180;
    
    _tfInput1.returnKeyType = UIReturnKeyNext;
    _tfInput2.returnKeyType = UIReturnKeyDone;
    _tfDecimalPad.hidden = YES;
    _tfInput3.hidden = YES;
    _vline3.hidden = YES;
    
}

- (void)setStyleThreeInput {
    _conHVContent.constant = 220;
    
    _tfInput1.returnKeyType = UIReturnKeyNext;
    _tfInput2.returnKeyType = UIReturnKeyNext;
    _tfInput3.returnKeyType = UIReturnKeyDone;
    _tfDecimalPad.hidden = YES;
}

- (void)setStyleThreeInputTextNumberText {
    [self setStyleThreeInput];
    _tfInput1.keyboardType = UIKeyboardTypeDefault;
    _tfInput2.keyboardType = UIKeyboardTypeNumberPad;
    _tfInput3.keyboardType = UIKeyboardTypeDefault;
}

- (void)setStyleChangePass {
    
    [self setStyleThreeInput];
    [_tfInput1 setSecureTextEntry:YES];
    [_tfInput2 setSecureTextEntry:YES];
    [_tfInput3 setSecureTextEntry:YES];
}

- (void)setStyleSecureTextEntry {
    _conHVContent.constant = 130;
    _tfInput1.secureTextEntry = YES;
    _tfInput1.returnKeyType = UIReturnKeyDone;
    
    _tfInput2.hidden = YES;
    _tfInput3.hidden = YES;
    
    _vline2.hidden = YES;
    _vline3.hidden = YES;
    
    _tfDecimalPad.hidden = YES;
}


- (void)setStyleTextNumber {
    _conHVContent.constant = 180;
    
    _tfInput1.returnKeyType = UIReturnKeyNext;
    _tfInput2.returnKeyType = UIReturnKeyDone;
    _tfInput2.keyboardType = UIKeyboardTypeNumberPad;
    
    _tfInput3.hidden = YES;
    _vline3.hidden = YES;
    
    _tfDecimalPad.hidden = YES;
}

- (void)setStyleNewSkill {
    _conHVContent.constant = 220;
    
    _tfInput3.returnKeyType = UIReturnKeyDone;
    _tfInput3.keyboardType = UIKeyboardTypeNumberPad;
    _tfInput1.returnKeyType = UIReturnKeyNext;
    _tfInput1.keyboardType = UIKeyboardTypeDefault;
    _tfInput2.returnKeyType = UIReturnKeyNext;
    _tfInput2.keyboardType = UIKeyboardTypeDefault;
   
    _tfDecimalPad.hidden = YES;
}

- (void)setStyleNumberPhone {
    _conHVContent.constant = 130;
    
    _tfInput1.returnKeyType = UIReturnKeyDone;
    _tfInput1.keyboardType = UIKeyboardTypePhonePad;
    _tfInput2.hidden = YES;
    _tfInput3.hidden = YES;
    
    _vline2.hidden = YES;
    _vline3.hidden = YES;

    _tfDecimalPad.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onbtnAdd:(UIButton*)btn {
    
    switch (_type) {
            
        case INPUT_STYLE_NEW_SKILL: {
            if ((_tfInput1.text.length == 0 || _tfInput2.text.length == 0 || _tfInput3.text.length) && ([_tfInput3.text integerValue] > 10 || [_tfInput3.text integerValue] < 0)) {
                return;
            }
            break;
        }
            
        case INPUT_STYLE_TEXT_NUMBER:
        {
            if ([_tfInput2.text integerValue] > 10 || [_tfInput2.text integerValue] == 0 ) {
                
                _vline1.backgroundColor = RED_COLOR;
                
                return;
            }
            break;
        }
            
        case INPUT_STYLE_1_10:{
            if ([_tfInput1.text integerValue] > 10 || [_tfInput1.text integerValue] == 0 ) {
            
                _vline1.backgroundColor = RED_COLOR;
                
                return;
            }
            break;
        }
            
        default:
            break;
    }
    
    if (_twoValueCallback) {
        if ([_tfInput1.text isEqualToString:@""] || [_tfInput2.text isEqualToString:@""]) {
            if ([_tfInput1.text isEqualToString: @""]) {
                _vline1.backgroundColor= RED_COLOR;
            } else if ([_tfInput2.text isEqualToString:@""]) {
                _vline2.backgroundColor= RED_COLOR;
            }
            
        } else {
            
            [self dismissViewControllerAnimated:YES completion:^{
                _twoValueCallback (_tfInput1.text,_tfInput2.text);
                _twoValueCallback = nil;
            }];
        }
    } else if (_oneValueCallback) {
        if ([_tfInput1.text isEqualToString:@""] ) {
            _vline1.backgroundColor = RED_COLOR;
            
        }else {
            [self dismissViewControllerAnimated:YES completion:^{
                _oneValueCallback(_tfInput1.text);
                _oneValueCallback = nil;
            }];
        }
        
    } else if (_threeValueCallback) {
        if ([_tfInput1.text isEqualToString:@""] || [_tfInput2.text isEqualToString:@""] ||
            [_tfInput3.text isEqualToString:@""]) {
            
            if ([_tfInput1.text isEqualToString: @""]) {
                _vline1.backgroundColor= RED_COLOR;
            } else if ([_tfInput2.text isEqualToString:@""]) {
                _vline2.backgroundColor= RED_COLOR;
            } else if ([_tfInput2.text isEqualToString:@""]) {
                _vline3.backgroundColor= RED_COLOR;
            }
            
        } else {
            [self dismissViewControllerAnimated:YES completion:^{
                _threeValueCallback(_tfInput1.text,_tfInput2.text,_tfInput3.text);
                _threeValueCallback = nil;
            }];
        }
    }
}

- (IBAction)onbtnCancel:(UIButton*)btn {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark -Show

+ (void)showAlertInputType:(InputStyle)type oldTexts:(NSArray<NSString*>*)oldTexts placeHolders:(NSArray<NSString*>*)placeHolder keyboardType:(UIKeyboardType)keyboard btnDoneTitle:(NSString*)name fromVC:(UIViewController*)fromVC callback:(id)callback{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        AlertInputFormVC *vc = VCFromSB(AlertInputFormVC, SB_Support);
        vc.keyboardType = keyboard;
        [vc setStyleDecimalPadInput];
        [vc setTypeCallBack:callback type:type];
        [vc setPlaceHolders:placeHolder arrOldTexts:oldTexts withNameAction:name];
        
        if (fromVC) {
            [fromVC presentViewController:vc animated:NO completion:nil];
            
        }else{
            [App.mainVC.navigationController presentViewController:vc animated:NO completion:nil];
        }
        
    });
    
}


//- (void)showAlertInputType:(InputStyle)type oldText:(NSString*)oldText placeHolder:(NSString*)placeHolder keyboardType:(UIKeyboardType)keyboard btnDoneTitle:(NSString*)name fromVC:(UIViewController*)fromVC callback:(AlertInputOneValueCallback)callback {
//     [AlertInputFormVC showAlertInputType:type oldTexts:@[E(oldText)] placeHolders:@[E(placeHolder)] keyboardType:keyboard btnDoneTitle:name fromVC:fromVC callback:callback];
//}

+ (void)showAlertInputType:(InputStyle)type oldText:(NSString*)oldText placeHolder:(NSString*)placeHolder keyboardType:(UIKeyboardType)keyboard btnDoneTitle:(NSString*)name fromVC:(UIViewController*)fromVC callback:(AlertInputOneValueCallback)callback{
    [AlertInputFormVC showAlertInputType:type oldTexts:@[E(oldText)] placeHolders:@[E(placeHolder)] keyboardType:keyboard btnDoneTitle:name fromVC:fromVC callback:callback];
    
}

+ (void)showAlertInputTwoFormWithPlaceHolders:(NSArray<NSString*>*)arrPlaceHolder arrOldTexts:(NSArray<NSString*>*)arrOlds nameAction:(NSString*)name fromVC:(UIViewController*)fromVC callback:(AlertInputTwoValueCallback)callback{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        AlertInputFormVC *vc = VCFromSB(AlertInputFormVC, SB_Support);
        vc.type = INPUT_STYLE_TWO;
        [vc setTwoValueCallback:callback];
        [vc setPlaceHolders:arrPlaceHolder arrOldTexts:arrOlds withNameAction:name];
        
        if (fromVC) {
            [fromVC presentViewController:vc animated:NO completion:nil];
        }else{
            [App.mainVC.navigationController presentViewController:vc animated:NO completion:nil];
        }
    });
    
}

+ (void)showAlertInputTwoFormWithPlaceHolders:(NSArray<NSString*>*)arrPlaceHolder arrOldTexts:(NSArray<NSString*>*)arrOlds keyboardType:(UIKeyboardType)keyboard  nameAction:(NSString*)name fromVC:(UIViewController*)fromVC callback:(AlertInputTwoValueCallback)callback {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        AlertInputFormVC *vc = VCFromSB(AlertInputFormVC, SB_Support);
        vc.type = INPUT_STYLE_TWO;
        [vc setTwoValueCallback:callback];
        vc.keyboardType = keyboard;
        
        [vc setPlaceHolders:arrPlaceHolder arrOldTexts:arrOlds withNameAction:name];
        
        if (fromVC) {
            [fromVC presentViewController:vc animated:NO completion:nil];
        }else{
            [App.mainVC.navigationController presentViewController:vc animated:NO completion:nil];
        }
    });
    
}


+ (void)showAlertInputOneForm:(NSString*)placeHolder oldText:(NSString*)oldText nameAction:(NSString*)name fromVC:(UIViewController*)fromVC callback:(AlertInputOneValueCallback)callback {

    dispatch_async(dispatch_get_main_queue(), ^{
        AlertInputFormVC *vc = VCFromSB(AlertInputFormVC, SB_Support);
        vc.type = INPUT_STYLE_ONE;
        [vc setOneValueCallback:callback];
        [vc setPlaceHolder:placeHolder oldText:oldText withActionName:name];
        
        if (fromVC) {
            [fromVC presentViewController:vc animated:NO completion:nil];
        }else{
            [App.mainVC.navigationController presentViewController:vc animated:NO completion:nil];
        }
    });
}

+ (void)showAlertInputOneForm:(NSString*)placeHolder withKeyboardType:(UIKeyboardType)keyboard oldText:(NSString*)oldText nameAction:(NSString*)name fromVC:(UIViewController*)fromVC callback:(AlertInputOneValueCallback)callback {
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        AlertInputFormVC *vc = VCFromSB(AlertInputFormVC, SB_Support);
        vc.type = INPUT_STYLE_ONE;
        vc.keyboardType = keyboard;
        [vc setOneValueCallback:callback];
        [vc setPlaceHolder:placeHolder oldText:oldText withActionName:name];
        
        if (fromVC) {
            [fromVC presentViewController:vc animated:NO completion:nil];
        }else{
            [App.mainVC.navigationController presentViewController:vc animated:NO completion:nil];
        }
    });
    
}

//+ (void)showAlertInputOneFormWithKeyboardTypeDecimalPad:(NSString*)placeHolder  oldText:(NSString*)oldText nameAction:(NSString*)name fromVC:(UIViewController*)fromVC callback:(AlertInputOneValueCallback)callback {
//    dispatch_async(dispatch_get_main_queue(), ^{
//        AlertInputFormVC *vc = VCFromSB(AlertInputFormVC, SB_Support);
//        vc.type = INPUT_STYLE_ONE;
//        vc.keyboardType = UIKeyboardTypeDecimalPad;
//        [vc setOneValueCallback:callback];
//        [vc setPlaceHolder:placeHolder oldText:oldText withActionName:name];
//        
//        if (fromVC) {
//            [fromVC presentViewController:vc animated:NO completion:nil];
//        }else{
//            [App.mainVC.contentNV presentViewController:vc animated:NO completion:nil];
//        }
//    });
//}


+ (void)showAlertInputChangePassword:(NSArray<NSString *> *)arrPlaceHolder arrOldTexts:(NSArray<NSString *> *)arrOlds nameAction:(NSString *)name fromVC:(UIViewController *)fromVC callback:(AlertInputThreeValueCallback)callback {
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        AlertInputFormVC *vc = VCFromSB(AlertInputFormVC, SB_Support);
        vc.type = INPUT_STYLE_CHANGE_PASS;
        
        [vc setThreeValueCallback:callback];
        [vc setPlaceHolders:arrPlaceHolder arrOldTexts:arrOlds withNameAction:name];
        
        if (fromVC) {
            [fromVC presentViewController:vc animated:NO completion:nil];
        }else{
            [App.mainVC.navigationController presentViewController:vc animated:NO completion:nil];
        }
    });
    
}

+ (void)showAlertInputThreeFormWithStyle:(InputStyle)style placeHolders:(NSArray<NSString *> *)arrPlaceHolder arrOldTexts:(NSArray<NSString *> *)arrOlds nameAction:(NSString *)name fromVC:(UIViewController *)fromVC callback:(AlertInputThreeValueCallback)callback {
    dispatch_async(dispatch_get_main_queue(), ^{
        AlertInputFormVC *vc = VCFromSB(AlertInputFormVC, SB_Support);
        vc.type = style;
        
        [vc setThreeValueCallback:callback];
        [vc setPlaceHolders:arrPlaceHolder arrOldTexts:arrOlds withNameAction:name];
        
        if (fromVC) {
            [fromVC presentViewController:vc animated:NO completion:nil];
        }else{
            [App.mainVC.navigationController presentViewController:vc animated:NO completion:nil];
        }
    });
}

- (void)setPlaceHolders:(NSArray<NSString*>*)arrPlaceholders arrOldTexts:(NSArray<NSString*>*)arrOldTexts withNameAction:(NSString*)name{
    
    _nameAction = name;
    
    switch (arrPlaceholders.count) {
        case 1:
            _strPlace1 = arrPlaceholders[0];
            
            break;
            
        case 2: {
            _strPlace1 = arrPlaceholders[0];
            _strPlace2 = arrPlaceholders[1];
            
        }
            
            break;
        case 3:{
            _strPlace1 = arrPlaceholders[0];
            _strPlace2 = arrPlaceholders[1];
            _strPlace3 = arrPlaceholders[2];
            
        }
            
            
            break;
            
        default:
            break;
    }
    
    switch (arrOldTexts.count) {
        case 1:
            _strTf1 = arrOldTexts[0];
            
            break;
            
        case 2:
            _strTf1 = arrOldTexts[0];
            _strTf2 = arrOldTexts[1];
            
            break;
        case 3:
            _strTf1 = arrOldTexts[0];
            _strTf2 = arrOldTexts[1];
            _strTf3 = arrOldTexts[2];
            
            break;
            
        default:
            break;
    }
}


- (void)setPlaceHolder:(NSString*)placeholder oldText:(NSString*)oldText withActionName:(NSString*)name{
    _nameAction = name;
    if (placeholder) {
        _strPlace1 = placeholder;
    }
    
    if (oldText) {
        _strTf1 = oldText;
    }
}

- (void)setOneValueCallback:(AlertInputOneValueCallback)callback {
    _oneValueCallback = [callback copy];
}

- (void)setTwoValueCallback:(AlertInputTwoValueCallback)callback {
    _twoValueCallback = [callback copy];
}

- (void)setThreeValueCallback:(AlertInputThreeValueCallback)callback {
    _threeValueCallback = [callback copy];
}

- (void)setTypeCallBack:(id)callback type:(InputStyle)type{
    
    _type = type;
    switch (_type) {
            
        case INPUT_STYLE_ONE:
        case INPUT_STYLE_CHANGE_PASS:
        case INPUT_STYLE_ID:
        case INPUT_STYLE_PASS:
        case INPUT_STYLE_EMAIL:
        case INPUT_STYLE_DOUBLE:
        case INPUT_STYLE_DECIMAL:
        case INPUT_STYLE_PERCENT:
        case INPUT_STYLE_NUMBER:
        case INPUT_STYLE_1_10:
        case INPUT_STYLE_1_100:
        case INPUT_STYLE_NUMBER_PHONE:
        case INPUT_STYLE_NUMBER_DECIMAL:
        case INPUT_STYLE_BRANCH_NAME:
            case INPUT_STYLE_ACRONYM:

        {
            _oneValueCallback = [callback copy];
            break;
        }
            
        case INPUT_STYLE_TWO:
        case INPUT_STYLE_PERCENT_FROM_TO:
        case INPUT_STYLE_IP_ACCESS:
        case INPUT_STYLE_TEXT_NUMBER:
            
        {
            _twoValueCallback = [callback copy];
            break;
        }
            
        case INPUT_STYLE_THREE:
        case INPUT_STYLE_THREE_TEXT_NUMBER_TEXT:
        case INPUT_STYLE_NEW_SKILL:
        {
            _threeValueCallback = [callback copy];
            break;
        }
            
        default:
            break;
    }
}


#pragma mark -TextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (textField ==_tfInput1) {
        [self setBackgroudDefForVline];
        [_vline1 setBackgroudVHeader];
        
    } else if (textField == _tfInput2) {
        [self setBackgroudDefForVline];
        [_vline2 setBackgroudVHeader];
        
    } else if (textField == _tfInput3) {
        [self setBackgroudDefForVline];
        [_vline3 setBackgroudVHeader];
    }
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    switch (_type) {
           
            
        case INPUT_STYLE_NUMBER_PHONE: {
            NSString *str = [textField.text stringByReplacingCharactersInRange:range withString:string];
            
            if (str.length > 0) {
                
                if ([self validNumberPhone:str]) {
                    return YES;
                    
                }else{
                    _vline1.backgroundColor = RED_COLOR;
                    return NO;
                }
                
            }else{
                [self setBackgroudDefForVline];
            }
            
            break;

        }
        case INPUT_STYLE_NUMBER_DECIMAL: {
            NSString *content = textField.text;
            
            if ([string isEqualToString:@"."]) {
                if (content.length >= 1) {
                    NSArray *arr = [content componentsSeparatedByString:@"."];
                    if (arr.count <= 1) {
                        return YES;
                    } else {
                        return NO;
                    }
                } else if (content.length == 0) {
                    return NO;
                }
            } else if ([string isEqualToString:@"-"] && content.length == 0) {
                return YES;
            } else if ([string isEqualToString:@"-"] && content.length != 0) {
                return NO;
            }
            return YES;
            break;
        }
            
            //TODO: INPUT_STYLE_ID
        case INPUT_STYLE_BRANCH_NAME:
        {
            NSString *str = [textField.text stringByReplacingCharactersInRange:range withString:string];
            
            if (str.length > 0) {
                
                if ([self validBranchName:str]) {
                    _vline1.backgroundColor = MAINCOLOR;
                    return YES;
                    
                }else{
                    _vline1.backgroundColor = RED_COLOR;
                    return NO;
                }
                
            }else{
                [self setBackgroudDefForVline];
            }
            
            break;
        }
            
        default:
            break;
    }
    
    if (textField ==_tfInput1) {
        [self setBackgroudDefForVline];
        [_vline1 setBackgroudVHeader];
        
    } else if (textField == _tfInput2) {
        [self setBackgroudDefForVline];
        [_vline2 setBackgroudVHeader];
        
    } else if (textField == _tfInput3) {
        [self setBackgroudDefForVline];
        [_vline3 setBackgroudVHeader];
    }
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    switch (_type) {
            
        case INPUT_STYLE_ONE:
        case INPUT_STYLE_NUMBER:
        case INPUT_STYLE_ID:
        case INPUT_STYLE_PASS:
        case INPUT_STYLE_EMAIL:
        case INPUT_STYLE_1_10:
        case INPUT_STYLE_1_100:
        case INPUT_STYLE_NUMBER_DECIMAL:
        case INPUT_STYLE_BRANCH_NAME:
            case INPUT_STYLE_ACRONYM:

        {
            [textField resignFirstResponder];
            [self onbtnAdd:_btnAction];
            break;
        }
            
        case INPUT_STYLE_PERCENT_FROM_TO:
        case INPUT_STYLE_TWO:
        case INPUT_STYLE_IP_ACCESS:
        case INPUT_STYLE_TEXT_NUMBER:
            
        {
            [_tfInput2 becomeFirstResponder];
            
            if (textField == _tfInput2) {
                [textField resignFirstResponder];
                [self onbtnAdd:_btnAction];
            }
            break;
        }
            
        case INPUT_STYLE_THREE:
        case INPUT_STYLE_THREE_TEXT_NUMBER_TEXT:
        case INPUT_STYLE_NEW_SKILL:
        {
            if (textField == _tfInput3) {
                [textField resignFirstResponder];
                [self onbtnAdd:_btnAction];
                
            } else {
                if (textField == _tfInput1) {
                    [_tfInput2 becomeFirstResponder];
                    
                } else if (textField == _tfInput2) {
                    [_tfInput3 becomeFirstResponder];
                    
                }
            }
            break;
        }
            
        case INPUT_STYLE_CHANGE_PASS:
        {
            if (textField == _tfInput3) {
                if ([_tfInput2.text isEqualToString:_tfInput3.text]) {
                    [textField resignFirstResponder];
                    [self onbtnAdd:_btnAction];
                }
                
            } else {
                if (textField == _tfInput1) {
                    [_tfInput2 becomeFirstResponder];
                    
                } else if (textField == _tfInput2) {
                    [_tfInput3 becomeFirstResponder];
                    
                }
            }
            break;
        }
            
        default:
            break;
    }
    
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    switch (_type) {
        case INPUT_STYLE_TEXT_NUMBER:
        {
            if (textField == _tfInput1) {
                textField.keyboardType = UIKeyboardTypeDefault;
                
            }else if (textField == _tfInput2) {
                textField.keyboardType = UIKeyboardTypeNumberPad;
            }
            break;
        }
        case INPUT_STYLE_THREE_TEXT_NUMBER_TEXT:
        {
            if (textField == _tfInput1) {
                textField.keyboardType = UIKeyboardTypeDefault;
                
            }else if (textField == _tfInput2) {
                textField.keyboardType = UIKeyboardTypeNumberPad;
            }else if (textField == _tfInput3) {
                textField.keyboardType = UIKeyboardTypeDefault;
            }
            break;
        }
            
           
        case INPUT_STYLE_NEW_SKILL: {
            if (textField == _tfInput3) {
                textField.keyboardType = UIKeyboardTypeNumberPad;
            } else {
                textField.keyboardType = UIKeyboardTypeDefault;
            }
            
           break;
        }
            
            
        case INPUT_STYLE_NUMBER_DECIMAL: {
            textField.keyboardType = UIKeyboardTypeDecimalPad;
            break;
        }
            
        default:
            
            textField.keyboardType = _keyboardType;
            
            break;
    }
    textField.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    return YES;
}



- (void)setBackgroudDefForVline {
    [_vline1 setBackgroudLightGray];
    [_vline2 setBackgroudLightGray];
    [_vline3 setBackgroudLightGray];
    
}

#pragma mark - Keyboard

- (void) registerKeyboardNotifications {
    NSNotificationCenter * noti = [NSNotificationCenter defaultCenter];
    [noti addObserver:self
             selector:@selector(keyboardWasShown:)
                 name:UIKeyboardWillShowNotification object:nil];
    
    [noti addObserver:self
             selector:@selector(keyboardWillBeHidden:)
                 name:UIKeyboardWillHideNotification object:nil];
    
    [noti addObserver:self
             selector:@selector(keyboardWillChangeFrame:)
                 name:UIKeyboardWillChangeFrameNotification
               object:nil];
    
}

- (void) unregisterKeyboardNotifications {
    NSNotificationCenter * noti = [NSNotificationCenter defaultCenter];
    [noti removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [noti removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [noti removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (CGFloat) getKeyboardHeight:(NSNotification *)noti {
    NSDictionary *userInfo = [noti userInfo];
    CGFloat h = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    return h;
}

- (void)keyboardWillChangeFrame:(NSNotification *)noti {
    CGFloat kbHeight = [self getKeyboardHeight:noti];
    _conbuttomContent.constant = kbHeight + 10;
    [self.view layoutIfNeeded];
    [self.view updateConstraintsIfNeeded];
    
}

- (void)keyboardWasShown:(NSNotification*)aNotification {
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
}

- (BOOL)validNumberPhone:(NSString*)phone {
    NSString *phoneRegex = @"[0-9+-]{1,}";
    NSPredicate *predict = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [predict evaluateWithObject: phone];
}

- (BOOL)validBranchName:(NSString *)name{
    if(isEmpty(name)) {
        return NO;
    }
    
    NSString *regex = @"[a-z0-9A-Z_ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽềềểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ-]{1,}";
    NSPredicate *predict = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predict evaluateWithObject:name];
}

@end
