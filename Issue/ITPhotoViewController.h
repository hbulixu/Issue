//
//  ITPhotoViewController.h
//  Issue
//
//  Created by 임상진 on 13. 6. 2..
//  Copyright (c) 2013년 임상진. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITPhoto.h"

@interface ITPhotoViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ITPhoto *photo;

@end
