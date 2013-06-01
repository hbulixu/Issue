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
#import "ITPhotoViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ITFeedViewController ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) ITIssue *issue;

@end

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
    
    // BG
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"edit_back"]];
    backgroundImage.frame = self.view.bounds;
    backgroundImage.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:backgroundImage];
    
    // Title
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:24.0f];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.text = @"Feed";
    [self.titleLabel sizeToFit];
    self.titleLabel.centerY = 22;
    self.titleLabel.centerX = self.view.width / 2;
    //    self.titleLabel.layer.shadowRadius = 0;
    //    self.titleLabel.layer.shadowOpacity = 0.8;
    //    self.titleLabel.layer.shadowOffset = CGSizeMake(1,1);
    //    self.titleLabel.layer.shadowColor = [UIColor blackColor].CGColor;
    [self.view addSubview:self.titleLabel];
    
    // Plus
    UIButton *plusButton = [[UIButton alloc] init];
    [plusButton setBackgroundImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
    [plusButton setBackgroundImage:[UIImage imageNamed:@"plus2"] forState:UIControlStateHighlighted];
    [plusButton addTargetBlock:^(id sender) {
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
                [picker dismissViewControllerAnimated:YES completion:nil];
                NSLog(@"success");
            } failureBlock:^(NSHTTPURLResponse *response, NSError *error) {
                [picker dismissViewControllerAnimated:YES completion:nil];
                NSLog(@"failed");
            }];
            [request start];
            
        }];
        [picker setCancelBlock:^(UIImagePickerController *picker) {
            [picker dismissViewControllerAnimated:YES completion:nil];
        }];
        [self presentViewController:picker animated:YES completion:nil];
    } forControlEvents:UIControlEventTouchUpInside];
    [plusButton sizeToFit];
    plusButton.right = self.view.width - 6;
    plusButton.centerY = 22;
    [self.view addSubview:plusButton];
    
    // Table
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.height -= 44;
    _tableView.top += 44;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    _tableView.showsVerticalScrollIndicator = YES;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.backgroundColor = [UIColor clearColor];
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
        self.issue = issue;
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
    ITPhotoViewController *photoView = [[ITPhotoViewController alloc] init];
    photoView.photo = [_data objectAtIndex:button.tag];
    [self.navigationController pushViewController:photoView animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    if(_data.count > 0){
        return 1 + (_data.count-1) / 2 + (_data.count-1) % 2;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *identifier = @"InfoID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 308, 151)];
            view.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
            view.layer.cornerRadius = 5.0;
            view.layer.masksToBounds = YES;
            view.x = 6;
            view.y = 3;
            view.layer.shadowColor = [UIColor blackColor].CGColor;
            view.layer.shadowOpacity = 0.8;
            view.layer.shadowRadius = 1.0;
            view.layer.shadowOffset = CGSizeMake(1, 1);
            view.layer.rasterizationScale = [[UIScreen mainScreen] scale];
            view.layer.shouldRasterize = YES;
            
            UITextView *tv = [[UITextView alloc] initWithFrame:view.bounds];
            tv.userInteractionEnabled = NO;
            tv.tag = 1;
            tv.width -= 10 + view.left;
            tv.top += 5 + view.left;
            tv.left += 5 + view.top;
            tv.backgroundColor = [UIColor clearColor];
            tv.textColor = [UIColor blackColor];
            
            [cell addSubview:view];
            [cell addSubview:tv];
        }
        for (UITextView *tv in [cell subviews]){
            if (tv.tag != 1) {
                continue;
            }
            tv.text = [NSString stringWithFormat:@"%@\n===============\n%@",self.issue.title, self.issue.description];
        }
        return cell;
    }
    
    if (indexPath.row == 0) { // Top
        static NSString *identifier = @"TopID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 308, 151)];
            NSURL *url = [(ITPhoto*)[_data objectAtIndex:0] imageURL];
            [imageView1 setImageWithURL:url];
            imageView1.backgroundColor = [UIColor grayColor];
            imageView1.tag = 1;
            CGRect frame = imageView1.bounds;
            frame.origin.x = 6;
            frame.origin.y = 3;
            UIButton *imageButton1 = [[UIButton alloc] initWithFrame:frame];
            imageView1.clipsToBounds = YES;
            imageView1.contentMode = UIViewContentModeScaleAspectFill;
            
            // Rad
            imageView1.layer.cornerRadius = 5.0;
            imageView1.layer.masksToBounds = YES;
            
            
            imageButton1.tag = 0;
            [imageButton1 addTarget:self action:@selector(imageTouched:) forControlEvents:UIControlEventTouchUpInside];
            [imageButton1 addSubview:imageView1];
            // Shadow
            imageButton1.layer.shadowColor = [UIColor blackColor].CGColor;
            imageButton1.layer.shadowOpacity = 0.8;
            imageButton1.layer.shadowRadius = 1.0;
            imageButton1.layer.shadowOffset = CGSizeMake(1, 1);
            imageButton1.layer.rasterizationScale = [[UIScreen mainScreen] scale];
            imageButton1.layer.shouldRasterize = YES;
            [cell addSubview:imageButton1];
        }
        return cell;
    } else {
        static NSString *identifier = @"FeedViewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 151, 151)];
            NSURL *url = [(ITPhoto*)[_data objectAtIndex:(indexPath.row-1) * 2 + 1] imageURL];
            [imageView1 setImageWithURL:url];
            imageView1.backgroundColor = [UIColor grayColor];
            imageView1.tag = 1;
            CGRect frame = imageView1.bounds;
            frame.origin.x = 6;
            frame.origin.y = 3;
            UIButton *imageButton1 = [[UIButton alloc] initWithFrame:frame];
            imageView1.clipsToBounds = YES;
            imageView1.contentMode = UIViewContentModeScaleAspectFill;
            
            // Rad
            imageView1.layer.cornerRadius = 5.0;
            imageView1.layer.masksToBounds = YES;
            
            
            imageButton1.tag = indexPath.row * 2;
            [imageButton1 addTarget:self action:@selector(imageTouched:) forControlEvents:UIControlEventTouchUpInside];
            [imageButton1 addSubview:imageView1];
            // Shadow
            imageButton1.layer.shadowColor = [UIColor blackColor].CGColor;
            imageButton1.layer.shadowOpacity = 0.8;
            imageButton1.layer.shadowRadius = 1.0;
            imageButton1.layer.shadowOffset = CGSizeMake(1, 1);
            imageButton1.layer.rasterizationScale = [[UIScreen mainScreen] scale];
            imageButton1.layer.shouldRasterize = YES;
            [cell addSubview:imageButton1];
            
            if(_data.count-1 >= (indexPath.row - 1 + 1) * 2){
                UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 151, 151)];
                url = [(ITPhoto*)[_data objectAtIndex:indexPath.row * 2] imageURL];
                [imageView2 setImageWithURL:url];
                imageView2.clipsToBounds = YES;
                imageView2.backgroundColor = [UIColor grayColor];
                imageView2.tag = 2;
                
                // Rad
                imageView2.layer.cornerRadius = 5.0;
                imageView2.layer.masksToBounds = YES;
                
                imageView2.contentMode = UIViewContentModeScaleAspectFill;
                frame = imageView1.bounds;
                frame.origin.x = 163;
                frame.origin.y = 3;
                UIButton *imageButton2 = [[UIButton alloc] initWithFrame:frame];
                imageButton2.tag = indexPath.row * 2;
                [imageButton2 addTarget:self action:@selector(imageTouched:) forControlEvents:UIControlEventTouchUpInside];
                [imageButton2 addSubview:imageView2];
                
                imageButton2.layer.shadowColor = [UIColor blackColor].CGColor;
                imageButton2.layer.shadowOpacity = 0.8;
                imageButton2.layer.shadowRadius = 1.0;
                imageButton2.layer.shadowOffset = CGSizeMake(1, 1);
                imageButton2.layer.rasterizationScale = [[UIScreen mainScreen] scale];
                imageButton2.layer.shouldRasterize = YES;
                [cell addSubview:imageButton2];
            }
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 157;
    }
    return 157;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

@end
