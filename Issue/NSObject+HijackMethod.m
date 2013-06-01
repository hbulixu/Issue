//
//  NSObject+HijackMethod.m
//  meety_ios
//
//  Created by 최건우 on 12. 10. 13..
//  Copyright (c) 2012년 Meety. All rights reserved.
//

#import "NSObject+HijackMethod.h"
#import <objc/runtime.h>

@implementation NSObject (HijackMethod)


+ (void)hijackSelector:(SEL)originalSelector withSelector:(SEL)newSelector{
    Class class = [self class];
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method categoryMethod = class_getInstanceMethod(class, newSelector);
    method_exchangeImplementations(originalMethod, categoryMethod);
}

@end
