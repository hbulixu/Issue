//
//  HTLinearView.h
//  iDC
//
//  Created by 건우 최 on 12. 1. 10..
//  Copyright (c) 2012년 Unplug. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTLinearView : UIView

@property (nonatomic) UIEdgeInsets padding;
@property (nonatomic) CGFloat innerMargin;

- (void)layoutSubviewsFromIndex:(NSUInteger)index;
- (UIView*)prevSubview:(UIView*)view;
- (UIView*)nextSubview:(UIView*)view;
- (UIView*)subviewAtIndex:(NSUInteger)index;
- (NSUInteger)indexOfSubview:(UIView*)view;
@end
