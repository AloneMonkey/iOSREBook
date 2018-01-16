//
//  ULLoginViewController.m
//  UserLogin
//
//  Created by monkey on 2017/7/22.
//  Copyright © 2017年 Coder. All rights reserved.
//

#import "ULLoginViewController.h"
#import "ULLoginInputView.h"
#import "UIColor+ColorUtils.h"
#import "UIView+Frame.h"
#import "ULColor.h"
#import "ULLoginManager.h"

@interface ULLoginViewController ()

@property (nonatomic, strong) CDLoginInputView* userNameInputView;
@property (nonatomic, strong) CDLoginInputView* passWordInputView;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *getLoginButton;
@property (nonatomic, strong) UIButton *postLoginButton;
@property (nonatomic, strong) UIActivityIndicatorView *loginLoadingIcon;

@end

@implementation ULLoginViewController

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setViews];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [_loginButton setTitle:@"SOCKET" forState:UIControlStateNormal];
    
    if(_userNameInputView.inputText && _userNameInputView.inputText.length > 0){
        [_passWordInputView becomeFirstResponder];
    }else{
        [_userNameInputView becomeFirstResponder];
    }
    
    if(_userNameInputView.inputText && _userNameInputView.inputText && _passWordInputView.inputText && _passWordInputView.inputText.length){
        [_loginButton setAlpha:1];
        [_loginButton setEnabled:YES];
        _loginButton.backgroundColor = ULColorLoginButtonEnable;
    }
    
    if(_userNameInputView.inputText.length == 0 || _passWordInputView.inputText.length == 0){
        _loginButton.backgroundColor = ULColorLoginButtonDisable;
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    _userNameInputView.middleX = self.view.width / 2;
    _userNameInputView.width = 285;
    _userNameInputView.height = 45;
    _userNameInputView.y = 160;
    
    _passWordInputView.middleX = _userNameInputView.middleX;
    _passWordInputView.width = _userNameInputView.width;
    _passWordInputView.height = _userNameInputView.height;
    _passWordInputView.y = _userNameInputView.bottom + 10;
    
    _loginLoadingIcon.middleY = _loginButton.middleY;
    _loginLoadingIcon.x = _loginButton.middleX - 65;
    _loginLoadingIcon.size = CGSizeMake(19, 19);
    
    _getLoginButton.x = _passWordInputView.x;
    _getLoginButton.y = _passWordInputView.bottom + 17;
    _getLoginButton.width = (_passWordInputView.width - 20) / 2;
    _getLoginButton.height = _passWordInputView.height;
    
    _postLoginButton.x = _getLoginButton.tail + 20;
    _postLoginButton.y = _passWordInputView.bottom + 17;
    _postLoginButton.width = (_passWordInputView.width - 20) / 2;
    _postLoginButton.height = _passWordInputView.height;
    
    _loginButton.x = _passWordInputView.x;
    _loginButton.y = _getLoginButton.bottom + 20;
    _loginButton.width = _passWordInputView.width;
    _loginButton.height = _passWordInputView.height;
}

#pragma mark - Set up
-(void)setViews{
    //账号
    _userNameInputView = [CDLoginInputView new];
    _userNameInputView.iconName = @"login_accounticon";
    _userNameInputView.placeHolder = @"用户名";
    _userNameInputView.inputTextField.keyboardType = UIKeyboardTypeEmailAddress;
    [self.view addSubview:_userNameInputView];
    
    //密码
    _passWordInputView = [CDLoginInputView new];
    _passWordInputView.iconName = @"login_passwdicon";
    _passWordInputView.placeHolder = @"密码";
    _passWordInputView.needSecurity = YES;
    [self.view addSubview:_passWordInputView];
    
    //登录按钮
    _loginButton = [[UIButton alloc] init];
    [_loginButton setBackgroundColor:ULColorLoginButtonDisable];
    [_loginButton.layer setCornerRadius:2.0];
    [_loginButton setTitle:@"SOCKET" forState:UIControlStateNormal];
    [_loginButton setEnabled:NO];
    [_loginButton setAdjustsImageWhenHighlighted:NO];
    [_loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginButton];
    
    //登录加载中icon
    _loginLoadingIcon = [UIActivityIndicatorView new];
    _loginLoadingIcon.hidden = YES;
    [self.view addSubview:_loginLoadingIcon];
    
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap)];
    [self.view addGestureRecognizer:singleTap];
    
    //get
    _getLoginButton = [[UIButton alloc] init];
    [_getLoginButton setBackgroundColor:ULColorLoginButtonDisable];
    [_getLoginButton.layer setCornerRadius:2.0];
    [_getLoginButton setEnabled:NO];
    [_getLoginButton setTitle:@"GET" forState:UIControlStateNormal];
    [_getLoginButton addTarget:self action:@selector(get) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_getLoginButton];
    
    //post
    _postLoginButton = [[UIButton alloc] init];
    [_postLoginButton setBackgroundColor:ULColorLoginButtonDisable];
    [_postLoginButton.layer setCornerRadius:2.0];
    [_postLoginButton setEnabled:NO];
    [_postLoginButton setTitle:@"POST" forState:UIControlStateNormal];
    [_postLoginButton addTarget:self action:@selector(post) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_postLoginButton];
    
    //设置背景颜色
    self.view.backgroundColor = [UIColor colorWithRGBValue:0x0093EB];
}

