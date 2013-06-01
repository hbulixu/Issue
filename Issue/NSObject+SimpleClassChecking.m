//
//  NSObject+SimpleClassChecking.m
//  meety_ios
//
//  Created by 최건우 on 12. 10. 27..
//  Copyright (c) 2012년 Meety. All rights reserved.
//

#import "NSObject+SimpleClassChecking.h"

@implementation NSObject (SimpleClassChecking)

- (BOOL)isErrorObject{
    return [self isKindOfClass:[NSError class]];
}

- (BOOL)isDictionaryObject{
    return [self isKindOfClass:[NSDictionary class]];
}

- (BOOL)isArrayObject{
    return [self isKindOfClass:[NSArray class]];
}

- (BOOL)isNullObject{
    return [self isKindOfClass:[NSNull class]];
}

@end
