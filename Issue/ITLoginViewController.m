//
//  ITLoginViewController.m
//  Issue
//
//  Created by 임상진 on 13. 6. 1..
//  Copyright (c) 2013년 임상진. All rights reserved.
//

#import "ITLoginViewController.h"
#import "ITUtil.h"
#import "AFHTTPClient.h"


@implementation ITLoginViewController
@synthesize usernameLabel = _usernameLabel, usernameField = _usernameField,
            passwordLabel = _passwordLabel, passwordField = _passwordField;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *formContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 260, 120)];
    
    _usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 260, 20)];
    _usernameLabel.text = @"Username";
    [formContainer addSubview:_usernameLabel];
    
    _usernameField = [[UITextField alloc] initWithFrame:CGRectMake(0, 20, 260, 20)];
    [formContainer addSubview:_usernameField];
    
    _passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 260, 20)];
    _passwordLabel.text = @"Password";
    [formContainer addSubview:_passwordLabel];
    
    _passwordField = [[UITextField alloc] initWithFrame:CGRectMake(0, 60, 260, 20)];
    _passwordField.secureTextEntry = YES;
    [formContainer addSubview:_passwordField];
    
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 260, 20)];
    loginButton.backgroundColor = [UIColor yellowColor];
    [loginButton addTarget:self action:@selector(loginButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [formContainer addSubview:loginButton];
    
    [self.view addSubview:formContainer];
    [formContainer moveToCenter];
}

#pragma mark - Custom Methods

- (void)loginButtonTouched:(UIButton*)button{
    [self login];
}

- (void)login{
    if([_usernameField.text length] > 0 && [_passwordField.text length] > 0){
        AFHTTPClient *client = [ITUtil getHttpClient];
        NSDictionary *params = @{@"username": _usernameField.text,
                                 @"password": _passwordField.text};
        [client postPath:@"/login"
                parameters:params
                success:^(AFHTTPRequestOperation *operation, id responseObject){
                    NSLog(@"success");
                }
                failure:^(AFHTTPRequestOperation *operation, NSError *error){
                    NSLog(@"failed");
                }
        ];
    }
    else{
        NSLog(@"Fields must be filled");
    }
}

@end