#pragma mark - Action
-(void)login{
    [self hidesKeyboard];
    
    _loginButton.backgroundColor = ULColorLoginButtonLogining;
    
    [self userLogin];
}

-(void)get{
    __weak __typeof(&*self)weakSelf = self;
    NSString* username = _userNameInputView.inputText;
    NSString* password = _passWordInputView.inputText;
    ULLoginManager *loginManager = [ULLoginManager sharedManager];
    [loginManager getLoginWithUserName:username passWord:password successBlock:^{
        [weakSelf showResult:YES];
    } failedBlock:^{
        [weakSelf showResult:NO];
    }];
}

-(void)post{
    __weak __typeof(&*self)weakSelf = self;
    NSString* username = _userNameInputView.inputText;
    NSString* password = _passWordInputView.inputText;
    ULLoginManager *loginManager = [ULLoginManager sharedManager];
    [loginManager postLoginWithUserName:username passWord:password successBlock:^{
        [weakSelf showResult:YES];
    } failedBlock:^{
        [weakSelf showResult:NO];
    }];
}

-(void)handleSingleTap{
    [self hidesKeyboard];
}

#pragma mark Custom Method
-(void)userLogin{
    __weak __typeof(&*self)weakSelf = self;
    
    ULLoginManager *loginManager = [ULLoginManager sharedManager];
    
    NSString* username = _userNameInputView.inputText;
    NSString* password = _passWordInputView.inputText;
    
    [_loginButton setTitle:@"登录中 ..." forState:UIControlStateNormal];
    
    [self showIndicatorLoading];
    
    [loginManager loginWithUserName:username passWord:password successBlock:^{
        [weakSelf showResult:YES];
    } failedBlock:^{
        [weakSelf showResult:NO];
    }];
}

-(void)showResult:(BOOL) success{
    __weak __typeof(&*self)weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf dismissIndicatorLoading];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:success?@"登录成功":@"登录失败" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
        [weakSelf.loginButton setTitle:@"SOCKET" forState:UIControlStateNormal];
        _loginButton.backgroundColor = ULColorLoginButtonEnable;
    });
}

- (void)hidesKeyboard {
    [_userNameInputView.inputTextField resignFirstResponder];
    [_passWordInputView.inputTextField resignFirstResponder];
}

-(void)showIndicatorLoading{
    _loginLoadingIcon.hidden = NO;
    
    _loginLoadingIcon.alpha = 0.8;
    
    _loginLoadingIcon.layer.cornerRadius = 6;
    _loginLoadingIcon.layer.masksToBounds = YES;
    
    self.view.userInteractionEnabled = NO;
    
    [_loginLoadingIcon startAnimating];
}

-(void)dismissIndicatorLoading{
    _loginLoadingIcon.hidden = YES;
    [_loginLoadingIcon stopAnimating];
    if(self.view){
        self.view.userInteractionEnabled = YES;
    }
}

//输入文本改变时的调用
- (void)textDidChange:(NSNotification *)aNotification{
    //根据账号密码状态更新登录按钮状态
    if(_userNameInputView.inputText && _userNameInputView.inputText.length
       && _passWordInputView.inputText && _passWordInputView.inputText.length){
        [_loginButton setEnabled:YES];
        [_getLoginButton setEnabled:YES];
        [_postLoginButton setEnabled:YES];
        _loginButton.backgroundColor = ULColorLoginButtonEnable;
        _getLoginButton.backgroundColor = ULColorLoginButtonEnable;
        _postLoginButton.backgroundColor = ULColorLoginButtonEnable;
    }else{
        [_loginButton setEnabled:NO];
        [_getLoginButton setEnabled:NO];
        [_postLoginButton setEnabled:NO];
        _loginButton.backgroundColor = ULColorLoginButtonDisable;
        _getLoginButton.backgroundColor = ULColorLoginButtonDisable;
        _postLoginButton.backgroundColor = ULColorLoginButtonDisable;
    }
}

@end
