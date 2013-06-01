//
//  MeetyClippingAnimationViewController.h
//  MeetyClipView
//
//  Created by 최건우 on 12. 10. 11..
//  Copyright (c) 2012년 최건우. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeetyClippingAnimationViewController : UIViewController

@property (nonatomic, strong) void(^viewDidAppearBlock)(MeetyClippingAnimationViewController* viewController);
@property (nonatomic, strong) void(^viewDidDisappearBlock)(MeetyClippingAnimationViewController* viewController);
@property (nonatomic, strong) UIViewController* viewController;

@end
