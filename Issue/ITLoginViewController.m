//
//  ITLoginViewController.m
//  Issue
//
//  Created by 임상진 on 13. 6. 1..
//  Copyright (c) 2013년 임상진. All rights reserved.
//

#import "ITLoginViewController.h"
#import "ITUtil.h"
#import "ITURLRequest.h"
#import "ITRequest.h"


@implementation ITLoginViewController

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
        NSDictionary *params = @{@"username": _usernameField.text,
                                 @"password": _passwordField.text};
        ITRequest *request = [ITRequest requestWithURLString:@"/login" method:@"POST" getArgs:@{} form:params files:nil];
        [request setSuccessBlock:^(NSHTTPURLResponse* response, id object){
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:_usernameField.text forKey:@"username"];
            [defaults setObject:_passwordField.text forKey:@"password"];
            [defaults synchronize];
            [ITUtil updateSession];
            [ITUtil loadSessionCookie];
            [self dismissViewControllerAnimated:YES completion:^{
                NSLog(@"success");
            }];
        } failureBlock:^(NSHTTPURLResponse *response, NSError *error){
            NSLog(@"failed");
        }];
        [request start];
    }
    else{
        NSLog(@"Fields must be filled");
    }
}

@end
