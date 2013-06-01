//
//  NSMutableArray+StackAndQueue.h
//  DC
//
//  Created by 최건우 on 11. 3. 28..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSMutableArray (StackAndQueue)

- (void)push:(id)obj;
- (id)pop;
- (void)enqueue:(id)obj;
- (id)dequeue;

@end
