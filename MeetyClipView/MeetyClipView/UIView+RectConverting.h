//
//  UIView+RectConverting.h
//  MeetyClipView
//
//  Created by 최건우 on 12. 10. 11..
//  Copyright (c) 2012년 최건우. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (RectConverting)

+ (BOOL)isRetina;
- (CGRect)convertRectThroughWindow:(CGRect)rect fromView:(UIView *)view;
- (CGRect)convertRectThroughWindow:(CGRect)rect toView:(UIView *)view;
- (CGPoint)convertPointThroughWindow:(CGPoint)point toView:(UIView *)view;
- (CGPoint)convertPointThroughWindow:(CGPoint)point fromView:(UIView *)view;

@end

CGSize CGSizeSwap(CGSize size);
CGPoint CGPointSwap(CGPoint point);
CGRect CGRectSwap(CGRect rect);

CGSize CGSizeFixRetina(CGSize size);
CGPoint CGPointFixRetina(CGPoint point);
CGRect CGRectFixRetina(CGRect rect);
CGPoint CGPointRorateIfNeeded(CGPoint point, UIView* baseView);
CGRect CGRectRotateIfNeeded(CGRect rect, UIView* baseView);