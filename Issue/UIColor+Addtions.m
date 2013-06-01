//
//  UIColor+Addtions.m
//  YoureMyPet
//
//  Created by 건우 최 on 12. 1. 11..
//  Copyright (c) 2012년 Unplug. All rights reserved.
//

#import "UIColor+Addtions.h"
#define logB(x, base) (log((x))/ log((base)))
#define hexlen(hex) ((NSInteger)(logB((hex), 16) + 1))

@implementation UIColor (Addtions)

+ (UIColor*)colorWithRGBHex:(NSInteger)hex alpha:(CGFloat)alpha{
    if (hexlen(hex) > 6){
        return nil;
    }
    NSInteger redhex,greenhex,bluehex;
    bluehex = hex % 16;
    greenhex = (hex/16) % 16;
    redhex = (hex/(16^2)) ^ 16;
    CGFloat red,green,blue;
    red = ((CGFloat)redhex) / 0xff;
    green = ((CGFloat)greenhex) / 0xff;
    blue = ((CGFloat)bluehex) / 0xff;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor*)colorWithIntegerRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha{
    CGFloat colorMax = 255.0f;
    return [UIColor colorWithRed:red / colorMax green:green / colorMax blue:blue / colorMax alpha:alpha];
}
@end
