//
//  MeetyClipView.m
//  MeetyClipView
//
//  Created by 최건우 on 12. 10. 10..
//  Copyright (c) 2012년 최건우. All rights reserved.
//

#import "MeetyClipView.h"
#import "MeetyClippedViewController.h"

@interface MeetyClipView ()

@property (nonatomic, strong) MeetyClippedViewController* fullScreenViewController;

@end

@implementation MeetyClipView
@synthesize contentView=_contentView;

#pragma mark - Private methods

- (void)meetyClipViewInternalInit{
    self.fullscreenAnimationDuration = 0.6;
    self.contentView = [[UIView alloc] initWithFrame:[self bounds]];
    self.clipsToBounds = YES;
    self.clippedViewControllerClass = [MeetyClippedViewController class];
    [self addSubview:self.contentView];
}

#pragma mark - Initalizers

- (id)init{
    self = [super init];
    if (self) {
        [self meetyClipViewInternalInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self meetyClipViewInternalInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self meetyClipViewInternalInit];
    }
    return self;
}

#pragma mark - Public methods

- (void)presentContentViewInModalViewControllerAnimated:(BOOL)animated withViewController:(UIViewController*)viewController{
    self.fullScreenViewController = [[self.clippedViewControllerClass alloc] initWitClipView:self];
    self.fullScreenViewController.animationDuration = self.fullscreenAnimationDuration;
    [self.fullScreenViewController presentWithViewController:viewController animated:animated];
}

- (void)dismissModalViewControllerContainsContentViewAnimated:(BOOL)animated{
    [self.fullScreenViewController dismissClippedViewControllerAnimated:animated];
    self.fullScreenViewController = nil;
}

- (CGRect)frameForContentView{
    CGRect frame = [self bounds];
    CGRect contentFrame = self.contentView.frame;
    
    // Fitting width
    CGFloat ratio;
    if (contentFrame.size.width == 0) {
        return CGRectMake(0, 0, 0, MIN(contentFrame.size.height, frame.size.height));
    } else{
        ratio = frame.size.width / contentFrame.size.width;
    }
    if (frame.size.height > contentFrame.size.height * ratio) {
        // Fitting height
        
        if (contentFrame.size.height == 0) {
            return CGRectMake(0, 0, MIN(contentFrame.size.width, frame.size.width), 0);
        } else{
            ratio = frame.size.height / contentFrame.size.height;
        }
    }
    CGFloat width = floorf(contentFrame.size.width * ratio);
    CGFloat height = floorf(contentFrame.size.height * ratio);
    
    // Placing
    CGFloat x = (frame.size.width - width) / 2;
    CGFloat y = (frame.size.height - height) / 2;
    
    return CGRectMake(x, y, width, height);
}

#pragma mark - Getters and Setters

- (void)setContentView:(UIView *)contentView{
    [_contentView removeFromSuperview];
    _contentView = contentView;
    [self addSubview:_contentView];
    [self layoutSubviews];
}

#pragma mark - Overrides
#pragma mark UIView overrides

- (void)layoutSubviews{
    [super layoutSubviews];
    
    // Apply
    self.contentView.frame = [self frameForContentView];
}

@end
