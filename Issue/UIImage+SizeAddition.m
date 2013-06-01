//
//  UIImage+SizeAddition.m
//  iDC
//
//  Created by 건우 최 on 12. 1. 11..
//  Copyright (c) 2012년 Unplug. All rights reserved.
//

#import "UIImage+SizeAddition.h"

@implementation UIImage (SizeAddition)
@dynamic width;
@dynamic height;

- (CGFloat)width{
    return self.size.width;
}

- (CGFloat)height{
    return self.size.height;
}

@end
