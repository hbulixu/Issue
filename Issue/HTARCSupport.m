//
//  HTARCSupport.m
//  iDC
//
//  Created by 건우 최 on 12. 1. 25..
//  Copyright (c) 2012년 Unplug. All rights reserved.
//

#import "HTARCSupport.h"

@implementation NSObject (ARCSupport)
- (id)__donothing{
    return self;
}
- (id)strong{
    return self;
}
- (void)__dealloc{
    // Do Nothing
}
@end
