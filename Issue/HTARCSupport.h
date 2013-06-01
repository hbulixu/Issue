//
//  HTARCSupport.h
//  iDC
//
//  Created by 건우 최 on 12. 1. 25..
//  Copyright (c) 2012년 Unplug. All rights reserved.
//

#import <Foundation/Foundation.h>


#if __has_feature(objc_arc)
#define release __donothing
#define autorelease __donothing
#define retain strong
#define dealloc __dealloc
#endif

@interface NSObject (ARCSupport)
- (id)__donothing;
- (id)strong;
- (void)__dealloc;
@end
