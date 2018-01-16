//
//  YouDataLoginInputView.h
//  YouData
//
//  Created by monkey on 2016/11/2.
//  Copyright © 2016年 netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDLoginInputView : UIButton

@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, copy) NSString *placeHolder;
@property (nonatomic, assign) BOOL needSecurity;
@property (nonatomic, assign) BOOL enable;
@property (nonatomic, copy) NSString *inputText;
@property (nonatomic, strong) UITextField *inputTextField;
@property (nonatomic, strong) UIColor *backGroundColor;
@property (nonatomic, strong) UIColor *borderColor;

@end
