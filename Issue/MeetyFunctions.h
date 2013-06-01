//
//  MeetyFunctions.h
//  meety_ios
//
//  Created by 최건우 on 12. 10. 27..
//  Copyright (c) 2012년 Meety. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MeetyContains(sub, super) (((super)&(sub))==(sub))

CGSize CGSizeResizeToFit(CGSize size, CGSize toFit);
CGSize CGSizeResizeWithWidth(CGSize size, CGFloat width);
CGSize CGSizeResizeWithHeight(CGSize size, CGFloat height);
NSArray* MeetyShiftedBitsForUInteger(NSUInteger value);