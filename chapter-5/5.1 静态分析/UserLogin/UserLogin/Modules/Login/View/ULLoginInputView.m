//
//  YouDataLoginInputView.m
//  YouData
//
//  Created by monkey on 2016/11/2.
//  Copyright © 2016年 netease. All rights reserved.
//

#import "ULLoginInputView.h"
#import "UIView+Frame.h"
#import "UIColor+ColorUtils.h"

@interface CDLoginInputView ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIImageView *iconImageView;

@end

@implementation CDLoginInputView

#pragma mark - Life cycle.
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    return self;
}

#pragma mark - Layout.

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _bgView.frame = self.bounds;
    
    _iconImageView.x = 15;
    _iconImageView.middleY = self.height / 2;
    _iconImageView.width = 25;
    _iconImageView.height = 25;
    
    _inputTextField.middleY = self.height / 2;
    _inputTextField.x = _iconImageView.x + 32;
    _inputTextField.width = 230;
    _inputTextField.height = 35;
}

-(void)setupSubViews{
    _bgView = [UIView new];
    _bgView.backgroundColor = [UIColor whiteColor];
    _bgView.layer.cornerRadius = 2.0;
    [self addSubview:_bgView];
    
    _iconImageView = [[UIImageView alloc] init];
    [self addSubview:_iconImageView];
    
    _inputTextField = [[UITextField alloc] init];
    _inputTextField.textAlignment = NSTextAlignmentLeft;
    _inputTextField.borderStyle = UITextBorderStyleNone;
    _inputTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _inputTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    _inputTextField.textColor = [UIColor colorWithRGBValue:0x4A4A4A];
    _inputTextField.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    _inputTextField.clearButtonMode = UITextFieldViewModeWhileEditing;

    [self addSubview:_inputTextField];
}

#pragma mark - Getter & Setter.

-(void)setBackGroundColor:(UIColor *)backGroundColor{
    if(_backGroundColor == backGroundColor){
        return;
    }
    
    _backGroundColor = backGroundColor;
    
    _bgView.backgroundColor = backGroundColor;
}

-(void)setBorderColor:(UIColor *)borderColor{
    if(_borderColor == borderColor){
        return;
    }
    
    _borderColor = borderColor;
    
    _bgView.layer.borderWidth = 0.5;
    _bgView.layer.borderColor = borderColor.CGColor;
}

-(void)setEnable:(BOOL)enable{
    _enable = enable;
    
    _inputTextField.enabled = enable;
}

- (void)setIconName:(NSString *)iconName {
    if (_iconName == iconName) {
        return;
    }
    _iconName = [iconName copy];
    
    _iconImageView.image = [UIImage imageNamed:_iconName];
}

- (void)setPlaceHolder:(NSString *)placeHolder {
    if (_placeHolder == placeHolder) {
        return;
    }
    _placeHolder = [placeHolder copy];
    
    _inputTextField.placeholder = _placeHolder;
    [_inputTextField setValue:[UIColor colorWithRGBValue:0x9B9B9B] forKeyPath:@"_placeholderLabel.textColor"];
}

- (void)setNeedSecurity:(BOOL)needSecurity {
    _needSecurity = needSecurity;
    
    _inputTextField.secureTextEntry = _needSecurity;
}

-(void)setInputText:(NSString *)inputText{
    if(inputText && inputText.length){
        _inputTextField.text = inputText;
    }
}

- (NSString *)inputText {
    return _inputTextField.text;
}

@end
