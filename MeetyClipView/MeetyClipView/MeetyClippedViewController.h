//
//  MeetyClippedViewController.h
//  MeetyClipView
//
//  Created by 최건우 on 12. 10. 10..
//  Copyright (c) 2012년 최건우. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeetyClipView.h"

@interface MeetyClippedViewController : UIViewController

@property (nonatomic, strong) MeetyClipView* clipView;
@property (nonatomic, strong) UIView* contentView;
@property (nonatomic, strong) UIColor* maskColor;
@property (nonatomic) NSTimeInterval animationDuration;

- (id)initWitClipView:(MeetyClipView*)clipView;

- (void)presentWithViewController:(UIViewController*)viewController animated:(BOOL)animated;
- (void)dismissClippedViewControllerAnimated:(BOOL)animated;

// Override points, You must move them to same frame & view that you return
- (UIView*)superviewForContentView:(UIView*)contentView;
- (CGRect)frameForContentViewInItsSuperview:(UIView*)superview contentView:(UIView*)contentView;

// Override point, called when animation finished or needs arrangement
- (void)layoutContentView:(UIView*)contentView animated:(BOOL)animated;

// Override points
- (void)appearingWillStart;
- (void)appearingDidFinish;
- (void)disAppearingWillStart;
- (void)disAppearingDidFinish;
@end
