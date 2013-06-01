//
//  UIView+FirstResponder.m
//  meety_ios
//
//  Created by 최건우 on 12. 10. 8..
//  Copyright (c) 2012년 Meety. All rights reserved.
//

#import "UIView+FirstResponder.h"

@implementation UIView (FirstResponder)

- (UIView*)firstResponder{
    if ([self isFirstResponder]) {
        return self;
    }
    UIView* view = nil;
    for (UIView* subview in self.subviews) {
        view = [subview firstResponder];
        if (view != nil) {
            break;
        }
    }
    return view;
}

@end
