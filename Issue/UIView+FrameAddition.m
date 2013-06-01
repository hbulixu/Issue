//
//  UIView+FrameAddition.m
//  iDC
//
//  Created by 건우 최 on 12. 1. 10..
//  Copyright (c) 2012년 Unplug. All rights reserved.
//

#import "UIView+FrameAddition.h"

@implementation UIView (FrameAddition)
@dynamic origin;
@dynamic x;
@dynamic y;
@dynamic size;
@dynamic width;
@dynamic height;
@dynamic top;
@dynamic bottom;
@dynamic left;
@dynamic right;
@dynamic centerX;
@dynamic centerY;
@dynamic innerCenter;
@dynamic innerCenterX;
@dynamic innerCenterY;

- (CGPoint)origin{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGFloat)x{
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x{
    self.origin = CGPointMake(x, self.y);
}

- (CGFloat)y{
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y{
    self.origin = CGPointMake(self.x, y);
}

- (CGPoint)innerCenter{
    return CGPointMake(self.width / 2, self.height / 2);
}

- (CGFloat)innerCenterX{
    return self.innerCenter.x;
}

- (CGFloat)innerCenterY{
    return self.innerCenter.y;
}

- (CGSize)size{
    return self.frame.size;
}

- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)setSize:(CGSize)size inset:(UIEdgeInsets)inset{
    CGRect frame = self.frame;
    frame.size = CGSizeMake(size.width+inset.left+inset.right,
                            size.height+inset.top+inset.bottom);
    self.frame = frame;
}

- (CGFloat)width{
    return self.size.width;
}

- (void)setWidth:(CGFloat)width{
    self.size = CGSizeMake(width, self.height);
}

- (CGFloat)height{
    return self.size.height;
}

- (void)setHeight:(CGFloat)height{
    self.size = CGSizeMake(self.width, height);
}

- (CGFloat)top{
    return self.y;
}

- (void)setTop:(CGFloat)top{
    self.y = top;
}

- (CGFloat)bottom{
    return self.y + self.height;
}

- (void)setBottom:(CGFloat)bottom{
    self.y = bottom - self.height;
}

- (CGFloat)left{
    return self.x;
}

- (void)setLeft:(CGFloat)left{
    self.x = left;
}

- (CGFloat)right{
    return self.x + self.width;
}

- (void)setRight:(CGFloat)right{
    self.x = right - self.width;
}

- (CGFloat)centerX{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX{
    self.center = CGPointMake(centerX, self.centerY);
}

- (CGFloat)centerY{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY{
    self.center = CGPointMake(self.centerX, centerY);
}

- (void)moveXToCenter{
    UIView* superview = [self superview];
    if (!superview){
        return;
    }
    self.centerX = superview.centerX - superview.left;
}
- (void)moveYToCenter{
    UIView* superview = [self superview];
    if (!superview){
        return;
    }
    self.centerY = superview.centerY - superview.top;
}
- (void)moveToCenter{
    [self moveXToCenter];
    [self moveYToCenter];
}

- (void)moveToLeft{
    [self moveToLeftWithPadding:0];
}
- (void)moveToLeftWithPadding:(CGFloat)padding{
    if (!self.superview){
        return;
    }
    self.left = padding;
}

- (void)moveToRight{
    [self moveToRightWithPadding:0];
}
- (void)moveToRightWithPadding:(CGFloat)padding{
    if (!self.superview){
        return;
    }
    self.right = self.superview.width - padding;
}

- (void)moveToTop{
    [self moveToTopWithPadding:0];
}
- (void)moveToTopWithPadding:(CGFloat)padding{
    if (!self.superview){
        return;
    }
    self.top = padding;
}

- (void)moveToBottom{
    [self moveToBottomWithPadding:0];
}
- (void)moveToBottomWithPadding:(CGFloat)padding{
    if (!self.superview){
        return;
    }
    self.bottom = self.superview.height - padding;
}

- (void)moveToLeftOfView:(UIView*)view{
    [self moveToLeftOfView:view margin:0];
}
- (void)moveToLeftOfView:(UIView*)view margin:(CGFloat)margin{
    if (self.superview != view.superview){
        return;
    }
    self.right = view.left - margin;
}

- (void)moveToRightOfView:(UIView*)view{
    [self moveToRightOfView:view margin:0];
}
- (void)moveToRightOfView:(UIView*)view margin:(CGFloat)margin{
    if (self.superview != view.superview){
        return;
    }
    self.left = view.right + margin;
}

- (void)moveToTopOfView:(UIView*)view{
    [self moveToTopOfView:view margin:0];
}
- (void)moveToTopOfView:(UIView*)view margin:(CGFloat)margin{
    if (self.superview != view.superview){
        return;
    }
    self.bottom = view.top - margin;
}

- (void)moveToBottomOfView:(UIView*)view{
    [self moveToBottomOfView:view margin:0];
}

- (void)moveToBottomOfView:(UIView*)view margin:(CGFloat)margin{
    if (self.superview != view.superview){
        return;
    }
    self.top = view.bottom + margin;
}

- (NSString*)frameDescription{
    return CGRectDescription(self.frame);
}

@end

NSString* CGRectDescription(CGRect rect){
    return [NSString stringWithFormat:@"x : %f\n y : %f\n width : %f\n height : %f",
            rect.origin.x, rect.origin.y, rect.size.width, rect.size.height];
}
