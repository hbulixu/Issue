//
//  MeetyClipView.h
//  MeetyClipView
//
//  Created by 최건우 on 12. 10. 10..
//  Copyright (c) 2012년 최건우. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface MeetyClipView : UIView

@property (nonatomic, strong) IBOutlet UIView* contentView;

// MeetyClippedViewController's subclass, default is MeetyClippedViewController
@property (nonatomic, strong) Class clippedViewControllerClass;

@property (nonatomic) NSTimeInterval fullscreenAnimationDuration;
- (void)presentContentViewInModalViewControllerAnimated:(BOOL)animated withViewController:(UIViewController*)viewController;
- (void)dismissModalViewControllerContainsContentViewAnimated:(BOOL)animated;
- (CGRect)frameForContentView;

@end
