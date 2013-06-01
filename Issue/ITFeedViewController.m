//
//  ITFeedViewController.m
//  Issue
//
//  Created by 임상진 on 13. 6. 1..
//  Copyright (c) 2013년 임상진. All rights reserved.
//

#import "ITFeedViewController.h"
#import "UIImageView+AFNetworking.h"
#import "ITRequest.h"
#import "ITIssue.h"
#import "ITPhoto.h"
#import "ITFile.h"
#import "UIImage+Picker.h"

@implementation ITFeedViewController

- (id)init{
    self = [super init];
    if(self){
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                              target:self
                                                                              action:@selector(upload:)];
        self.navigationItem.rightBarButtonItem = item;
        //UIButton *uploadButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        //UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:uploadButton];
        //self.navigationItem.rightBarButtonItem = item;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
    _refreshControl = [[UIRefreshControl alloc] init];
    UIRefreshControl *refreshControl = _refreshControl;
    [refreshControl addTargetBlock:^(id sender){
        [self refresh];
    } forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:_refreshControl];
    
    [self refresh];
}

# pragma mark - Custom Methods

- (void)refresh{
    // Update data with self.URL
    ITRequest *issueRequest = [ITRequest requestWithURLString:@"/issue/current" method:@"GET" getArgs:@{}];
    [issueRequest setSuccessBlock:^(NSHTTPURLResponse *response, ITIssue *issue){
        ITRequest *feedRequest = [ITRequest requestWithURLString:[NSString stringWithFormat:@"/issue/%d/photo/", issue.id]
                                                          method:@"GET"
                                                         getArgs:@{}];
        [feedRequest setSuccessBlock:^(NSHTTPURLResponse *response, NSArray *feedList) {
            NSLog(@"success");
            self.data = feedList;
            [_tableView reloadData];
            [_refreshControl endRefreshing];
        } failureBlock:^(NSHTTPURLResponse *response, NSError *error) {
            NSLog(@"failed");
            [_refreshControl endRefreshing];
        }];
        [feedRequest startAsync];
    } failureBlock:^(NSHTTPURLResponse *response, NSError *error){
        NSLog(@"failed");
        [_refreshControl endRefreshing];
    }];
    [issueRequest startAsync];
}

- (void)imageTouched:(UIButton*)button{
    NSLog(@"%d touched", button.tag);
}

- (void)upload:(UIBarButtonItem*)item{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [picker setFinishBlock:^(UIImagePickerController *picker, NSDictionary *info) {
        UIImage *image = [UIImage imageWithPickerInfo:info];
        NSData *imageData = UIImageJPEGRepresentation(image, 1.0f);
        ITFile *imageFile = [ITFile fileWithData:imageData name:@"image.jpg" mimeType:@"image/jpeg"];
        NSDictionary *form = @{@"content": @"contentyoyoyo"},
                     *file = @{@"image": imageFile};
        ITRequest *request = [ITRequest requestWithURLString:@"/issue/1/photo/"
                                                      method:@"POST"
                                                     getArgs:@{}
                                                        form:form
                                                       files:file];
        [request setSuccessBlock:^(NSHTTPURLResponse *response, ITPhoto *photo) {
            NSLog(@"success");
        } failureBlock:^(NSHTTPURLResponse *response, NSError *error) {
            NSLog(@"failed");
        }];
        [request start];

    }];
    [picker setCancelBlock:^(UIImagePickerController *picker) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }];
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(_data.count > 0)
        return _data.count / 2 + _data.count % 2;
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"FeedViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 151, 151)];
        NSURL *url = [(ITPhoto*)[_data objectAtIndex:indexPath.row * 2] imageURL];
        [imageView1 setImageWithURL:url];
        imageView1.backgroundColor = [UIColor grayColor];
        imageView1.tag = 1;
        CGRect frame = imageView1.bounds;
        frame.origin.x = 6;
        frame.origin.y = 3;
        UIButton *imageButton1 = [[UIButton alloc] initWithFrame:frame];
        imageButton1.tag = indexPath.row * 2;
        [imageButton1 addTarget:self action:@selector(imageTouched:) forControlEvents:UIControlEventTouchUpInside];
        [imageButton1 addSubview:imageView1];
        [cell addSubview:imageButton1];
        
        if(_data.count >= (indexPath.row + 1) * 2){
            UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 151, 151)];
            url = [(ITPhoto*)[_data objectAtIndex:indexPath.row * 2 + 1] imageURL];
            [imageView2 setImageWithURL:url];
            imageView2.backgroundColor = [UIColor grayColor];
            imageView2.tag = 2;
            frame = imageView1.bounds;
            frame.origin.x = 163;
            frame.origin.y = 3;
            UIButton *imageButton2 = [[UIButton alloc] initWithFrame:frame];
            imageButton2.tag = indexPath.row * 2 + 1;
            [imageButton2 addTarget:self action:@selector(imageTouched:) forControlEvents:UIControlEventTouchUpInside];
            [imageButton2 addSubview:imageView2];
            [cell addSubview:imageButton2];
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 157;
}

@end
