//
//  UIView+RectConverting.m
//  MeetyClipView
//
//  Created by 최건우 on 12. 10. 11..
//  Copyright (c) 2012년 최건우. All rights reserved.
//

#import "UIView+RectConverting.h"
#import "UIApplication+Orientation.h"

CGSize CGSizeSwap(CGSize size){
    return CGSizeMake(size.height, size.width);
}

CGPoint CGPointSwap(CGPoint point){
    return CGPointMake(point.y, point.x);
}

CGRect CGRectSwap(CGRect rect){
    CGRect newRect;
    newRect.origin = CGPointSwap(rect.origin);
    newRect.size = CGSizeSwap(rect.size);
    return newRect;
}

CGSize CGSizeFixRetina(CGSize size){
    if ([UIView isRetina]) {
        return CGSizeMake(size.width * 2, size.height * 2);
    }
    return size;
}

CGPoint CGPointFixRetina(CGPoint point){
    if ([UIView isRetina]) {
        return CGPointMake(point.x * 2, point.y * 2);
    }
    return point;
}

CGRect CGRectFixRetina(CGRect rect){
    rect.origin = CGPointFixRetina(rect.origin);
    rect.size = CGSizeFixRetina(rect.size);
    return rect;
}

CGPoint CGPointRorateIfNeeded(CGPoint point, UIView* baseView){
    CGFloat baseWidth = [baseView bounds].size.width;
    CGFloat baseHeight = [baseView bounds].size.height;
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] interfaceOrientation];
    if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
        point = CGPointSwap(point);
    }
    switch (interfaceOrientation) {
        case UIInterfaceOrientationLandscapeLeft:
            point.x = baseWidth - point.x;
            break;
        case UIInterfaceOrientationLandscapeRight:
            point.y = baseHeight - point.y;
            break;
        case UIInterfaceOrientationPortrait:
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            point.x = baseWidth - point.x;
            point.y = baseHeight - point.y;
            break;
    }
    return point;
}

CGRect CGRectRotateIfNeeded(CGRect rect, UIView* baseView){
    CGFloat baseWidth = [baseView bounds].size.width;
    CGFloat baseHeight = [baseView bounds].size.height;
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] interfaceOrientation];
    if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
        rect = CGRectSwap(rect);
    }
    switch (interfaceOrientation) {
        case UIInterfaceOrientationLandscapeLeft:
            rect.origin.y = baseHeight - (rect.size.height + rect.origin.y);
            break;
        case UIInterfaceOrientationLandscapeRight:
            rect.origin.x = baseWidth - (rect.size.width + rect.origin.x);
            break;
        case UIInterfaceOrientationPortrait:
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            rect.origin.x = baseWidth - (rect.size.width + rect.origin.x);
            rect.origin.y = baseHeight - (rect.size.height + rect.origin.y);
            break;
    }
    return rect;
}

@implementation UIView (RectConverting)

+ (BOOL)isRetina{
    if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] &&
        ([UIScreen mainScreen].scale == 2.0)) {
        return YES;
    } else {
        return NO;
    }
}

- (CGRect)convertRectThroughWindow:(CGRect)rect fromView:(UIView *)view{
    UIWindow* window = [[UIApplication sharedApplication] keyWindow];
    rect = [window convertRect:rect fromView:view];
    rect = CGRectRotateIfNeeded(rect, window);
    rect = [self convertRect:rect fromView:window];
    rect = CGRectFixRetina(rect);
    return rect;
}

- (CGRect)convertRectThroughWindow:(CGRect)rect toView:(UIView *)view{
    UIWindow* window = [[UIApplication sharedApplication] keyWindow];
    rect = [window convertRect:rect fromView:self];
    rect = CGRectRotateIfNeeded(rect, window);
    rect = [view convertRect:rect fromView:window];
    rect = CGRectRotateIfNeeded(rect, view);
    rect = CGRectFixRetina(rect);
    return rect;
}

- (CGPoint)convertPointThroughWindow:(CGPoint)point toView:(UIView *)view{
    UIWindow* window = [[UIApplication sharedApplication] keyWindow];
    point = [window convertPoint:point fromView:self];
    point = CGPointRorateIfNeeded(point, window);
    point = [view convertPoint:point fromView:window];
    if ([UIView isRetina]) {
        point.x *= 2;
        point.y *= 2;
    }
    return point;
}

- (CGPoint)convertPointThroughWindow:(CGPoint)point fromView:(UIView *)view{
    UIWindow* window = [[UIApplication sharedApplication] keyWindow];
    point = [window convertPoint:point fromView:view];
    point = CGPointRorateIfNeeded(point, window);
    point = [self convertPoint:point fromView:window];
    if ([UIView isRetina]) {
        point.x *= 2;
        point.y *= 2;
    }
    return point;
}

@end