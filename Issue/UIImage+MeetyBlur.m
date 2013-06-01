//
//  UIImage+MeetyBlur.m
//  meety_ios
//
//  Created by 최건우 on 13. 2. 17..
//  Copyright (c) 2013년 Meety. All rights reserved.
//

#import "UIImage+MeetyBlur.h"
#import "UIImage+StackBlur.h"
#import "UIImage+Brightness.h"
#import "UIImage+MeetyProcess.h"

@implementation UIImage (MeetyBlur)

- (UIImage *)meetyBlurImage{
    static CGSize windowSize;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        windowSize = [[[UIApplication sharedApplication] keyWindow] size];
    });

    CGSize converted = CGSizeResizeToFit(self.size, windowSize);
    CGFloat inroudious;
    if (converted.width == windowSize.width) {
        inroudious = self.width;
    } else {
        inroudious = self.height;
    }
    
    inroudious *= 1.5f / 100;
    return [[[self fixOrientation] stackBlur:inroudious] imageWithBrightness:-0.6];
}

@end
