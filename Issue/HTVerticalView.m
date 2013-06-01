//
//  HTVerticalView.m
//  iDC
//
//  Created by 건우 최 on 12. 1. 11..
//  Copyright (c) 2012년 Unplug. All rights reserved.
//

#import "HTVerticalView.h"
#import "UIView+FrameAddition.h"

@implementation HTVerticalView

#pragma mark - Private methods

- (void)resizeSubview:(UIView*)view{
    CGFloat newWidth = self.width - (self.padding.left + self.padding.right);
    float magnification = view.width / newWidth;
    view.width = newWidth;
    view.height *= magnification;
    view.left = self.padding.left;
}

- (void)__htVerticalViewInternalInit{
//    self.backgroundColor = [UIColor blueColor];
}

#pragma mark - Initializers

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self __htVerticalViewInternalInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self __htVerticalViewInternalInit];
    }
    return self;
}

#pragma mark - Instance methods

#pragma mark Overrides

- (void)layoutSubviewsFromIndex:(NSUInteger)index{
    [super layoutSubviewsFromIndex:index];
    if (index >= [self.subviews count]) {
        return;
    }
    CGFloat height = self.padding.top + self.padding.bottom;
    
    for (NSUInteger i = 0; i < index; i++) {
        height += [[self.subviews objectAtIndex:i] height];
    }
    
    if (index == 0) {
        UIView* topView = [self subviewAtIndex:index];
        topView.top = self.padding.top;
        if(self.autoresizesSubviews){
            [self resizeSubview:topView];
        }
        if (self.subviews.count > 1) {
            [self layoutSubviewsFromIndex:1];
        }
        height += topView.height;
    }else{
        NSUInteger i = index; // index is fixed value
        UIView* prev = [self subviewAtIndex:index-1];
        UIView* view = [self subviewAtIndex:index];
        height = prev.bottom + self.padding.bottom;
        while(YES){
            view.top = prev.bottom + self.innerMargin;
            if (self.autoresizesSubviews) {
                [self resizeSubview:view];
            }
            height += view.height + self.innerMargin;
            prev = view;
            view = [self subviewAtIndex:++i];
            if (!view) {
                break;
            }
        }
    }
    self.height = height;
}

- (void)didAddSubview:(UIView *)subview{
    [super didAddSubview:subview];
    [subview moveXToCenter];
}

@end
