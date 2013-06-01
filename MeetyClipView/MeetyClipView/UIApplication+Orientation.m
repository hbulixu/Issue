//
//  UIApplication+Orientation.m
//  MeetyClipView
//
//  Created by 최건우 on 12. 10. 11..
//  Copyright (c) 2012년 최건우. All rights reserved.
//

#import "UIApplication+Orientation.h"

@implementation UIApplication (Orientation)
@dynamic interfaceOrientation;

- (UIInterfaceOrientation)interfaceOrientation{
    return [self statusBarOrientation];
}

@end
