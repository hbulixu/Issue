//
//  HTHorizontalView.m
//  iDC
//
//  Created by 건우 최 on 12. 1. 11..
//  Copyright (c) 2012년 Unplug. All rights reserved.
//

#import "HTHorizontalView.h"
#import "UIView+FrameAddition.h"

@implementation HTHorizontalView

#pragma mark - Private methods

- (void)resizeSubview:(UIView*)view{
    CGFloat newHeight = self.height - (self.padding.top + self.padding.bottom);
    float magnification = view.height / newHeight;
    view.height = newHeight;
    view.width *= magnification;
    view.top = self.padding.top;
}

- (void)__htHorizontalViewInternalInit{
//    self.backgroundColor = [UIColor redColor];
}

#pragma mark - Initializers

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self __htHorizontalViewInternalInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self){
        [self __htHorizontalViewInternalInit];
    }
    return self;
}

#pragma mark - Instance methods

#pragma mark Overrides

- (void)layoutSubviewsFromIndex:(NSUInteger)index{
    [super layoutSubviewsFromIndex:index];
    if (index >= [self.subviews count]){
        return;
    }
    CGFloat width = self.padding.left + self.padding.right;
    
    for (NSUInteger i = 0; i < index; i++){
        width += [[self.subviews objectAtIndex:i] width];
    }
    
    if (index == 0){
        UIView* firstView = [self subviewAtIndex:index];
        firstView.left = self.padding.left;
        if (self.autoresizesSubviews){
            [self resizeSubview:firstView];
        }
        if (self.subviews.count > 1){
            [self layoutSubviewsFromIndex:1];
        }
        width += firstView.width;
    }else{
        NSUInteger i = index; // index is fixed value
        UIView* prev = [self subviewAtIndex:index-1];
        UIView* view = [self subviewAtIndex:index];
        while(YES){
            view.left = prev.right + self.innerMargin;
            if (self.autoresizesSubviews){
                [self resizeSubview:view];
            }
            width += view.width + self.innerMargin;
            prev = view;
            view = [self subviewAtIndex:++i];
            if (!view){
                width -= self.innerMargin;
                break;
            }
        }
    }
    self.width = width;
}

- (void)didAddSubview:(UIView *)subview{
    [super didAddSubview:subview];
    [subview moveYToCenter];
}

@end
