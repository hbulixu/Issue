//
//  MeetyClippingAnimationViewController.m
//  MeetyClipView
//
//  Created by 최건우 on 12. 10. 11..
//  Copyright (c) 2012년 최건우. All rights reserved.
//

#import "MeetyClippingAnimationViewController.h"

@interface MeetyClippingAnimationViewController ()

@property (nonatomic) BOOL lastStatusbarHidden;

@end

@implementation MeetyClippingAnimationViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.lastStatusbarHidden = [[UIApplication sharedApplication] isStatusBarHidden];
    UIStatusBarAnimation animation;
    if (animated) {
        animation = UIStatusBarAnimationFade;
    } else{
        animation = UIStatusBarAnimationNone;
    }
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:animation];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.viewDidAppearBlock) {
        self.viewDidAppearBlock(self);
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    UIStatusBarAnimation animation;
    if (animated) {
        animation = UIStatusBarAnimationFade;
    } else{
        animation = UIStatusBarAnimationNone;
    }
    [[UIApplication sharedApplication] setStatusBarHidden:self.lastStatusbarHidden withAnimation:animation];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (self.viewDidDisappearBlock) {
        self.viewDidDisappearBlock(self);
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return [self.viewController shouldAutorotateToInterfaceOrientation:toInterfaceOrientation];
}

- (NSUInteger)supportedInterfaceOrientations{
    return [self.viewController supportedInterfaceOrientations];
}
@end
