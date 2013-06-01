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

#define CommentStartRow 3

@implementation ITPhotoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _comments = [NSArray array];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 425)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler:)];
    tap.cancelsTouchesInView = NO;
    [_tableView addGestureRecognizer:tap];
    
    UIView *commentForm = [[UIView alloc] initWithFrame:CGRectMake(0, 425, 320, 30)];
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
    self.navigationController.navigationBarHidden = NO;
    
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
    UIEdgeInsets inset = UIEdgeInsetsMake(0, 0, 167, 0);
    _tableView.scrollIndicatorInsets = inset;
    _tableView.contentInset = inset;
    UIView *commentForm = _commentView.superview;
    CGRect frame = commentForm.frame;
    frame.origin.y -= 167;
    commentForm.frame = frame;
}

- (void)keyBoardWillHide{
    _tableView.scrollIndicatorInsets = UIEdgeInsetsZero;
    [UIView animateWithDuration:0.3f animations:^{
        _tableView.contentInset = UIEdgeInsetsZero;
    }];
    UIView *commentForm = _commentView.superview;
    CGRect frame = commentForm.frame;
    frame.origin.y = 425;
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
        NSLog(@"success");
    } failureBlock:^(NSHTTPURLResponse *response, NSError *error){
        NSLog(@"failed");
    }];
    [request start];
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
            [imageView setImageWithURL:_photo.imageURL];
            [cell addSubview:imageView];
        }
        else if(indexPath.row == 1){
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(6, 3, 308, 24)];
            label.text = [NSString stringWithFormat:@"%d명이 좋아합니다.", _photo.likesCount];
            [cell addSubview:label];
        }
        else if(indexPath.row == 2){
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(6, 3, 308, 24)];
            label.text = [NSString stringWithFormat:@"%d개의 댓글", _photo.commentsCount];
            [cell addSubview:label];
        }
        else{
            NSString *content = [[_comments objectAtIndex:indexPath.row - CommentStartRow] content];
            CGSize size = [content sizeWithFont:[UIFont systemFontOfSize:20]
                              constrainedToSize:CGSizeMake(308, 60)
                                  lineBreakMode:NSLineBreakByWordWrapping];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(6, 3, 308, size.height)];
            label.text = content;
            label.numberOfLines = 0;
            [cell addSubview:label];
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0)
        return 320;
    else if(indexPath.row >= 3){
        NSString *content = [[_comments objectAtIndex:indexPath.row - CommentStartRow] content];
        CGSize size = [content sizeWithFont:[UIFont systemFontOfSize:20]
                          constrainedToSize:CGSizeMake(308, 60)
                              lineBreakMode:NSLineBreakByWordWrapping];
        return size.height;
    }
    return 30;
}

@end
