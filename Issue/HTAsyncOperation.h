//
//  HTAsyncOperation.h
//  iDC
//
//  Created by 건우 최 on 12. 1. 25..
//  Copyright (c) 2012년 Unplug. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTAsyncOperation : NSOperation

@property (nonatomic, getter=isExecuting, assign) BOOL executing;
@property (nonatomic, getter=isFinished, assign) BOOL finished;
@property (nonatomic, getter=isCancelled, assign) BOOL cancelled;
- (void)startAsync;
@end
