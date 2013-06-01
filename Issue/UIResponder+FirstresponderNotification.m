//
//  UIResponder+FirstresponderNotification.m
//  meety_ios
//
//  Created by 최건우 on 12. 10. 13..
//  Copyright (c) 2012년 Meety. All rights reserved.
//

#import "UIResponder+FirstresponderNotification.h"
#import "NSObject+HijackMethod.h"

@implementation UIResponder (FirstresponderNotification)

+ (void)hijackFirstResponderMethod{
    [self hijackSelector:@selector(becomeFirstResponder) withSelector:@selector(becomeFirstResponder_)];
}

- (BOOL)becomeFirstResponder_{
    BOOL result = [self becomeFirstResponder_];
    if (result) {
        [[NSNotificationCenter defaultCenter] postNotificationName:UIResponderDidChangeFirstResponderNotification object:self];
    }
    return result;
}

@end
