//
//  NSDictionary+URLExtensions.h
//  iDC
//
//  Created by 건우 최 on 11. 12. 31..
//  Copyright (c) 2011년 Unplug. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (URLExtensions)
- (NSString*)urlEncodeWithEncoding:(NSStringEncoding)encoding;
- (NSString*)sortedURLEncodeWithEncoding:(NSStringEncoding)encoding;
@end
