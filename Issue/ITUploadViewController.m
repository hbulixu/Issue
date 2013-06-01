//
//  ITUploadViewController.m
//  Issue
//
//  Created by 최건우 on 13. 6. 2..
//  Copyright (c) 2013년 임상진. All rights reserved.
//

#import "ITUploadViewController.h"
#import "ITFile.h"
#import "ITRequest.h"
#import "ITPhoto.h"
@interface ITUploadViewController ()

@end

@implementation ITUploadViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)cancel:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)send:(id)sender{
    UIImage *image = self.backgroundImageView.image;
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0f);
    ITFile *imageFile = [ITFile fileWithData:imageData name:@"image.jpg" mimeType:@"image/jpeg"];
    NSDictionary *form = @{@"content": self.textView.text},
    *file = @{@"image": imageFile};
    ITRequest *request = [ITRequest requestWithURLString:[NSString stringWithFormat:@"/issue/%d/photo/", self.issue.id]
                                                  method:@"POST"
                                                 getArgs:@{}
                                                    form:form
                                                   files:file];
    [request setSuccessBlock:^(NSHTTPURLResponse *response, ITPhoto *photo) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } failureBlock:^(NSHTTPURLResponse *response, NSError *error) {
        [self dismissViewControllerAnimated:YES completion:nil];
        [[[UIAlertView alloc] initWithTitle:@"Failed!"
                                   message:[error localizedDescription]
                                  delegate:nil
                         cancelButtonTitle:@"Dismiss"
                         otherButtonTitles:nil] show];
    }];
    [request startWithUploadHUDInView:self.view];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.backgroundImageView.image = self.backgroundImageView.image;
    [self.textView becomeFirstResponder];
}

@end
