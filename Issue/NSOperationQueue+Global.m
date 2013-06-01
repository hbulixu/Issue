//
//  NSOperationQueue+Global.m
//  HTLibrary
//
//  Created by 건우 최 on 12. 1. 15..
//  Copyright (c) 2012년 Unplug. All rights reserved.
//

#import "NSOperationQueue+Global.h"

@implementation NSOperationQueue (Global)
static NSOperationQueue* global = nil;
+ (NSOperationQueue*)htGlobalQueue{
    @synchronized(self){
        if (global == nil){
            global = [[[self class] alloc] init];
        }
    }
    return global;
}
@end