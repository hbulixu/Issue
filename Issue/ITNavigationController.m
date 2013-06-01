//
//  ITNavigationController.m
//  Issue
//
//  Created by 임상진 on 13. 6. 1..
//  Copyright (c) 2013년 임상진. All rights reserved.
//

#import "ITNavigationController.h"

@implementation ITNavigationController

- (id)initWithRootViewController:(UIViewController *)rootViewController{
    self = [super initWithRootViewController:rootViewController];
    if(self){
        self.navigationBar.tintColor = [UIColor whiteColor];
        NSDictionary *options = @{UITextAttributeTextColor: [UIColor blackColor]};
        self.navigationBar.titleTextAttributes = options;
    }
    return self;
}

@end