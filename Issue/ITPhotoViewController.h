//
//  ITPhotoViewController.h
//  Issue
//
//  Created by 임상진 on 13. 6. 2..
//  Copyright (c) 2013년 임상진. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITPhoto.h"
#import "ITComment.h"

@interface ITPhotoViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ITPhoto *photo;
@property (nonatomic, strong) NSArray *comments;
@property (nonatomic, strong) UITextView *commentView;

@end
