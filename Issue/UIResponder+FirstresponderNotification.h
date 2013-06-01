//
//  UIResponder+FirstresponderNotification.h
//  meety_ios
//
//  Created by 최건우 on 12. 10. 13..
//  Copyright (c) 2012년 Meety. All rights reserved.
//

#import <UIKit/UIKit.h>
__unused static NSString *const UIResponderDidChangeFirstResponderNotification = @"kr.meety.UIResponderDidChangeFirstResponderNotification";

@interface UIResponder (FirstresponderNotification)

- (BOOL)becomeFirstResponder_;
+ (void)hijackFirstResponderMethod;

@end
