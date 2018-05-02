//
//  AlertInputFormVC.h
//  Gito
//
//  Created by NguyenMach-MAC on 12/30/16.
//  Copyright © 2016 Horical. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HView;
@class DecimalKeyboard;

typedef enum : NSUInteger {
    INPUT_STYLE_ONE = 0,
    INPUT_STYLE_BRANCH_NAME,
    INPUT_STYLE_TWO,
    INPUT_STYLE_THREE,
    INPUT_STYLE_THREE_TEXT_NUMBER_TEXT,
    INPUT_STYLE_WEIGHT,
    INPUT_STYLE_CHANGE_PASS,
    INPUT_STYLE_ID,
    INPUT_STYLE_PASS,
    INPUT_STYLE_EMAIL,
    INPUT_STYLE_DOUBLE,
    INPUT_STYLE_DECIMAL,
    INPUT_STYLE_PERCENT,
    INPUT_STYLE_NUMBER,
    INPUT_STYLE_PERCENT_FROM_TO,
    INPUT_STYLE_IP_ACCESS,
    INPUT_STYLE_NEW_SKILL,
    INPUT_STYLE_TEXT_NUMBER,
    INPUT_STYLE_1_10,
    INPUT_STYLE_1_100,
    INPUT_STYLE_NUMBER_PHONE,
    INPUT_STYLE_NUMBER_DECIMAL,
    INPUT_STYLE_ACRONYM
} InputStyle;


@protocol AlertInputFormVCDelegate <NSObject>

@optional
- (void)inputIsChangingCharacter:(UITextField*)textField string:(NSString*)content;

@required
- (void)onTapBtnDoneInPopUpContentCallback:(NSString*)content isFromRangeValue:(BOOL)isFromRangeValue;
- (void)onTapBtnDoneKeyboardDecimalContentCallback:(NSString*)content isFromRangeValue:(BOOL)isFromRangeValue;

@end


@interface AlertInputFormVC : UIViewController

typedef void (^AlertInputOneValueCallback)(NSString *content);
typedef void (^AlertInputTwoValueCallback)(NSString *str1, NSString *str2);
typedef void (^AlertInputThreeValueCallback)(NSString *str1, NSString *str2,NSString *str3);

@property (nonatomic, strong) AlertInputOneValueCallback oneValueCallback;
@property (nonatomic, strong) AlertInputTwoValueCallback twoValueCallback;
@property (nonatomic, strong) AlertInputThreeValueCallback threeValueCallback;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *conHVContent;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *conbuttomContent;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *conHTfInput2;

@property (nonatomic, weak) IBOutlet UIButton *btnAction;

@property (nonatomic, weak) IBOutlet HView *vContent;
@property (nonatomic, weak) IBOutlet HView *vline1;
@property (nonatomic, weak) IBOutlet HView *vline2;
@property (nonatomic, weak) IBOutlet HView *vline3;

@property (nonatomic, weak) IBOutlet UITextField *tfInput1;
@property (nonatomic, weak) IBOutlet UITextField *tfInput2;
@property (nonatomic, weak) IBOutlet UITextField *tfInput3;
@property (weak, nonatomic) IBOutlet UITextField *tfDecimalPad;


@property (nonatomic, assign) InputStyle type;
@property (nonatomic, assign) UIKeyboardType keyboardType;

@property (assign, nonatomic) BOOL isFromRangeValue; // Only for INPUT_STYLE_DECIMAL

@property (strong, nonatomic) id<AlertInputFormVCDelegate>delegate;



+ (void)showAlertInputThreeFormWithStyle:(InputStyle)style placeHolders:(NSArray<NSString *> *)arrPlaceHolder arrOldTexts:(NSArray<NSString *> *)arrOlds nameAction:(NSString *)name fromVC:(UIViewController *)fromVC callback:(AlertInputThreeValueCallback)callback;

+ (void)showAlertInputChangePassword:(NSArray<NSString *> *)arrPlaceHolder arrOldTexts:(NSArray<NSString *> *)arrOlds nameAction:(NSString*)name fromVC:(UIViewController *)fromVC callback:(AlertInputThreeValueCallback)callback;

+ (void)showAlertInputTwoFormWithPlaceHolders:(NSArray<NSString*>*)arrPlaceHolder arrOldTexts:(NSArray<NSString*>*)arrOlds nameAction:(NSString*)name fromVC:(UIViewController*)fromVC callback:(AlertInputTwoValueCallback)callback;

+ (void)showAlertInputThreeFormWithPlaceHolders:(NSArray<NSString *> *)arrPlaceHolder arrOldTexts:(NSArray<NSString *> *)arrOlds nameAction:(NSString*)name fromVC:(UIViewController *)fromVC callback:(AlertInputThreeValueCallback)callback;

+ (void)showAlertInputOneForm:(NSString*)placeHolder oldText:(NSString*)oldText nameAction:(NSString*)name fromVC:(UIViewController*)fromVC callback:(AlertInputOneValueCallback)callback;

+ (void)showAlertInputOneForm:(NSString*)placeHolder withKeyboardType:(UIKeyboardType)keyboard oldText:(NSString*)oldText nameAction:(NSString*)name fromVC:(UIViewController*)fromVC callback:(AlertInputOneValueCallback)callback;

+ (void)showAlertInputOneFormWithKeyboardTypeDecimalPad:(NSString*)placeHolder  oldText:(NSString*)oldText nameAction:(NSString*)name fromVC:(UIViewController*)fromVC callback:(AlertInputOneValueCallback)callback;

//TYPE
+ (void)showAlertInputType:(InputStyle)type oldText:(NSString*)oldText placeHolder:(NSString*)placeHolder keyboardType:(UIKeyboardType)keyboard btnDoneTitle:(NSString*)name fromVC:(UIViewController*)fromVC callback:(AlertInputOneValueCallback)callback;

+ (void)showAlertInputType:(InputStyle)type oldTexts:(NSArray<NSString*>*)oldTexts placeHolders:(NSArray<NSString*>*)placeHolder keyboardType:(UIKeyboardType)keyboard btnDoneTitle:(NSString*)name fromVC:(UIViewController*)fromVC callback:(id)callback;

+ (void)showAlertInputTwoFormWithPlaceHolders:(NSArray<NSString*>*)arrPlaceHolder arrOldTexts:(NSArray<NSString*>*)arrOlds keyboardType:(UIKeyboardType)keyboard  nameAction:(NSString*)name fromVC:(UIViewController*)fromVC callback:(AlertInputTwoValueCallback)callback;




- (void)setPlaceHolders:(NSArray<NSString*>*)arrPlaceholders arrOldTexts:(NSArray<NSString*>*)arrOldTexts withNameAction:(NSString*)name;

- (void)setTypeCallBack:(id)callback type:(InputStyle)type;

- (void)setStyleDecimalPadInput;

- (void)showAlertInputType:(InputStyle)type oldText:(NSString*)oldText placeHolder:(NSString*)placeHolder keyboardType:(UIKeyboardType)keyboard btnDoneTitle:(NSString*)name fromVC:(UIViewController*)fromVC callback:(AlertInputOneValueCallback)callback;

@end
