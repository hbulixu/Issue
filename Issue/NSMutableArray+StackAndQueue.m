//
//  NSMutableArray+StackAndQueue.m
//  DC
//
//  Created by 최건우 on 11. 3. 28..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSMutableArray+StackAndQueue.h"


@implementation NSMutableArray (StackAndQueue)

- (void)push:(id)obj{
    [self addObject:obj];
}
- (id)pop{
    if ([self count]){
        id obj = [self lastObject];
        [self removeLastObject];
        return obj;
    }
    return nil;
}
- (void)enqueue:(id)obj{
    [self push:obj];
}
- (id)dequeue{
    if ([self count]){
        id obj = [self objectAtIndex:0];
        [self removeObjectAtIndex:0];
        return obj;
    }
    return nil;
}

@end
