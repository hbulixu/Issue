//
//  NSString+URLAddition.h
//  iDongNe
//
//  Created by 건우 최 on 12. 5. 10..
//  Copyright (c) 2012년 6566gun@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URLAddition)

-(NSString *)URLEncodedStringWithEncoding:(NSStringEncoding)encoding;
- (NSDictionary*)urlParameters;
@end
