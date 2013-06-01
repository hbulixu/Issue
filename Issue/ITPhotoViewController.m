//
//  ITPhotoViewController.m
//  Issue
//
//  Created by 임상진 on 13. 6. 2..
//  Copyright (c) 2013년 임상진. All rights reserved.
//

#import "ITPhotoViewController.h"
#import "UIImageView+AFNetworking.h"
#import "ITRequest.h"
#import <QuartzCore/QuartzCore.h>

#define CommentStartRow 3

@implementation ITPhotoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _comments = [NSArray array];
    
    // BG
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"edit_back"]];
    backgroundImage.frame = self.view.bounds;
    backgroundImage.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:backgroundImage];
    
    // Title
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont boldSystemFontOfSize:24.0f];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"Photo";
    [label sizeToFit];
    label.centerY = 22;
    label.centerX = self.view.width / 2;
    [self.view addSubview:label];
    
    // Button
    UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [back setImage:[UIImage imageNamed:@"bt1_back"] forState:UIControlStateNormal];
    [back setImage:[UIImage imageNamed:@"bt2_back"] forState:UIControlStateHighlighted];
    [back addTargetBlock:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
    
    // Table
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, 320, self.view.height - 44 - 30)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler:)];
    tap.cancelsTouchesInView = NO;
    [_tableView addGestureRecognizer:tap];
    
    UIView *commentForm = [[UIView alloc] initWithFrame:CGRectMake(0, 518, 320, 30)];
    commentForm.backgroundColor = [UIColor grayColor];
    _commentView = [[UITextView alloc] initWithFrame:CGRectMake(0, 5, 280, 20)];
    [commentForm addSubview:_commentView];
    UIButton *commentSubmit = [[UIButton alloc] initWithFrame:CGRectMake(280, 0, 40, 30)];
    [commentSubmit addTarget:self action:@selector(postComment:) forControlEvents:UIControlEventTouchUpInside];
    commentSubmit.backgroundColor = [UIColor blackColor];
    [commentForm addSubview:commentSubmit];
    [self.view addSubview:commentForm];
    
    [self loadContents];
}

- (void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyBoardDidShow)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyBoardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewWillDisappear:animated];
}

#pragma mark - Custom Methods

- (void)tapHandler:(UITapGestureRecognizer*)tap{
    [_commentView resignFirstResponder];
}

- (void)keyBoardDidShow{
    UIEdgeInsets inset = UIEdgeInsetsMake(0, 0, 216, 0);
    _tableView.scrollIndicatorInsets = inset;
    _tableView.contentInset = inset;
    UIView *commentForm = _commentView.superview;
    CGRect frame = commentForm.frame;
    frame.origin.y -= 216;
    commentForm.frame = frame;
}

- (void)keyBoardWillHide{
    _tableView.scrollIndicatorInsets = UIEdgeInsetsZero;
    [UIView animateWithDuration:0.3f animations:^{
        _tableView.contentInset = UIEdgeInsetsZero;
    }];
    UIView *commentForm = _commentView.superview;
    CGRect frame = commentForm.frame;
    frame.origin.y = 518;
    commentForm.frame = frame;
}

- (void)loadComment{
    ITRequest *request = [ITRequest requestWithURLString:[NSString stringWithFormat:@"/photo/%d/comment/", _photo.id]
                                                  method:@"GET"
                                                 getArgs:@{}];
    [request setSuccessBlock:^(NSHTTPURLResponse *response, NSArray *comments){
        NSLog(@"success");
        _comments = [NSArray arrayWithArray:comments];
        [_tableView reloadData];
    } failureBlock:^(NSHTTPURLResponse *response, NSError *error){
        NSLog(@"failed");
    }];
    [request startAsync];
}

- (void)postComment:(UIButton*)button{
    ITRequest *request = [ITRequest requestWithURLString:[NSString stringWithFormat:@"/photo/%d/comment/", _photo.id]
                                                  method:@"POST"
                                                 getArgs:@{}
                                                    form:@{@"content": _commentView.text}
                                                   files:@{}];
    [request setSuccessBlock:^(NSHTTPURLResponse *response, ITComment *comment){
        self.commentView.text = @"";
        [self.commentView resignFirstResponder];
        NSLog(@"success");
    } failureBlock:^(NSHTTPURLResponse *response, NSError *error){        [self.commentView resignFirstResponder];
        [[[UIAlertView alloc] initWithTitle:@"Failed!"
                                    message:@"Comment upload failed"
                                   delegate:nil
                          cancelButtonTitle:@"Dismiss"
                          otherButtonTitles:nil] show];
        NSLog(@"failed");
    }];
    [request startWithHUDInView:self.view];
}

