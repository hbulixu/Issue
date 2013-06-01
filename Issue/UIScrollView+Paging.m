//
//  UIScrollView+Paging.m
//  FunnySound
//
//  Created by 최건우 on 11. 6. 5..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIScrollView+Paging.h"
#import "UIView+FrameAddition.h"

@implementation UIScrollView (Paging)
@dynamic horizontalPages;
@dynamic currentHorizontalPage;

#pragma mark - Class methods
+ (NSInteger) pageWithIndex:(NSInteger)idx size:(NSInteger)size{
    return idx / size;
}
+ (NSInteger) indexAtPage:(NSInteger)idx size:(NSInteger)size{
    return idx % size;
}

#pragma public methods
- (CGRect) frameAtIndex:(NSInteger)idx cols:(NSInteger)cols rows:(NSInteger)rows itemSize:(CGSize)itemSize gapSize:(CGSize)gapSize{
    CGFloat pageWidth = self.frame.size.width;
    CGFloat pageHeight = self.frame.size.height;
    
    CGFloat itemWidth = itemSize.width;
    CGFloat itemHeight = itemSize.height;
    CGFloat gapX = gapSize.width;
    CGFloat gapY = gapSize.height;
    NSInteger currentPage = [[self class] pageWithIndex:idx size:cols*rows];
    NSInteger xCount = (idx - currentPage * cols * rows) % cols;
    NSInteger yCount = (idx - currentPage * cols * rows) / cols;
    
    CGFloat marginLeft = (pageWidth - (itemWidth * cols + gapX * (cols - 1))) / 2; // Base Margin
    marginLeft += itemWidth * xCount; // Items Width
    marginLeft += gapX * xCount;       // Gap Width
    
    CGFloat marginTop = (pageHeight - (itemHeight * rows + gapY * (rows - 1))) / 2;
    marginTop += itemHeight * yCount; // Items Height
    marginTop += gapY * yCount;        // Gap Height
    
    return CGRectMake(marginLeft, marginTop, itemWidth, itemHeight);
}


- (CGRect) virticalPositionAtIndex:(NSInteger)idx cols:(NSInteger)cols rows:(NSInteger)rows itemSize:(CGSize)itemSize gapSize:(CGSize)gapSize{
    CGRect frame = [self frameAtIndex:idx cols:cols rows:rows itemSize:itemSize gapSize:gapSize];
    frame.origin.y += [[self class] pageWithIndex:idx size:rows*cols] * rows * itemSize.height;
    
    CGFloat pageHeight = self.frame.size.height;
    CGFloat itemHeight = itemSize.height;
    CGFloat gapY = gapSize.height;
    CGFloat marginTop = (pageHeight - (itemHeight * rows + gapY * (rows - 1))) / 2;
    frame.origin.y -= marginTop;
    return frame;
}

- (CGRect) horizontalPositionAtIndex:(NSInteger)idx cols:(NSInteger)cols rows:(NSInteger)rows itemSize:(CGSize)itemSize gapSize:(CGSize)gapSize{
    CGRect frame = [self frameAtIndex:idx cols:cols rows:rows itemSize:itemSize gapSize:gapSize];
    frame.origin.x += [[self class] pageWithIndex:idx size:rows*cols] * self.frame.size.width;
    return frame;
}


- (CGPoint)offsetForHorizontalIndex:(NSUInteger)index{
    return CGPointMake(self.width * (index - 1), 0);
}
- (CGPoint)offsetForVerticalIndex:(NSUInteger)index{
    return CGPointMake(0, self.height * (index - 1));
}

- (NSUInteger)horizontalPageForOffset:(CGPoint)offset{
    NSInteger page = offset.x / self.width + 1;
    if (page < 1) {
        return 1;
    }
    return page;
}

- (NSUInteger)verticalPageForOffset:(CGPoint)offset{
    NSInteger page = offset.y / self.height + 1;
    if (page < 1) {
        return 1;
    }
    return page;
}

#pragma mark - Getter and Setter

- (NSInteger)horizontalPages{
    CGFloat mod = self.contentSize.width;
    while (mod > self.frame.size.width){
        mod -= self.frame.size.width;
    }
    return (NSInteger)((self.contentSize.width / self.frame.size.width) - ((mod == 0.0f) ? 1 : 0));
}

- (void)setHorizontalPages:(NSInteger)horizontalPages{
    self.contentSize = CGSizeMake(self.frame.size.width * horizontalPages, self.frame.size.height);
}

- (NSInteger)currentHorizontalPage{
    return roundToInteger((self.contentOffset.x / self.frame.size.width));
}

- (void)setCurrentHorizontalPage:(NSInteger)page animated:(BOOL)animated{
    [self setContentOffset:CGPointMake(page * self.frame.size.width, 0) animated:animated];
}

- (void)setCurrentHorizontalPage:(NSInteger)currentHorizontalPage{
    [self setCurrentHorizontalPage:currentHorizontalPage animated:NO];
}

@end
