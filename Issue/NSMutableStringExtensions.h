//
//  NSMutableStringExtensions.h
//  DC
//
//  Created by 최건우 on 11. 2. 2..
//  Copyright 2011 Unplug. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSMutableString (NSMutableStringExtensions)
- (void)xmlSimpleUnescape;
- (void)xmlSimpleEscape;
@end
