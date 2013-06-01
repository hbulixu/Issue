//
//  UIScrollView+Paging.h
//  FunnySound
//
//  Created by 최건우 on 11. 6. 5..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#define roundToInteger(x)  x >= 0 ? ((NSInteger) ((x) + 0.5)) : ((NSInteger) ((x) - 0.5))


@interface UIScrollView (Paging)
+ (NSInteger) pageWithIndex:(NSInteger)idx size:(NSInteger)size;
+ (NSInteger) indexAtPage:(NSInteger)page size:(NSInteger)size;
- (CGRect) frameAtIndex:(NSInteger)idx cols:(NSInteger)cols rows:(NSInteger)rows itemSize:(CGSize)itemSize gapSize:(CGSize)gapSize;
- (CGRect) virticalPositionAtIndex:(NSInteger)idx cols:(NSInteger)cols rows:(NSInteger)rows itemSize:(CGSize)itemSize gapSize:(CGSize)gapSize;
- (CGRect) horizontalPositionAtIndex:(NSInteger)idx cols:(NSInteger)cols rows:(NSInteger)rows itemSize:(CGSize)itemSize gapSize:(CGSize)gapSize;
- (CGPoint)offsetForHorizontalIndex:(NSUInteger)index;
- (CGPoint)offsetForVerticalIndex:(NSUInteger)index;
- (NSUInteger)horizontalPageForOffset:(CGPoint)offset;
- (NSUInteger)verticalPageForOffset:(CGPoint)offset;

@property (nonatomic) NSInteger horizontalPages;
@property (nonatomic) NSInteger currentHorizontalPage;

- (void)setCurrentHorizontalPage:(NSInteger)page animated:(BOOL)animated;

@end
