//
//  HTAsyncOperation.m
//  iDC
//
//  Created by 건우 최 on 12. 1. 25..
//  Copyright (c) 2012년 Unplug. All rights reserved.
//

#import "HTAsyncOperation.h"
#import "NSOperationQueue+Global.h"

@interface HTAsyncOperation()

@end

@implementation HTAsyncOperation
@synthesize executing=_executing;
@synthesize finished=_finished;

- (id)init{
    self = [super init];
    if (self){
        self.executing = NO;
        self.finished = NO;
    }
    return self;
}

#pragma mark - Public methods
#pragma mark Getters and Setters

- (BOOL)isConcurrent{
    return YES;
}

- (void)setExecuting:(BOOL)executing{
    if (_executing == executing){
        return;
    }
    [self willChangeValueForKey:@"isExecuting"];
    _executing = executing;
    [self didChangeValueForKey:@"isExecuting"];
}

- (void)setFinished:(BOOL)finished{
    if (_finished == finished){
        return;
    }
    [self willChangeValueForKey:@"isFinished"];
    _finished = finished;
    [self didChangeValueForKey:@"isFinished"];
}

- (void)setCancelled:(BOOL)cancelled{
    if (_cancelled == cancelled) {
        return;
    }
    [self willChangeValueForKey:@"isCancelled"];
    _cancelled = cancelled;
    [self didChangeValueForKey:@"isCancelled"];
}

- (void)cancel{
    [super cancel];
    self.cancelled = YES;
}

#pragma mark - Overrides
#pragma mark NSOperation
- (void)start{
    self.executing = YES;
    self.finished = NO;
}

- (void)startAsync{
    NSOperationQueue* globalQueue = [NSOperationQueue htGlobalQueue];
    [globalQueue addOperation:self];
}

@end
