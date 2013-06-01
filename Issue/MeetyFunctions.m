//
//  MeetyFunctions.m
//  meety_ios
//
//  Created by 최건우 on 12. 10. 27..
//  Copyright (c) 2012년 Meety. All rights reserved.
//

#import "MeetyFunctions.h"


CGSize CGSizeResizeWithWidth(CGSize size, CGFloat width){
    if (size.width == 0){
        return CGSizeMake(0, size.height);
    }
    CGFloat p = width / size.width;
    size.width = width;
    size.height = floorf(size.height * p);
    return size;
}

CGSize CGSizeResizeWithHeight(CGSize size, CGFloat height){
    if (size.height == 0){
        return CGSizeMake(size.width, 0);
    }
    CGFloat p = height / size.height;
    size.height = height;
    size.width = floorf(size.width * p);
    return size;
}

CGSize CGSizeResizeToFit(CGSize size, CGSize toFit){
    size = CGSizeResizeWithWidth(size, toFit.width);
    if (size.height > toFit.height) {
        size = CGSizeResizeWithHeight(size, toFit.height);
    }
    return size;
}

NSArray* MeetyShiftedBitsForUInteger(NSUInteger value){
    NSUInteger l = floorf(log2f(NSIntegerMax)) + 1;
    NSMutableArray* array = [NSMutableArray array];
    for (NSUInteger i = 0; i < l; i++) {
        NSUInteger check = 1 << i;
        if (MeetyContains(check, value)) {
            [array addObject:[NSNumber numberWithUnsignedInteger:check]];
        }
    }
    return [NSArray arrayWithArray:array];
}