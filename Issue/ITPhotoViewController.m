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
@synthesize tableView = _tableView, URL = _URL;

- (void)viewDidLoad
{
    [super viewDidLoad];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    [self loadContents];
}

#pragma mark - Custom Methods

- (void)loadComment{
    // fetch comments asynchronous
    NSURL *commentURL = [NSURL URLWithString:[[_URL absoluteString] stringByAppendingPathComponent:@"/comment"]];
    ITRequest *request = [ITRequest requestWithURL:commentURL method:@"GET"];
    [request setSuccessBlock:^(NSHTTPURLResponse *response, id object){
        NSLog(@"success");
        [_tableView reloadData];
    } failureBlock:^(NSHTTPURLResponse *response, NSError *error){
        NSLog(@"failed");
    }];
    [request startAsync];
}

- (void)loadContents{
    [self loadComment];
    [_tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"PhotoViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        if(indexPath.row == 0){
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(6, 6, 302, 302)];
            [imageView setImageWithURL:_URL];
            [cell addSubview:imageView];
        }
        else if(indexPath.row == 1){
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(6, 3, 302, 24)];
            label.text = @"17명이 좋아합니다.";
            [cell addSubview:label];
        }
        else if(indexPath.row == 2){
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(6, 3, 302, 24)];
            label.text = @"17개의 댓글";
            [cell addSubview:label];
        }
        else{
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(6, 3, 302, 24)];
            label.text = @"가나다라마바사아자차카타파하";
            [cell addSubview:label];
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0)
        return 320;
    return 30;
}

@end
