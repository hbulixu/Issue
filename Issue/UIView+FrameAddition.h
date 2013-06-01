//
//  UIView+FrameAddition.h
//  iDC
//
//  Created by 건우 최 on 12. 1. 10..
//  Copyright (c) 2012년 Unplug. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FrameAddition)

/* Basic frame properties */
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;
@property (nonatomic) CGSize size;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

/* Additional properties */
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;
@property (nonatomic, readonly) CGPoint innerCenter;
@property (nonatomic, readonly) CGFloat innerCenterX;
@property (nonatomic, readonly) CGFloat innerCenterY;

/* Moving */
- (void)moveXToCenter;
- (void)moveYToCenter;
- (void)moveToCenter;

- (void)moveToLeft;
- (void)moveToLeftWithPadding:(CGFloat)padding;

- (void)moveToRight;
- (void)moveToRightWithPadding:(CGFloat)padding;

- (void)moveToTop;
- (void)moveToTopWithPadding:(CGFloat)padding;

- (void)moveToBottom;
- (void)moveToBottomWithPadding:(CGFloat)padding;

- (void)moveToLeftOfView:(UIView*)view;
- (void)moveToLeftOfView:(UIView*)view margin:(CGFloat)margin;

- (void)moveToRightOfView:(UIView*)view;
- (void)moveToRightOfView:(UIView*)view margin:(CGFloat)margin;

- (void)moveToTopOfView:(UIView*)view;
- (void)moveToTopOfView:(UIView*)view margin:(CGFloat)margin;

- (void)moveToBottomOfView:(UIView*)view;
- (void)moveToBottomOfView:(UIView*)view margin:(CGFloat)margin;

- (void)setSize:(CGSize)size inset:(UIEdgeInsets)inset;

/* Frame description */

- (NSString*)frameDescription;

@end

NSString* CGRectDescription(CGRect rect);
