//
//  UIColor+Addtions.h
//  YoureMyPet
//
//  Created by 건우 최 on 12. 1. 11..
//  Copyright (c) 2012년 Unplug. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Addtions)

+ (UIColor*)colorWithRGBHex:(NSInteger)hex alpha:(CGFloat)alpha;
+ (UIColor*)colorWithIntegerRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha;

@end