- (void)postLike:(UIButton*)button{
    ITRequest *request = [ITRequest requestWithURLString:[NSString stringWithFormat:@"/photo/%d/like/", _photo.id]
                                                  method:@"POST"
                                                 getArgs:@{}];
    [request setSuccessBlock:^(NSHTTPURLResponse *response, id object){
        self.commentView.text = nil;
        [self.commentView resignFirstResponder];
        NSLog(@"success");
    } failureBlock:^(NSHTTPURLResponse *response, NSError *error){
        [self.commentView resignFirstResponder];
        [[[UIAlertView alloc] initWithTitle:@"Failed!"
                                    message:@"Like failed"
                                   delegate:nil
                          cancelButtonTitle:@"Dismiss"
                          otherButtonTitles:nil] show];
        NSLog(@"failed");
    }];
    [request startWithHUDInView:self.view];
}

- (void)loadContents{
    [self loadComment];
    [_tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _comments.count + CommentStartRow;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"PhotoViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if(indexPath.row == 0){
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(6, 6, 308, 308)];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            imageView.layer.cornerRadius = 5.0;
            imageView.layer.shadowColor = [UIColor blackColor].CGColor;
            imageView.layer.shadowOffset = CGSizeMake(1,1);
            imageView.layer.shadowRadius = 0;
            imageView.layer.shadowOpacity = 0.8;
            imageView.layer.shouldRasterize = YES;
            imageView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
            [imageView setImageWithURL:_photo.imageURL];
            imageView.userInteractionEnabled = YES;
            UIButton *likeButton = [[UIButton alloc] initWithFrame:CGRectMake(262, 262, 30, 30)];
            likeButton.right = cell.width - 15;
            likeButton.bottom = imageView.height - 15;
            [likeButton setImage:[UIImage imageNamed:@"heart"] forState:UIControlStateNormal];
            [likeButton setImage:[UIImage imageNamed:@"heart2"] forState:UIControlStateHighlighted];
            [likeButton addTarget:self action:@selector(postLike:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:likeButton];
            [cell addSubview:imageView];
        }
        else if(indexPath.row == 1){
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(6, 3, 308, 30)];
            view.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
            view.layer.cornerRadius = 5.0;
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 280, 24)];
            label.text = [NSString stringWithFormat:@"%d명이 좋아합니다.", _photo.likesCount];
            label.backgroundColor = [UIColor clearColor];
            [view addSubview:label];
            [label moveYToCenter];
            label.left = 10;
            [cell addSubview:view];
        }
        else if(indexPath.row == 2){
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(6, 3, 308, 30)];
            view.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
            view.layer.cornerRadius = 5.0;
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 280, 24)];
            label.text = [NSString stringWithFormat:@"%d개의 댓글", _photo.commentsCount];
            label.backgroundColor = [UIColor clearColor];
            [view addSubview:label];
            [label moveYToCenter];
            label.left = 10;
            [cell addSubview:view];
        }
        else{
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(6, 3, 308, 30)];
            view.top += 2;
            view.height = cell.height - 6;
            view.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
            view.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
            view.layer.cornerRadius = 5.0;
            
            ITComment *comment = [_comments objectAtIndex:indexPath.row - CommentStartRow];
            NSString *content = [NSString stringWithFormat:@"%@ : %@", comment.writer.username, comment.content];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(6, 0, 308, view.height - 6)];
            label.lineBreakMode = NSLineBreakByWordWrapping;
            label.numberOfLines = 0;
            label.text = content;
            label.backgroundColor = [UIColor clearColor];
            [view addSubview:label];
            [cell addSubview:view];
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return 320;
    } else if(indexPath.row >= 3){
        NSString *content = [[_comments objectAtIndex:indexPath.row - CommentStartRow] content];
        CGSize size = [content sizeWithFont:[UIFont systemFontOfSize:20]
                          constrainedToSize:CGSizeMake(308, 60)
                              lineBreakMode:NSLineBreakByWordWrapping];
        return size.height + 16;
    }
    return 36;
}

@end
