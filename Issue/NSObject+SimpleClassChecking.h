//
//  NSObject+SimpleClassChecking.h
//  meety_ios
//
//  Created by 최건우 on 12. 10. 27..
//  Copyright (c) 2012년 Meety. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (SimpleClassChecking)

- (BOOL)isErrorObject;
- (BOOL)isDictionaryObject;
- (BOOL)isArrayObject;
- (BOOL)isNullObject;

@end
