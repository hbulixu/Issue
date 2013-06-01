//
//  ITUploadViewController.h
//  Issue
//
//  Created by 최건우 on 13. 6. 2..
//  Copyright (c) 2013년 임상진. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITIssue.h"

@interface ITUploadViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextView *textView;
@property (nonatomic, strong) IBOutlet UIImageView *backgroundImageView;
@property (nonatomic, strong) ITIssue *issue;

- (IBAction)cancel:(id)sender;
- (IBAction)send:(id)sender;

@end
