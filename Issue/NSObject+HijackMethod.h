//
//  NSObject+HijackMethod.h
//  meety_ios
//
//  Created by 최건우 on 12. 10. 13..
//  Copyright (c) 2012년 Meety. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (HijackMethod)

+ (void)hijackSelector:(SEL)originalSelector withSelector:(SEL)newSelector;

@end
