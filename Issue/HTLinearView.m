//
//  HTLinearView.m
//  iDC
//
//  Created by 건우 최 on 12. 1. 10..
//  Copyright (c) 2012년 Unplug. All rights reserved.
//

#import "HTLinearView.h"

@implementation HTLinearView
@synthesize padding;
@synthesize innerMargin;

#pragma mark - Private methods

- (void)__htLinearViewInternalInit{
    self.padding = UIEdgeInsetsZero;
    self.innerMargin = 0.0f;
}

#pragma mark - Iniitalizers;

- (id)init{
    self = [super init];
    if (self){
        [self __htLinearViewInternalInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self __htLinearViewInternalInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self){
        [self __htLinearViewInternalInit];
    }
    return self;
}

#pragma mark - Instance methods

- (void)layoutSubviewsFromIndex:(NSUInteger)index{
    // Override it
}
- (UIView*)prevSubview:(UIView*)view{
    NSUInteger index = [self indexOfSubview:view];
    if (index == NSNotFound || index == 0){
        return nil;
    }
    return [self subviewAtIndex:index - 1];
}

- (UIView*)nextSubview:(UIView*)view{
    NSUInteger index = [self indexOfSubview:view];
    if (index == NSNotFound){
        return nil;
    }
    return [self subviewAtIndex:index + 1];
}

- (UIView*)subviewAtIndex:(NSUInteger)index{
    if (index == NSNotFound || !(index < self.subviews.count)){
        return nil;
    }
    return [self.subviews objectAtIndex:index];
}

- (NSUInteger)indexOfSubview:(UIView *)view{
    return [self.subviews indexOfObject:view];
}

#pragma mark Overrides
- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index{
    [super insertSubview:view atIndex:index];
    [self layoutSubviewsFromIndex:index];
}
- (void)exchangeSubviewAtIndex:(NSInteger)index1 withSubviewAtIndex:(NSInteger)index2{
    NSUInteger index = MIN(index1, index2);
    [super exchangeSubviewAtIndex:index1 withSubviewAtIndex:index2];
    [self layoutSubviewsFromIndex:index];
}

- (void)addSubview:(UIView *)view{
    [super addSubview:view];
    [self layoutSubviewsFromIndex:[self indexOfSubview:view]];
}
- (void)insertSubview:(UIView *)view belowSubview:(UIView *)siblingSubview{
    [super insertSubview:view belowSubview:siblingSubview];
    NSUInteger index = [self.subviews indexOfObject:view];
    if (index != NSNotFound){
        [self layoutSubviewsFromIndex:index];
    }
}
- (void)insertSubview:(UIView *)view aboveSubview:(UIView *)siblingSubview{
    [super insertSubview:view aboveSubview:siblingSubview];
    NSUInteger index = [self.subviews indexOfObject:view];
    if (index != NSNotFound){
        [self layoutSubviewsFromIndex:index];
    }
}

- (void)bringSubviewToFront:(UIView *)view{
    [super bringSubviewToFront:view];
    [self layoutSubviewsFromIndex:0];
}
- (void)sendSubviewToBack:(UIView *)view{
    NSUInteger index = [self.subviews indexOfObject:view];
    [super sendSubviewToBack:view];
    if (index != NSNotFound){
        [self layoutSubviewsFromIndex:index];
    }
}


- (void)layoutSubviews{// override point. called by layoutIfNeeded automatically. base implementation does nothing
    [super layoutSubviews];
}

@end
