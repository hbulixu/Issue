//
//  UIViewController+Hierarchy.m
//  meety_ios
//
//  Created by 최건우 on 12. 10. 29..
//  Copyright (c) 2012년 Meety. All rights reserved.
//

#import "UIViewController+Hierarchy.h"

@implementation UIViewController (Hierarchy)

- (NSArray*)parentViewControllers{
    NSMutableArray* array = [NSMutableArray array];
    UIViewController* parent = self.parentViewController;
    while (parent) {
        [array addObject:parent];
        parent = parent.parentViewController;
    }
    return [NSArray arrayWithArray:array];
}

@end
