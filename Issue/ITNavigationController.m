//
//  ITNavigationController.m
//  Issue
//
//  Created by 임상진 on 13. 6. 1..
//  Copyright (c) 2013년 임상진. All rights reserved.
//

#import "ITNavigationController.h"

@implementation ITNavigationController

- (id)init{
    self = [super init];
    if(self){
        self.navigationBar.tintColor = [UIColor whiteColor];
    }
    return self;
}

@end